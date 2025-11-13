package com.zoedatalab.empleos.iam.application.service;

import com.zoedatalab.empleos.common.provisioning.ApplicantProvisioningPort;
import com.zoedatalab.empleos.common.provisioning.CompanyProvisioningPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.iam.application.dto.ResetPasswordCommand;
import com.zoedatalab.empleos.iam.application.exception.ResetTokenExpiredException;
import com.zoedatalab.empleos.iam.application.exception.ResetTokenInvalidException;
import com.zoedatalab.empleos.iam.application.ports.out.*;
import com.zoedatalab.empleos.iam.domain.PasswordResetToken;
import com.zoedatalab.empleos.iam.domain.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import static com.zoedatalab.empleos.iam.application.service.TestFixtures.activeUser;
import static com.zoedatalab.empleos.iam.application.service.TestFixtures.freshToken;
import static com.zoedatalab.empleos.iam.application.ports.out.NotificationsOutboxPort.Type.PASSWORD_RESET_DONE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthServiceImplResetPasswordTest {

    @Mock private UserRepositoryPort userRepo;
    @Mock private RefreshTokenRepositoryPort refreshRepo;
    @Mock private PasswordEncoderPort passwordEncoder;
    @Mock private TokenServicePort tokenService;
    @Mock private ClockPort clock;
    @Mock private ApplicantProvisioningPort applicantProvisioning;
    @Mock private CompanyProvisioningPort companyProvisioning;
    @Mock private PasswordResetTokenRepositoryPort resetTokenRepo;
    @Mock private NotificationsOutboxPort outbox;

    private AuthServiceImpl service;

    private static final long REFRESH_TTL_SECONDS = 2_592_000L; // 30d
    private static final long RESET_TTL_SECONDS   = 1_800L;     // 30m
    private static final long RESET_RATE_LIMIT_SECONDS = 300L;  // 5m

    private static final Instant NOW = Instant.parse("2025-11-11T16:00:00Z");
    private static final UUID USER_ID = UUID.fromString("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee");
    private static final String EMAIL = "user@job.com";

    @BeforeEach
    void setup() {
        lenient().when(clock.now()).thenReturn(NOW);

        service = new AuthServiceImpl(
                userRepo, refreshRepo, passwordEncoder, tokenService, clock,
                applicantProvisioning, companyProvisioning, REFRESH_TTL_SECONDS,
                resetTokenRepo, outbox, RESET_TTL_SECONDS, RESET_RATE_LIMIT_SECONDS
        );
    }

    @Test
    void missingFields_throwInvalid() {
        assertThatThrownBy(() ->
                service.resetPassword(ResetPasswordCommand.builder()
                        .selector(null).token("t").newPassword("x").build()))
                .isInstanceOf(ResetTokenInvalidException.class);

        assertThatThrownBy(() ->
                service.resetPassword(ResetPasswordCommand.builder()
                        .selector("s").token(null).newPassword("x").build()))
                .isInstanceOf(ResetTokenInvalidException.class);

        assertThatThrownBy(() ->
                service.resetPassword(ResetPasswordCommand.builder()
                        .selector("s").token("t").newPassword(null).build()))
                .isInstanceOf(ResetTokenInvalidException.class);
    }

    @Test
    void selectorNotFound_throwInvalid() {
        when(resetTokenRepo.findActiveBySelector("sel")).thenReturn(Optional.empty());

        assertThatThrownBy(() ->
                service.resetPassword(ResetPasswordCommand.builder()
                        .selector("sel").token("tok").newPassword("NewPass!123").build()))
                .isInstanceOf(ResetTokenInvalidException.class);
    }

    @Test
    void expiredToken_throwExpired() {
        PasswordResetToken prt = freshToken(USER_ID, NOW.minusSeconds(3600), 1);
        when(resetTokenRepo.findActiveBySelector("sel")).thenReturn(Optional.of(prt));

        assertThatThrownBy(() ->
                service.resetPassword(ResetPasswordCommand.builder()
                        .selector("sel").token("tok").newPassword("NewPass!123").build()))
                .isInstanceOf(ResetTokenExpiredException.class);
    }

    @Test
    void usedToken_throwInvalid() {
        PasswordResetToken prt = PasswordResetToken.builder()
                .id(UUID.randomUUID()).userId(USER_ID)
                .selector("sel").verifierHash("$2a$12$hash")
                .expiresAt(NOW.plusSeconds(600))
                .used(true).createdAt(NOW).updatedAt(NOW).build();

        when(resetTokenRepo.findActiveBySelector("sel")).thenReturn(Optional.of(prt));

        assertThatThrownBy(() ->
                service.resetPassword(ResetPasswordCommand.builder()
                        .selector("sel").token("tok").newPassword("NewPass!123").build()))
                .isInstanceOf(ResetTokenInvalidException.class);
    }

    @Test
    void tokenMismatch_throwInvalid() {
        PasswordResetToken prt = freshToken(USER_ID, NOW, 1800);
        when(resetTokenRepo.findActiveBySelector("sel")).thenReturn(Optional.of(prt));
        when(passwordEncoder.matches("tok", prt.getVerifierHash())).thenReturn(false);

        assertThatThrownBy(() ->
                service.resetPassword(ResetPasswordCommand.builder()
                        .selector("sel").token("tok").newPassword("NewPass!123").build()))
                .isInstanceOf(ResetTokenInvalidException.class);
    }

    @Test
    void happyPath_updatesPassword_marksUsed_invalidatesOthers_revokesRefresh_andEnqueues() {
        PasswordResetToken prt = freshToken(USER_ID, NOW, 1800);
        when(resetTokenRepo.findActiveBySelector("sel")).thenReturn(Optional.of(prt));
        when(passwordEncoder.matches("tok", prt.getVerifierHash())).thenReturn(true);

        User user = activeUser(USER_ID, EMAIL, "old-hash");
        when(userRepo.findById(USER_ID)).thenReturn(Optional.of(user));
        when(passwordEncoder.encode("NewPass!123")).thenReturn("new-hash");

        service.resetPassword(ResetPasswordCommand.builder()
                .selector("sel").token("tok").newPassword("NewPass!123").build());

        verify(userRepo).save(argThat(u -> u.getId().equals(USER_ID) && "new-hash".equals(u.getPasswordHash())));
        verify(resetTokenRepo).save(argThat(PasswordResetToken::isUsed));
        verify(resetTokenRepo).invalidateAllForUser(USER_ID);
        verify(refreshRepo).revokeAllByUserId(USER_ID);

        @SuppressWarnings("unchecked")
        ArgumentCaptor<Map<String, Object>> payloadCap = ArgumentCaptor.forClass(Map.class);

        verify(outbox).enqueue(eq(PASSWORD_RESET_DONE), payloadCap.capture());

        Map<String, Object> payload = payloadCap.getValue();

        assertThat(payload)
                .as("Payload de PASSWORD_RESET_DONE debe incluir userId y email")
                .containsKeys("userId", "email");

        assertThat(payload.get("userId")).isEqualTo(USER_ID.toString());
        assertThat(payload.get("email")).isEqualTo(EMAIL);
    }
}
