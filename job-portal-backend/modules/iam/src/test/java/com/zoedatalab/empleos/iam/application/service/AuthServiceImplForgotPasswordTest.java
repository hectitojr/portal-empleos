package com.zoedatalab.empleos.iam.application.service;

import com.zoedatalab.empleos.common.provisioning.ApplicantProvisioningPort;
import com.zoedatalab.empleos.common.provisioning.CompanyProvisioningPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.iam.application.dto.ForgotPasswordCommand;
import com.zoedatalab.empleos.iam.application.ports.out.NotificationsOutboxPort;
import com.zoedatalab.empleos.iam.application.ports.out.PasswordEncoderPort;
import com.zoedatalab.empleos.iam.application.ports.out.PasswordResetTokenRepositoryPort;
import com.zoedatalab.empleos.iam.application.ports.out.RefreshTokenRepositoryPort;
import com.zoedatalab.empleos.iam.application.ports.out.TokenServicePort;
import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import com.zoedatalab.empleos.iam.domain.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import static com.zoedatalab.empleos.iam.application.service.TestFixtures.activeUser;
import static org.assertj.core.api.Assertions.assertThatNoException;
import static org.mockito.Mockito.any;
import static org.mockito.Mockito.anyString;
import static org.mockito.Mockito.argThat;
import static org.mockito.Mockito.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class AuthServiceImplForgotPasswordTest {

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

    private static final Instant NOW = Instant.parse("2025-11-11T15:00:00Z");

    @BeforeEach
    void setup() {
        service = new AuthServiceImpl(
                userRepo, refreshRepo, passwordEncoder, tokenService, clock,
                applicantProvisioning, companyProvisioning, REFRESH_TTL_SECONDS,
                resetTokenRepo, outbox, RESET_TTL_SECONDS, RESET_RATE_LIMIT_SECONDS
        );
    }

    @Test
    void nonExistingEmail_isIdempotent_andSilent() {
        when(userRepo.findByEmail("no@exists.com")).thenReturn(Optional.empty());

        assertThatNoException().isThrownBy(() ->
                service.forgotPassword(ForgotPasswordCommand.builder().email("no@exists.com").build())
        );

        verify(userRepo).findByEmail("no@exists.com");
        verifyNoInteractions(resetTokenRepo, outbox);
    }

    @Test
    void inactiveOrSuspended_user_noOutbox_noToken() {
        User u = User.builder()
                .id(UUID.randomUUID()).email("a@b.com").passwordHash("x")
                .role(com.zoedatalab.empleos.iam.domain.Role.APPLICANT)
                .active(false).suspended(false).build();
        when(userRepo.findByEmail("a@b.com")).thenReturn(Optional.of(u));

        service.forgotPassword(ForgotPasswordCommand.builder().email("a@b.com").build());

        verifyNoInteractions(outbox);
        verify(resetTokenRepo, never()).save(any());
    }

    @SuppressWarnings("unchecked")
    @Test
    void happyPath_generatesToken_andEnqueuesOutbox() {
        // Stubs SÓLO aquí, porque este test sí los usa.
        when(clock.now()).thenReturn(NOW);
        when(passwordEncoder.encode(anyString())).thenReturn("$2a$12$hash");

        var userId = UUID.randomUUID();
        var user = activeUser(userId, "user@job.com", "hash");
        when(userRepo.findByEmail("user@job.com")).thenReturn(Optional.of(user));

        ArgumentCaptor<Map<String, Object>> payloadCap = ArgumentCaptor.forClass(Map.class);

        service.forgotPassword(ForgotPasswordCommand.builder().email("user@job.com").build());

        verify(resetTokenRepo).invalidateAllForUser(userId);
        verify(resetTokenRepo).save(argThat(t ->
                t.getUserId().equals(userId)
                        && !t.isUsed()
                        && t.getExpiresAt().equals(NOW.plusSeconds(RESET_TTL_SECONDS))
        ));

        verify(outbox).enqueue(eq(NotificationsOutboxPort.Type.PASSWORD_RESET_REQUESTED), payloadCap.capture());
        var payload = payloadCap.getValue();

        org.assertj.core.api.Assertions.assertThat(payload)
                .containsKeys("userId", "email", "selector", "token", "expiresAt");
        org.assertj.core.api.Assertions.assertThat(payload.get("userId")).isEqualTo(userId.toString());
        org.assertj.core.api.Assertions.assertThat(payload.get("email")).isEqualTo("user@job.com");
        org.assertj.core.api.Assertions.assertThat((String) payload.get("selector")).isNotBlank();
        org.assertj.core.api.Assertions.assertThat((String) payload.get("token")).isNotBlank();
        org.assertj.core.api.Assertions.assertThat((String) payload.get("expiresAt"))
                .isEqualTo(NOW.plusSeconds(RESET_TTL_SECONDS).toString());
    }
}
