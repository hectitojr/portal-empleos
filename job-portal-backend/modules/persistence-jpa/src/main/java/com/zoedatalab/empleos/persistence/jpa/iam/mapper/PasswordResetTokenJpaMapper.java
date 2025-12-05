package com.zoedatalab.empleos.persistence.jpa.iam.mapper;

import com.zoedatalab.empleos.iam.domain.PasswordResetToken;
import com.zoedatalab.empleos.persistence.jpa.iam.entity.PasswordResetTokenEntity;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class PasswordResetTokenJpaMapper {
    public PasswordResetTokenEntity toEntity(PasswordResetToken d) {
        return PasswordResetTokenEntity.builder()
                .id(d.getId() != null ? d.getId() : UUID.randomUUID())
                .userId(d.getUserId())
                .selector(d.getSelector())
                .verifierHash(d.getVerifierHash())
                .expiresAt(d.getExpiresAt())
                .used(d.isUsed())
                .createdAt(d.getCreatedAt())
                .updatedAt(d.getUpdatedAt())
                .build();
    }

    public PasswordResetToken toDomain(PasswordResetTokenEntity e) {
        return PasswordResetToken.builder()
                .id(e.getId())
                .userId(e.getUserId())
                .selector(e.getSelector())
                .verifierHash(e.getVerifierHash())
                .expiresAt(e.getExpiresAt())
                .used(e.isUsed())
                .createdAt(e.getCreatedAt())
                .updatedAt(e.getUpdatedAt())
                .build();
    }
}
