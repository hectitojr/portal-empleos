package com.zoedatalab.empleos.persistence.jpa.companies.adapter;

import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.persistence.jpa.companies.entity.CompanyEntity;
import com.zoedatalab.empleos.persistence.jpa.companies.repository.JpaCompanyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class CompanyOwnershipAdapter implements CompanyOwnershipPort {

    private final JpaCompanyRepository companies;

    @Override
    public CompanyOwnership getForUser(UUID companyUserId) {
        var c = companies.findByUserId(companyUserId).orElse(null);
        if (c == null) return new CompanyOwnership(null, false, false);

        boolean complete = c.isProfileComplete();
        boolean active = c.isActive() && !c.isSuspended();
        return new CompanyOwnership(c.getId(), active, complete);
    }

    @Override
    public String publicName(UUID companyId) {
        return companies.findById(companyId)
                .map(CompanyEntity::getLegalName)
                .orElse("—");
    }
}
