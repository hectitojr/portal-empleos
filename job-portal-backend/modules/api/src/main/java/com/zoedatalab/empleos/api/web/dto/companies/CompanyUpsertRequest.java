package com.zoedatalab.empleos.api.web.dto.companies;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.UUID;

public record CompanyUpsertRequest(
        @NotBlank String legalName,
        String taxId,
        @NotBlank @Email String contactEmail,
        String contactPhone,
        UUID districtId
) {}
