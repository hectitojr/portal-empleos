package com.zoedatalab.empleos.api.config.jobs;

import com.zoedatalab.empleos.jobs.application.ports.out.ApplicantLookupPort;
import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobApplicantStatePort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobCatalogValidationPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobLocationQueryPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.application.service.JobServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class JobsBeansConfig {

    @Bean(name = "jobServiceCore")
    JobServiceImpl jobServiceCore(
            JobRepositoryPort repo,
            CompanyOwnershipPort ownership,
            ApplicantLookupPort applicantLookup,
            JobApplicantStatePort applicantState,
            JobLocationQueryPort jobLocationQueries,
            JobCatalogValidationPort catalogValidation
    ) {
        return new JobServiceImpl(
                repo,
                ownership,
                applicantLookup,
                applicantState,
                jobLocationQueries,
                catalogValidation
        );
    }

    @Bean
    @Primary
    TransactionalJobService jobService(JobServiceImpl core) {
        return new TransactionalJobService(core, core);
    }
}
