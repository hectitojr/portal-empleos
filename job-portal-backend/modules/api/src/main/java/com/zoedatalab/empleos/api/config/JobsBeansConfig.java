package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.application.service.JobServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class JobsBeansConfig {

    @Bean(name = "jobServiceCore")
    JobServiceImpl jobServiceCore(JobRepositoryPort repo, CompanyOwnershipPort ownership) {
        return new JobServiceImpl(repo, ownership);
    }

    @Bean
    @Primary
    TransactionalJobService jobService(JobServiceImpl core) {
        return new TransactionalJobService(core, core);
    }
}
