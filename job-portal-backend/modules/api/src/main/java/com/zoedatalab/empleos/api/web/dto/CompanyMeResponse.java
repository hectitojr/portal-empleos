package com.zoedatalab.empleos.api.web.dto;

import java.util.UUID;

public record CompanyMeResponse(
        UUID id, String legalName, String taxId, String contactEmail, String contactPhone,
        UUID districtId, boolean profileComplete, boolean active, boolean suspended
) {}
