package com.zoedatalab.empleos.companies.application.ports.in;

import com.zoedatalab.empleos.companies.application.dto.CompanyView;
import com.zoedatalab.empleos.companies.application.dto.UpsertMyCompanyCommand;

import java.util.UUID;

public interface CompanyCommandService {
    CompanyView upsertMyCompany(UUID currentUserId, UpsertMyCompanyCommand cmd);
}
