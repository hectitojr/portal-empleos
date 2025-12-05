package com.zoedatalab.empleos.jobs.application.dto;

import java.time.Instant;
import java.util.UUID;

public record ApplicantJobDetailView(
        UUID id,
        UUID companyId,
        String title,
        String description,
        UUID areaId,
        UUID sectorId,
        UUID districtId,
        UUID employmentTypeId,
        UUID workModeId,
        String salaryText,
        boolean disabilityFriendly,
        String status,
        Instant publishedAt,
        boolean suspended,
        boolean viewed,
        boolean applied,
        String quickApplyText,
        boolean active
) {
}
