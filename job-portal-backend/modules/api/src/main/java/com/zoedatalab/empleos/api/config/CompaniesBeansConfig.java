package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.companies.application.ports.out.CompanyRepositoryPort;
import com.zoedatalab.empleos.companies.application.ports.out.DistrictLookupPort;
import com.zoedatalab.empleos.companies.application.service.CompanyServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class CompaniesBeansConfig {

    @Bean(name = "companyServiceCore")
    CompanyServiceImpl companyServiceCore(
            CompanyRepositoryPort repo,
            ClockPort clock,
            DistrictLookupPort districts
    ) {
        return new CompanyServiceImpl(repo, clock, districts);
    }

    @Bean
    @Primary
    TransactionalCompanyService companyService(CompanyServiceImpl core) {
        return new TransactionalCompanyService(core, core);
    }
}
