package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.iam.domain.RefreshToken;
import com.zoedatalab.empleos.persistence.jpa.iam.adapter.RefreshTokenRepositoryAdapter;
import com.zoedatalab.empleos.persistence.jpa.iam.entity.RefreshTokenEntity;
import com.zoedatalab.empleos.persistence.jpa.iam.mapper.RefreshTokenJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.iam.repository.JpaRefreshTokenRepository;
import org.junit.jupiter.api.Test;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class RefreshTokenRepositoryAdapterTest {

    @Test
    void findByToken_mapsEntityToDomain() {
        var repo = mock(JpaRefreshTokenRepository.class);
        var mapper = mock(RefreshTokenJpaMapper.class);
        var adapter = new RefreshTokenRepositoryAdapter(repo, mapper);

        var entity = new RefreshTokenEntity(UUID.randomUUID(), UUID.randomUUID(), "t", Instant.now(), false, Instant.now());
        var domain = RefreshToken.builder()
                .id(entity.getId()).userId(entity.getUserId()).token("t")
                .expiresAt(entity.getExpiresAt()).revoked(false).createdAt(entity.getCreatedAt()).build();

        when(repo.findByToken("t")).thenReturn(Optional.of(entity));
        when(mapper.toDomain(entity)).thenReturn(domain);

        var result = adapter.findByToken("t");

        assertThat(result).contains(domain);
        verify(repo).findByToken("t");
        verify(mapper).toDomain(entity);
    }

    @Test
    void purgeExpired_delegatesToRepo() {
        var repo = mock(JpaRefreshTokenRepository.class);
        var mapper = mock(RefreshTokenJpaMapper.class);
        var adapter = new RefreshTokenRepositoryAdapter(repo, mapper);

        var now = Instant.now();
        when(repo.deleteByExpiresAtBefore(now)).thenReturn(7);

        long deleted = adapter.purgeExpired(now);

        assertThat(deleted).isEqualTo(7L);
        verify(repo).deleteByExpiresAtBefore(now);
    }
}