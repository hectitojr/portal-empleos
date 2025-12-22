package com.zoedatalab.empleos.jobs.application.dto;

import lombok.Builder;

import java.math.BigDecimal;
import java.util.UUID;

@Builder
public record UpdateJobCommand(
        String title,
        String description,
        UUID areaId,
        UUID sectorId,
        UUID districtId,
        boolean disabilityFriendly,
        UUID employmentTypeId,
        UUID workModeId,
        BigDecimal salaryMin,
        BigDecimal salaryMax
) {
}

