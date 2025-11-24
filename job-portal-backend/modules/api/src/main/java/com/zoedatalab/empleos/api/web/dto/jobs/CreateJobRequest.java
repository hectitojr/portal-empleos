package com.zoedatalab.empleos.api.web.dto.jobs;

import jakarta.validation.constraints.NotBlank;

import java.util.UUID;

public record CreateJobRequest(
        @NotBlank String title,
        @NotBlank String description,
        UUID areaId, UUID sectorId, UUID districtId,
        boolean disabilityFriendly
) {}
