package com.zoedatalab.empleos.api.web.jobs.dto;

import com.zoedatalab.empleos.jobs.application.dto.ApplicantJobSummaryView;

import java.time.Instant;
import java.util.UUID;

public record ApplicantJobSummaryResponse(
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
    public static ApplicantJobSummaryResponse from(ApplicantJobSummaryView v) {
        return new ApplicantJobSummaryResponse(
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
