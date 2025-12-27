package com.zoedatalab.empleos.persistence.jpa.jobs.adapter;

import com.zoedatalab.empleos.companies.application.ports.out.CompanyJobStatsPort;
import com.zoedatalab.empleos.persistence.jpa.jobs.repository.JpaJobOfferRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class CompanyJobStatsAdapter implements CompanyJobStatsPort {

    private final JpaJobOfferRepository jobs;

    @Override
    public boolean hasCreatedJobs(UUID companyId) {
        if (companyId == null) return false;
        return jobs.existsByCompanyId(companyId);
    }
}
