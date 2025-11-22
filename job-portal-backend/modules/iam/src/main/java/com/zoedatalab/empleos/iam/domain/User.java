package com.zoedatalab.empleos.iam.domain;

import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter
@Builder
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private UUID id;
    private String email;
    private String passwordHash;
    private Role role;
    private boolean active;
    private boolean suspended;
    private Instant createdAt;
    private Instant updatedAt;
    private UUID createdBy;
    private UUID updatedBy;
    private Instant termsAcceptedAt;
    private Instant privacyAcceptedAt;
}
