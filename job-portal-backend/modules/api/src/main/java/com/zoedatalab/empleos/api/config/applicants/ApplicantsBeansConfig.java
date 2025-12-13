package com.zoedatalab.empleos.api.config.applicants;

import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.applicants.application.service.ApplicantServiceImpl;
import com.zoedatalab.empleos.common.catalogs.DistrictLookupPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class ApplicantsBeansConfig {

    @Bean(name = "applicantServiceCore")
    ApplicantServiceImpl applicantServiceCore(
            ApplicantRepositoryPort repo,
            ClockPort clock,
            DistrictLookupPort districtLookup
    ) {
        return new ApplicantServiceImpl(repo, clock, districtLookup);
    }

    @Bean
    @Primary
    TransactionalApplicantService applicantService(ApplicantServiceImpl core) {
        return new TransactionalApplicantService(core, core);
    }
}
