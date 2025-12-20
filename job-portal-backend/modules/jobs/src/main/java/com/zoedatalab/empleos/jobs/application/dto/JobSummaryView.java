package com.zoedatalab.empleos.jobs.application.dto;

import java.time.Instant;
import java.util.UUID;

public record JobSummaryView(
        UUID id,
        String title,
        UUID companyId,
        String companyPublicName,
        UUID sectorId,
        UUID districtId,
        String departmentName,
        String provinceName,
        String districtName,
        boolean disabilityFriendly,
        UUID employmentTypeId,
        UUID workModeId,
        String salaryText,
        boolean active,
        boolean applied,
        boolean viewed,
        String quickApplyText,
        String status,
        Instant publishedAt
) {
}
