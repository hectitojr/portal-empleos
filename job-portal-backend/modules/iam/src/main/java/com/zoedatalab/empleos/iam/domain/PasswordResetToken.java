package com.zoedatalab.empleos.iam.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Getter @Builder @AllArgsConstructor @NoArgsConstructor
public class PasswordResetToken {
    private UUID id;
    private UUID userId;

    /** Selector público (enlace). No sensible. */
    private String selector;

    /** Verifier hasheado (no almacenar el token en claro). */
    private String verifierHash;

    private Instant expiresAt;
    private boolean used;
    private Instant createdAt;
    private Instant updatedAt;

    public boolean isExpired(Instant now) {
        return expiresAt != null && now.isAfter(expiresAt);
    }

    public void markUsed() { this.used = true; }
}
