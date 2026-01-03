package com.zoedatalab.empleos.companies.application.dto;

import com.zoedatalab.empleos.companies.domain.EmployerType;
import lombok.Builder;

import java.util.UUID;

@Builder
public record UpsertMyCompanyCommand(
        EmployerType employerType,
        String legalName,
        String taxId,
        String contactEmail,
        String contactPhone,
        UUID districtId
) {
}
