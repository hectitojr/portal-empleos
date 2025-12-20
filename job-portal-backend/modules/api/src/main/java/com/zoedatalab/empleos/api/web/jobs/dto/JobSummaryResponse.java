package com.zoedatalab.empleos.api.web.jobs.dto;

import com.zoedatalab.empleos.jobs.application.dto.JobSummaryView;

import java.time.Instant;
import java.util.UUID;

public record JobSummaryResponse(
        UUID id,
        String title,
        String companyName,
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
    public static JobSummaryResponse from(JobSummaryView v) {
        return new JobSummaryResponse(
                v.id(),
                v.title(),
                v.companyPublicName(),
                v.sectorId(),
                v.districtId(),
                v.departmentName(),
                v.provinceName(),
                v.districtName(),
                v.disabilityFriendly(),
                v.employmentTypeId(),
                v.workModeId(),
                v.salaryText(),
                v.active(),
                v.applied(),
                v.viewed(),
                v.quickApplyText(),
                v.status(),
                v.publishedAt()
        );
    }
}

