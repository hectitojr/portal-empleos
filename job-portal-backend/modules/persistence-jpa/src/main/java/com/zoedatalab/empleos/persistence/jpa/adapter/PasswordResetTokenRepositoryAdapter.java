package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.iam.application.ports.out.PasswordResetTokenRepositoryPort;
import com.zoedatalab.empleos.iam.domain.PasswordResetToken;
import com.zoedatalab.empleos.persistence.jpa.mapper.PasswordResetTokenJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.repository.JpaPasswordResetTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class PasswordResetTokenRepositoryAdapter implements PasswordResetTokenRepositoryPort {

    private final JpaPasswordResetTokenRepository repo;
    private final PasswordResetTokenJpaMapper mapper;

    @Override
    public PasswordResetToken save(PasswordResetToken t) {
        var saved = repo.save(mapper.toEntity(t));
        return mapper.toDomain(saved);
    }

    @Override
    public Optional<PasswordResetToken> findActiveBySelector(String selector) {
        return repo.findBySelectorAndUsedFalse(selector).map(mapper::toDomain);
    }

    @Override
    public void invalidateAllForUser(UUID userId) {
        repo.deleteByUserId(userId);
    }
}
