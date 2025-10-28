package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.applications.application.ports.out.ApplicationRepositoryPort;
import com.zoedatalab.empleos.applications.application.service.ApplicationServiceImpl;
import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class ApplicationsBeansConfig {

    @Bean(name = "applicationServiceCore")
    public ApplicationServiceImpl applicationServiceCore(ApplicationRepositoryPort repo,
                                                         ApplicantRepositoryPort applicantRepo,
                                                         JobRepositoryPort jobRepo,
                                                         CompanyOwnershipPort ownershipPort) {
        return new ApplicationServiceImpl(repo, applicantRepo, jobRepo, ownershipPort);
    }

    @Bean
    @Primary
    public TransactionalApplicationService applicationService(ApplicationServiceImpl core) {
        return new TransactionalApplicationService(core, core);
    }
}
