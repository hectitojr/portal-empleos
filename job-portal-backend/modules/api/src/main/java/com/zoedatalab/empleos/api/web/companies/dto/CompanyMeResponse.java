package com.zoedatalab.empleos.api.web.companies.dto;

import com.zoedatalab.empleos.companies.domain.EmployerType;

import java.util.UUID;

public record CompanyMeResponse(
        UUID id,
        EmployerType employerType,
        String legalName,
        String taxId,
        String contactEmail,
        String contactPhone,
        UUID districtId,
        boolean profileComplete,
        boolean active,
        boolean suspended
) {
}
