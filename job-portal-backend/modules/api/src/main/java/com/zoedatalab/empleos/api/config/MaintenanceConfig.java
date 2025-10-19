package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.api.maintenance.RefreshTokenCleaner;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.config.CronTask;
import org.springframework.lang.NonNull;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.scheduling.annotation.SchedulingConfigurer;

import java.util.TimeZone;

@Configuration
@EnableScheduling
@RequiredArgsConstructor
public class MaintenanceConfig implements SchedulingConfigurer {

    private final MaintenanceProperties props;
    private final RefreshTokenCleaner cleaner;

    @Bean(name = "maintenanceTaskScheduler")
    public TaskScheduler maintenanceTaskScheduler() {
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        scheduler.setPoolSize(1);
        scheduler.setThreadNamePrefix("maintenance-");
        scheduler.initialize();
        return scheduler;
    }


    @Override
    public void configureTasks(@NonNull ScheduledTaskRegistrar registrar) {
        if (!props.isEnabled()) {
            return;
        }
        registrar.setScheduler(maintenanceTaskScheduler());

        CronTrigger trigger = new CronTrigger(
                props.getCron(),
                TimeZone.getTimeZone(props.getZone())
        );

        Runnable task = cleaner::purgeNow; // ejecuta la limpieza transaccional

        registrar.addCronTask(new CronTask(task, trigger));
    }
}
