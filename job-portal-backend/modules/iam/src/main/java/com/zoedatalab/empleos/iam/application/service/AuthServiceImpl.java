package com.zoedatalab.empleos.iam.application.service;

import com.zoedatalab.empleos.common.provisioning.ApplicantProvisioningPort;
import com.zoedatalab.empleos.common.provisioning.CompanyProvisioningPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.iam.application.dto.AuthTokens;
import com.zoedatalab.empleos.iam.application.dto.ForgotPasswordCommand;
import com.zoedatalab.empleos.iam.application.dto.LoginCommand;
import com.zoedatalab.empleos.iam.application.dto.RegisterCommand;
import com.zoedatalab.empleos.iam.application.dto.ResetPasswordCommand;
import com.zoedatalab.empleos.iam.application.exception.*;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import com.zoedatalab.empleos.iam.application.ports.out.*;
import com.zoedatalab.empleos.iam.domain.PasswordResetToken;
import com.zoedatalab.empleos.iam.domain.RefreshToken;
import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.iam.domain.User;
import lombok.RequiredArgsConstructor;

import java.security.SecureRandom;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Base64;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    // EXISTENTES
    private final UserRepositoryPort userRepo;
    private final RefreshTokenRepositoryPort refreshRepo;
    private final PasswordEncoderPort passwordEncoder;
    private final TokenServicePort tokenService;
    private final ClockPort clock;
    private final ApplicantProvisioningPort applicantProvisioning;
    private final CompanyProvisioningPort companyProvisioning;
    private final long refreshTtlSeconds;

    // NUEVOS
    private final PasswordResetTokenRepositoryPort resetTokenRepo;
    private final NotificationsOutboxPort outbox;
    private final long resetTtlSeconds;
    private final long resetRateLimitSeconds; // (por ahora no usado explícitamente)

    // =========================================================
    // REGISTER
    // =========================================================
    @Override
    public AuthTokens register(RegisterCommand cmd) {
        userRepo.findByEmail(cmd.getEmail().trim().toLowerCase())
                .ifPresent(u -> { throw new EmailAlreadyExistsException(); });

        User newUser = User.builder()
                .id(UUID.randomUUID())
                .email(cmd.getEmail().trim().toLowerCase())
                .passwordHash(passwordEncoder.encode(cmd.getPassword()))
                .role(cmd.getRole())
                .active(true)
                .suspended(false)
                .createdAt(clock.now())
                .updatedAt(clock.now())
                .build();

        User saved = userRepo.save(newUser);

        // provisión inicial
        if (saved.getRole() == Role.APPLICANT) applicantProvisioning.provision(saved.getId());
        if (saved.getRole() == Role.COMPANY)   companyProvisioning.provision(saved.getId());

        return issueTokensFor(saved);
    }

    // =========================================================
    // LOGIN
    // =========================================================
    @Override
    public AuthTokens login(LoginCommand cmd) {
        Optional<User> u = userRepo.findByEmail(cmd.getEmail().trim().toLowerCase());
        if (u.isEmpty()) throw new AuthBadCredentialsException();
        User user = u.get();

        if (!user.isActive() || user.isSuspended()) throw new UserSuspendedException();
        if (!passwordEncoder.matches(cmd.getPassword(), user.getPasswordHash())) throw new AuthBadCredentialsException();

        return issueTokensFor(user);
    }

    // =========================================================
    // REFRESH
    // =========================================================
    @Override
    public AuthTokens refresh(String refreshToken) {
        RefreshToken rt = refreshRepo.findByToken(refreshToken).orElseThrow(TokenInvalidException::new);
        if (rt.isRevoked()) throw new TokenInvalidException();
        if (rt.getExpiresAt().isBefore(clock.now())) throw new TokenExpiredException();

        User user = userRepo.findById(rt.getUserId()).orElseThrow(TokenInvalidException::new);
        // rotación: revocar tokens anteriores del usuario
        refreshRepo.revokeAllByUserId(user.getId());
        return issueTokensFor(user);
    }

    // =========================================================
    // FORGOT PASSWORD (idempotente: no filtra por existencia)
    // =========================================================
    @Override
    public void forgotPassword(ForgotPasswordCommand cmd) {
        String rawEmail = cmd.email();
        if (rawEmail == null || rawEmail.isBlank()) return;

        String email = rawEmail.trim().toLowerCase();
        var userOpt = userRepo.findByEmail(email);
        if (userOpt.isEmpty()) return; // no revelar existencia
        User user = userOpt.get();

        if (!user.isActive() || user.isSuspended()) return;

        Instant now = clock.now();

        resetTokenRepo.invalidateAllForUser(user.getId());

        // Generar selector + token (verifier)
        String selector = randomUrlSafe(16);
        String token = randomUrlSafe(32);
        String verifierHash = passwordEncoder.encode(token);

        PasswordResetToken t = PasswordResetToken.builder()
                .id(null)
                .userId(user.getId())
                .selector(selector)
                .verifierHash(verifierHash)
                .expiresAt(now.plusSeconds(resetTtlSeconds))
                .used(false)
                .createdAt(now)
                .updatedAt(now)
                .build();

        resetTokenRepo.save(t);

        // Outbox: enviar email con selector+token (verifier NO se persiste plano)
        outbox.enqueue(NotificationsOutboxPort.Type.PASSWORD_RESET_REQUESTED, Map.of(
                "userId", user.getId().toString(),
                "email", user.getEmail(),
                "selector", selector,
                "token", token,
                "expiresAt", t.getExpiresAt().toString()
        ));
    }

    // =========================================================
    // RESET PASSWORD (valida selector + token/verifier)
    // =========================================================
    @Override
    public void resetPassword(ResetPasswordCommand cmd) {
        if (cmd.selector() == null || cmd.token() == null || cmd.newPassword() == null) {
            throw new ResetTokenInvalidException();
        }

        var prt = resetTokenRepo.findActiveBySelector(cmd.selector())
                .orElseThrow(ResetTokenInvalidException::new);

        Instant now = clock.now();

        if (prt.isExpired(now)) {
            throw new ResetTokenExpiredException();
        }
        if (prt.isUsed()) {
            throw new ResetTokenInvalidException();
        }
        if (!passwordEncoder.matches(cmd.token(), prt.getVerifierHash())) {
            throw new ResetTokenInvalidException();
        }

        // Rotar contraseña del usuario
        User user = userRepo.findById(prt.getUserId()).orElseThrow(ResetTokenInvalidException::new);
        user = User.builder()
                .id(user.getId())
                .email(user.getEmail())
                .passwordHash(passwordEncoder.encode(cmd.newPassword()))
                .role(user.getRole())
                .active(user.isActive())
                .suspended(user.isSuspended())
                .createdAt(user.getCreatedAt())
                .updatedAt(now)
                .build();
        userRepo.save(user);

        prt.markUsed();
        resetTokenRepo.save(prt);
        resetTokenRepo.invalidateAllForUser(user.getId());

        refreshRepo.revokeAllByUserId(user.getId());

        // Outbox de confirmación
        outbox.enqueue(NotificationsOutboxPort.Type.PASSWORD_RESET_DONE, Map.of(
                "userId", user.getId().toString(),
                "email", user.getEmail()
        ));
    }

    // =========================================================
    // HELPERS
    // =========================================================
    private AuthTokens issueTokensFor(User user) {
        String access = tokenService.issueAccessToken(user);
        long ttl = tokenService.accessTokenTtlSeconds();

        // refresh token aleatorio persistido
        String refresh = UUID.randomUUID().toString().replace("-", "")
                + UUID.randomUUID().toString().replace("-", "");
        RefreshToken rt = RefreshToken.builder()
                .id(UUID.randomUUID())
                .userId(user.getId())
                .token(refresh)
                .expiresAt(clock.now().plus(refreshTtlSeconds, ChronoUnit.SECONDS))
                .revoked(false)
                .createdAt(clock.now())
                .build();
        refreshRepo.save(rt);

        return AuthTokens.builder()
                .tokenType("Bearer")
                .accessToken(access)
                .expiresIn(ttl)
                .refreshToken(refresh)
                .build();
    }

    private static String randomUrlSafe(int bytes) {
        byte[] buf = new byte[bytes];
        new SecureRandom().nextBytes(buf);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(buf);
    }
}
