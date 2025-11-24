package com.zoedatalab.empleos.iam.application.service;

import com.zoedatalab.empleos.iam.domain.PasswordResetToken;
import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.iam.domain.User;

import java.time.Instant;
import java.util.UUID;

final class TestFixtures {

    static User activeUser(UUID id, String email, String passHash) {
        return User.builder()
                .id(id)
                .email(email)
                .passwordHash(passHash)
                .role(Role.APPLICANT)
                .active(true)
                .suspended(false)
                .createdAt(Instant.parse("2025-01-01T00:00:00Z"))
                .updatedAt(Instant.parse("2025-01-01T00:00:00Z"))
                .build();
    }

    static PasswordResetToken freshToken(UUID userId, Instant now, long ttlSeconds) {
        return PasswordResetToken.builder()
                .id(UUID.randomUUID())
                .userId(userId)
                .selector("selector-123")
                .verifierHash("$2a$12$dummy")
                .expiresAt(now.plusSeconds(ttlSeconds))
                .used(false)
                .createdAt(now)
                .updatedAt(now)
                .build();
    }

    private TestFixtures() {}
}
