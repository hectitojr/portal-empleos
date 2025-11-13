package com.zoedatalab.empleos.iam.application.service;

import com.zoedatalab.empleos.common.provisioning.ApplicantProvisioningPort;
import com.zoedatalab.empleos.common.provisioning.CompanyProvisioningPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.iam.application.dto.LoginCommand;
import com.zoedatalab.empleos.iam.application.dto.RegisterCommand;
import com.zoedatalab.empleos.iam.application.dto.ForgotPasswordCommand;
import com.zoedatalab.empleos.iam.application.dto.ResetPasswordCommand;
import com.zoedatalab.empleos.iam.application.exception.AuthBadCredentialsException;
import com.zoedatalab.empleos.iam.application.exception.EmailAlreadyExistsException;
import com.zoedatalab.empleos.iam.application.exception.ResetTokenExpiredException;
import com.zoedatalab.empleos.iam.application.exception.ResetTokenInvalidException;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import com.zoedatalab.empleos.iam.application.ports.out.*;
import com.zoedatalab.empleos.iam.domain.PasswordResetToken;
import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.iam.domain.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.time.Instant;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class AuthServiceImplTest {

    private final UserRepositoryPort userRepo = mock(UserRepositoryPort.class);
    private final RefreshTokenRepositoryPort refreshRepo = mock(RefreshTokenRepositoryPort.class);
    private final PasswordEncoderPort passwordEncoder = mock(PasswordEncoderPort.class);
    private final TokenServicePort tokenService = mock(TokenServicePort.class);
    private final ClockPort clock = mock(ClockPort.class);
    private final ApplicantProvisioningPort applicantProvisioning = mock(ApplicantProvisioningPort.class);
    private final CompanyProvisioningPort companyProvisioning = mock(CompanyProvisioningPort.class);
    private final PasswordResetTokenRepositoryPort resetTokenRepo = mock(PasswordResetTokenRepositoryPort.class);
    private final NotificationsOutboxPort outbox = mock(NotificationsOutboxPort.class);

    private static final long REFRESH_TTL_SECONDS = 2_592_000L;      // 30 días
    private static final long RESET_TTL_SECONDS = 1_800L;            // 30 min
    private static final long RESET_RATE_LIMIT_SECONDS = 300L;       // 5 min

    private AuthService service;

    @BeforeEach
    void setup() {
        when(clock.now()).thenReturn(Instant.parse("2025-01-01T00:00:00Z"));

        service = new AuthServiceImpl(
                userRepo,
                refreshRepo,
                passwordEncoder,
                tokenService,
                clock,
                applicantProvisioning,
                companyProvisioning,
                REFRESH_TTL_SECONDS,
                resetTokenRepo,
                outbox,
                RESET_TTL_SECONDS,
                RESET_RATE_LIMIT_SECONDS
        );
    }

    @Test
    void register_conflict_email() {
        when(userRepo.findByEmail("a@a.com")).thenReturn(Optional.of(User.builder().build()));
        assertThrows(EmailAlreadyExistsException.class, () ->
                service.register(RegisterCommand.builder()
                        .email("a@a.com").password("x").role(Role.APPLICANT).build()));
    }

    @Test
    void login_bad_credentials() {
        when(userRepo.findByEmail("a@a.com")).thenReturn(Optional.empty());
        assertThrows(AuthBadCredentialsException.class, () ->
                service.login(LoginCommand.builder().email("a@a.com").password("x").build()));
    }

    @Test
    void login_ok_emite_tokens() {
        var u = User.builder()
                .id(UUID.randomUUID())
                .email("a@a.com")
                .passwordHash("h")
                .role(Role.APPLICANT)
                .active(true)
                .build();

        when(userRepo.findByEmail("a@a.com")).thenReturn(Optional.of(u));
        when(passwordEncoder.matches("pwd", "h")).thenReturn(true);
        when(tokenService.issueAccessToken(Mockito.any())).thenReturn("jwt");
        when(tokenService.accessTokenTtlSeconds()).thenReturn(900L);

        var out = service.login(LoginCommand.builder().email("a@a.com").password("pwd").build());
        assertEquals("jwt", out.getAccessToken());
        assertNotNull(out.getRefreshToken());
    }
    
    @Test
    void forgotPassword_shouldGenerateToken_andEnqueueOutbox() {
        var user = User.builder()
                .id(UUID.randomUUID())
                .email("test@example.com")
                .passwordHash("hash")
                .active(true)
                .suspended(false)
                .createdAt(clock.now())
                .updatedAt(clock.now())
                .build();

        when(userRepo.findByEmail("test@example.com")).thenReturn(Optional.of(user));
        when(passwordEncoder.encode(anyString())).thenReturn("hashed-token");

        service.forgotPassword(new ForgotPasswordCommand("test@example.com"));

        verify(resetTokenRepo).invalidateAllForUser(user.getId());
        verify(resetTokenRepo).save(any(PasswordResetToken.class));

        verify(outbox).enqueue(
                eq(NotificationsOutboxPort.Type.PASSWORD_RESET_REQUESTED),
                argThat((Map<String, Object> m) -> {
                    assertThat(m)
                            .containsEntry("email", "test@example.com")
                            .containsKeys("selector", "token");
                    return true;
                })
        );
    }

    @Test
    void resetPassword_shouldResetPassword_andInvalidateTokens() {
        UUID userId = UUID.randomUUID();
        var user = User.builder()
                .id(userId)
                .email("u@test.com")
                .passwordHash("old-hash")
                .active(true)
                .suspended(false)
                .createdAt(clock.now())
                .updatedAt(clock.now())
                .build();

        var prt = PasswordResetToken.builder()
                .id(UUID.randomUUID())
                .userId(userId)
                .selector("abc")
                .verifierHash("hashed")
                .expiresAt(clock.now().plusSeconds(1000))
                .used(false)
                .createdAt(clock.now())
                .updatedAt(clock.now())
                .build();

        when(resetTokenRepo.findActiveBySelector("abc")).thenReturn(Optional.of(prt));
        when(userRepo.findById(userId)).thenReturn(Optional.of(user));
        when(passwordEncoder.matches("the-token", "hashed")).thenReturn(true);
        when(passwordEncoder.encode("new-pass")).thenReturn("new-hash");

        service.resetPassword(new ResetPasswordCommand("abc", "the-token", "new-pass"));

        verify(userRepo).save(argThat(updated -> updated.getPasswordHash().equals("new-hash")));
        verify(refreshRepo).revokeAllByUserId(userId);
        verify(resetTokenRepo).save(argThat(PasswordResetToken::isUsed));
        verify(resetTokenRepo).invalidateAllForUser(userId);
        verify(outbox).enqueue(eq(NotificationsOutboxPort.Type.PASSWORD_RESET_DONE), any());
    }

    @Test
    void resetPassword_shouldThrow_whenTokenExpired() {
        var prt = PasswordResetToken.builder()
                .expiresAt(clock.now().minusSeconds(1))
                .used(false)
                .build();

        when(resetTokenRepo.findActiveBySelector("abc")).thenReturn(Optional.of(prt));

        assertThatThrownBy(() ->
                service.resetPassword(new ResetPasswordCommand("abc", "x", "y"))
        ).isInstanceOf(ResetTokenExpiredException.class);
    }

    @Test
    void resetPassword_shouldThrow_whenTokenInvalid() {
        var prt = PasswordResetToken.builder()
                .expiresAt(clock.now().plusSeconds(500))
                .used(false)
                .verifierHash("hash")
                .build();

        when(resetTokenRepo.findActiveBySelector("abc")).thenReturn(Optional.of(prt));
        when(passwordEncoder.matches("bad", "hash")).thenReturn(false);

        assertThatThrownBy(() ->
                service.resetPassword(new ResetPasswordCommand("abc", "bad", "new"))
        ).isInstanceOf(ResetTokenInvalidException.class);
    }
}
