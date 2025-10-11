package com.zoedatalab.empleos.api.adapters;

import com.zoedatalab.empleos.companies.application.dto.UpsertMyCompanyCommand;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyCommandService;
import com.zoedatalab.empleos.common.provisioning.CompanyProvisioningPort; // <— nuevo import
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class CompanyProvisioningAdapter implements CompanyProvisioningPort {

    private final CompanyCommandService companies;

    @Override
    public void provision(UUID userId) {
        companies.upsertMyCompany(userId, UpsertMyCompanyCommand.builder().build());
    }
}
