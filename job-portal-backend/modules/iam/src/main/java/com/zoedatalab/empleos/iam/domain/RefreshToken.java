package com.zoedatalab.empleos.iam.domain;

import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter @Builder @ToString
@AllArgsConstructor @NoArgsConstructor
public class RefreshToken {
    private UUID id;
    private UUID userId;
    private String token;       // random (no JWT)
    private Instant expiresAt;
    private boolean revoked;
    private Instant createdAt;
}
