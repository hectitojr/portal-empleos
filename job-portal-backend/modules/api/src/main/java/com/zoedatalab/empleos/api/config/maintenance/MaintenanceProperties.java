package com.zoedatalab.empleos.api.config.maintenance;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Data
@ConfigurationProperties(prefix = "maintenance.refresh-tokens")
public class MaintenanceProperties {

    /**
     * Activar/desactivar la limpieza programada
     */
    private boolean enabled = true;

    /**
     * Expresión cron (Spring) p.ej. "0 0 * * * *" = cada hora
     */
    private String cron = "0 0 * * * *";

    /**
     * Zona horaria del cron, p.ej. "America/Lima"
     */
    private String zone = "America/Lima";
}
