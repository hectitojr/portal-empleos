package com.zoedatalab.empleos.persistence.jpa.iam.repository;

import com.zoedatalab.empleos.persistence.jpa.iam.entity.PasswordResetTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface JpaPasswordResetTokenRepository extends JpaRepository<PasswordResetTokenEntity, UUID> {
    Optional<PasswordResetTokenEntity> findBySelectorAndUsedFalse(String selector);

    void deleteByUserId(UUID userId);
}