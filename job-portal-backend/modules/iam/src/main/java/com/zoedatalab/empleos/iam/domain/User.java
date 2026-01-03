package com.zoedatalab.empleos.iam.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.Instant;
import java.util.UUID;

@Getter
@Builder(toBuilder = true)
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
    private DocumentType documentType;
    private String documentNumber;
    private Instant createdAt;
    private Instant updatedAt;
    private UUID createdBy;
    private UUID updatedBy;
    private Instant termsAcceptedAt;
    private Instant privacyAcceptedAt;

    public boolean isIdentityCompleted() {
        return documentType != null
                && documentNumber != null
                && !documentNumber.trim().isEmpty();
    }

    public User withIdentity(DocumentType type, String number) {
        return this.toBuilder()
                .documentType(type)
                .documentNumber(number)
                .build();
    }
}
