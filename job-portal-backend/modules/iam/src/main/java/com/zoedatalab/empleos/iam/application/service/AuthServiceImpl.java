package com.zoedatalab.empleos.iam.application.service;

import com.zoedatalab.empleos.common.provisioning.ApplicantProvisioningPort;
import com.zoedatalab.empleos.common.provisioning.CompanyProvisioningPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.iam.application.dto.AuthTokens;
import com.zoedatalab.empleos.iam.application.dto.LoginCommand;
import com.zoedatalab.empleos.iam.application.dto.RegisterCommand;
import com.zoedatalab.empleos.iam.application.exception.*;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import com.zoedatalab.empleos.iam.application.ports.out.*;
import com.zoedatalab.empleos.iam.domain.RefreshToken;
import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.iam.domain.User;
import lombok.RequiredArgsConstructor;

import java.time.temporal.ChronoUnit;
import java.util.Optional;
import java.util.UUID;

@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final UserRepositoryPort userRepo;
    private final RefreshTokenRepositoryPort refreshRepo;
    private final PasswordEncoderPort passwordEncoder;
    private final TokenServicePort tokenService;
    private final ClockPort clock;
    private final ApplicantProvisioningPort applicantProvisioning;
    private final CompanyProvisioningPort companyProvisioning;
    private final long refreshTtlSeconds;

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

        // provisión inicial (no-op hasta tener módulos)
        if (saved.getRole() == Role.APPLICANT) applicantProvisioning.provision(saved.getId());
        if (saved.getRole() == Role.COMPANY)   companyProvisioning.provision(saved.getId());

        return issueTokensFor(saved);
    }

    @Override
    public AuthTokens login(LoginCommand cmd) {
        Optional<User> u = userRepo.findByEmail(cmd.getEmail().trim().toLowerCase());
        if (u.isEmpty()) throw new AuthBadCredentialsException();
        User user = u.get();

        if (!user.isActive() || user.isSuspended()) throw new UserSuspendedException();
        if (!passwordEncoder.matches(cmd.getPassword(), user.getPasswordHash())) throw new AuthBadCredentialsException();

        return issueTokensFor(user);
    }

    @Override
    public AuthTokens refresh(String refreshToken) {
        RefreshToken rt = refreshRepo.findByToken(refreshToken).orElseThrow(TokenInvalidException::new);
        if (rt.isRevoked()) throw new TokenInvalidException();
        if (rt.getExpiresAt().isBefore(clock.now())) throw new TokenExpiredException();

        User user = userRepo.findById(rt.getUserId()).orElseThrow(TokenInvalidException::new);
        // revocamos refresh tokens anteriores para el usuario (rotación)
        refreshRepo.revokeAllByUserId(user.getId());
        return issueTokensFor(user);
    }

    private AuthTokens issueTokensFor(User user) {
        String access = tokenService.issueAccessToken(user);
        long ttl = tokenService.accessTokenTtlSeconds();

        // refresh token aleatorio persistido
        String refresh = UUID.randomUUID().toString().replace("-", "") + UUID.randomUUID().toString().replace("-", "");
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
}