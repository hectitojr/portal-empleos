package com.zoedatalab.empleos.api.web.jobs.dto;

import jakarta.validation.constraints.NotBlank;

import java.util.UUID;

public record UpdateJobRequest(
        @NotBlank String title,
        @NotBlank String description,
        UUID areaId,
        UUID sectorId,
        UUID districtId,
        boolean disabilityFriendly,
        UUID employmentTypeId,
        UUID workModeId,
        String salaryText
) {
}
