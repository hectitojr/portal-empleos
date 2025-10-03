package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.iam.application.ports.out.RefreshTokenRepositoryPort;
import com.zoedatalab.empleos.iam.domain.RefreshToken;
import com.zoedatalab.empleos.persistence.jpa.mapper.RefreshTokenJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.repository.JpaRefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class RefreshTokenRepositoryAdapter implements RefreshTokenRepositoryPort {

    private final JpaRefreshTokenRepository repo;
    private final RefreshTokenJpaMapper mapper;

    @Override
    public RefreshToken save(RefreshToken token) {
        return mapper.toDomain(repo.save(mapper.toEntity(token)));
    }

    @Override
    public Optional<RefreshToken> findByToken(String token) {
        return repo.findByToken(token).map(mapper::toDomain);
    }

    @Override
    public void revokeAllByUserId(UUID userId) {
        // Estrategia simple: borrar todos los refresh tokens del usuario (equivale a “revocar”)
        repo.deleteAllByUserId(userId);
    }
}
