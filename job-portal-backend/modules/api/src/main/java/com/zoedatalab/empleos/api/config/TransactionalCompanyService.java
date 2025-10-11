package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.companies.application.dto.CompanyView;
import com.zoedatalab.empleos.companies.application.dto.UpsertMyCompanyCommand;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyCommandService;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyQueryService;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

public class TransactionalCompanyService implements CompanyCommandService, CompanyQueryService {

    private final CompanyCommandService commands;
    private final CompanyQueryService queries;

    public TransactionalCompanyService(CompanyCommandService commands, CompanyQueryService queries) {
        this.commands = commands;
        this.queries = queries;
    }

    @Override
    @Transactional(readOnly = true)
    public CompanyView getMyCompany(UUID currentUserId) {
        return queries.getMyCompany(currentUserId);
    }

    @Override
    @Transactional
    public CompanyView upsertMyCompany(UUID userId, UpsertMyCompanyCommand cmd) {
        return commands.upsertMyCompany(userId, cmd);
    }
}
