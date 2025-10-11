package com.zoedatalab.empleos.companies.application.dto;

import lombok.Builder;

import java.util.UUID;

@Builder
public record UpsertMyCompanyCommand(
        String legalName,
        String taxId,
        String contactEmail,
        String contactPhone,
        UUID districtId
) {}
