package com.zoedatalab.empleos.persistence.jpa.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.Instant;
import java.util.UUID;

@Entity @Table(name = "password_reset_tokens",
        indexes = { @Index(name = "ix_prt_selector", columnList = "selector", unique = true),
                @Index(name = "ix_prt_user", columnList = "user_id") })
@Getter @Setter @Builder @NoArgsConstructor @AllArgsConstructor
public class PasswordResetTokenEntity {
    @Id
    @Column(nullable = false)
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "selector", nullable = false, unique = true)
    private String selector;

    @Column(name = "verifier_hash", nullable = false)
    private String verifierHash;

    @Column(name = "expires_at", nullable = false)
    private Instant expiresAt;

    @Column(name = "used", nullable = false)
    private boolean used;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;
}
