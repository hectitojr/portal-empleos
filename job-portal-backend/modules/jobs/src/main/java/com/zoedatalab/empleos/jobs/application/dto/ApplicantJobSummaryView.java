package com.zoedatalab.empleos.jobs.application.dto;

import java.time.Instant;
import java.util.UUID;

public record ApplicantJobSummaryView(
        UUID id,
        String title,
        String companyPublicName,
        UUID sectorId,
        UUID districtId,
        String departmentName,
        String provinceName,
        String districtName,
        UUID employmentTypeId,
        UUID workModeId,
        String salaryText,
        boolean disabilityFriendly,
        String status,
        Instant publishedAt,
        boolean viewed,
        boolean applied,
        String quickApplyText,
        boolean active
) {
}
