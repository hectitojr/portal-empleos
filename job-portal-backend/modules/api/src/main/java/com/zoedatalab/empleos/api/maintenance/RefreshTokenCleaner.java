package com.zoedatalab.empleos.api.maintenance;

import com.zoedatalab.empleos.iam.application.ports.out.RefreshTokenRepositoryPort;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;

@Slf4j
@Service
@RequiredArgsConstructor
public class RefreshTokenCleaner {

    private final RefreshTokenRepositoryPort repo;

    /** Ejecuta una pasada de limpieza dentro de una transacción */
    @Transactional
    public void purgeNow() {
        long deleted = repo.purgeExpired(Instant.now());
        log.info("[RefreshTokenCleaner] purgeExpired -> deleted={} tokens", deleted);
    }
}
