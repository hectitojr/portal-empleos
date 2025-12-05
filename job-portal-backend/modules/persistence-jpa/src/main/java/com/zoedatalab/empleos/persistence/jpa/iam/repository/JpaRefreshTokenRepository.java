package com.zoedatalab.empleos.persistence.jpa.iam.repository;

import com.zoedatalab.empleos.persistence.jpa.iam.entity.RefreshTokenEntity;
import jakarta.persistence.QueryHint;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;
import org.springframework.data.repository.query.Param;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.hibernate.jpa.HibernateHints.HINT_READ_ONLY;

public interface JpaRefreshTokenRepository extends JpaRepository<RefreshTokenEntity, UUID> {

    @QueryHints(@QueryHint(name = HINT_READ_ONLY, value = "true"))
    Optional<RefreshTokenEntity> findByToken(String token);

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("delete from RefreshTokenEntity rt where rt.userId = :userId")
    int deleteByUserId(@Param("userId") UUID userId);

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("delete from RefreshTokenEntity rt where rt.expiresAt < :instant")
    int deleteByExpiresAtBefore(@Param("instant") Instant instant);

    long countByUserId(UUID userId);

    boolean existsByToken(String token);
}
