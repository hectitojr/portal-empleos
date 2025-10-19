package com.zoedatalab.empleos.api.maintenance;

import com.zoedatalab.empleos.api.config.MaintenanceProperties;
import com.zoedatalab.empleos.iam.application.ports.out.RefreshTokenRepositoryPort;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.annotation.PostConstruct;
import java.time.Instant;
import java.util.TimeZone;

/**
 * Job programado para limpiar refresh tokens expirados.
 * Usa un TaskScheduler para poder aplicar el cron desde properties dinámicamente.
 */
@Slf4j
@Service
@RequiredArgsConstructor
@ConditionalOnProperty(prefix = "maintenance.refresh-tokens", name = "enabled", havingValue = "true", matchIfMissing = true)
public class RefreshTokenMaintenanceService {

    private final RefreshTokenRepositoryPort refreshTokens;
    private final MaintenanceProperties props;

    private TaskScheduler scheduler;

    @PostConstruct
    void init() {
        // Scheduler dedicado (hilo propio), evita bloquear otros @Scheduled
        ThreadPoolTaskScheduler ts = new ThreadPoolTaskScheduler();
        ts.setPoolSize(1);
        ts.setThreadNamePrefix("refresh-token-cleaner-");
        ts.initialize();
        this.scheduler = ts;

        // Programa la tarea con el cron de propiedades
        CronTrigger trigger = new CronTrigger(props.getCron(), TimeZone.getDefault());
        scheduler.schedule(this::runSafely, trigger);

        log.info("RefreshToken cleaner habilitado. cron='{}'", props.getCron());
    }

    private void runSafely() {
        try {
            purge();
        } catch (Exception ex) {
            log.error("Error ejecutando token cleaner", ex);
        }
    }

    @Transactional
    public void purge() {
        Instant now = Instant.now();
        long deleted = refreshTokens.purgeExpired(now);
        if (deleted > 0) {
            log.info("Limpieza de refresh tokens: eliminados={} hasta={}", deleted, now);
        } else {
            log.debug("Limpieza de refresh tokens: no había expirados (hasta={})", now);
        }
    }
}
