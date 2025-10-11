package com.zoedatalab.empleos.iam.application.service;

import com.zoedatalab.empleos.common.provisioning.CompanyProvisioningPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.iam.application.dto.*;
import com.zoedatalab.empleos.iam.application.exception.*;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import com.zoedatalab.empleos.iam.application.ports.out.*;
import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.iam.domain.User;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class AuthServiceImplTest {

    UserRepositoryPort userRepo = mock(UserRepositoryPort.class);
    RefreshTokenRepositoryPort refreshRepo = mock(RefreshTokenRepositoryPort.class);
    PasswordEncoderPort encoder = mock(PasswordEncoderPort.class);
    TokenServicePort token = mock(TokenServicePort.class);
    ClockPort clock = () -> Instant.parse("2025-01-01T00:00:00Z");
    ApplicantProvisioningPort appProv = u -> {};
    CompanyProvisioningPort comProv = u -> {};

    AuthService service = new AuthServiceImpl(
            userRepo, refreshRepo, encoder, token, clock, appProv, comProv, 2_592_000L
    );

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
        when(encoder.matches("pwd", "h")).thenReturn(true);
        when(token.issueAccessToken(Mockito.any())).thenReturn("jwt");
        when(token.accessTokenTtlSeconds()).thenReturn(900L);

        var out = service.login(LoginCommand.builder().email("a@a.com").password("pwd").build());
        assertEquals("jwt", out.getAccessToken());
        assertNotNull(out.getRefreshToken());
    }
}
