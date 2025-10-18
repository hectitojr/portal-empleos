package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.applicants.application.service.ApplicantServiceImpl;
import org.springframework.context.annotation.*;

@Configuration
public class ApplicantsBeansConfig {

    @Bean(name = "applicantServiceCore")
    ApplicantServiceImpl applicantServiceCore(ApplicantRepositoryPort repo, ClockPort clock) {
        return new ApplicantServiceImpl(repo, clock);
    }

    @Bean
    @Primary
    TransactionalApplicantService applicantService(ApplicantServiceImpl core) {
        return new TransactionalApplicantService(core, core);
    }
}
