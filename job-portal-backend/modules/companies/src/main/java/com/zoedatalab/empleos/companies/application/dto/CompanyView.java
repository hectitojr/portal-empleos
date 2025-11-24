package com.zoedatalab.empleos.companies.application.dto;

import lombok.Builder;

import java.util.UUID;

@Builder
public record CompanyView(
        UUID id, String legalName, String taxId, String contactEmail, String contactPhone,
        UUID districtId, boolean profileComplete, boolean active, boolean suspended
) {}
