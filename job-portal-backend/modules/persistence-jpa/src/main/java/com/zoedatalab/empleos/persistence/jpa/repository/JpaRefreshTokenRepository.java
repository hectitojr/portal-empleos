package com.zoedatalab.empleos.persistence.jpa.repository;

import com.zoedatalab.empleos.persistence.jpa.entity.RefreshTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.UUID;

public interface JpaRefreshTokenRepository extends JpaRepository<RefreshTokenEntity, UUID> {

    Optional<RefreshTokenEntity> findByToken(String token);

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("delete from RefreshTokenEntity rt where rt.userId = :userId")
    int deleteAllByUserId(@Param("userId") UUID userId);
}
