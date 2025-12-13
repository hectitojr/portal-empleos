package com.zoedatalab.empleos.api.web.jobs.dto;

import com.zoedatalab.empleos.jobs.application.dto.ApplicantJobDetailView;

import java.time.Instant;
import java.util.UUID;

public record ApplicantJobDetailResponse(
        UUID id,
        UUID companyId,
        String title,
        String description,
        UUID areaId,
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
        Instant publishedAt,
        boolean suspended
) {
    public static ApplicantJobDetailResponse from(ApplicantJobDetailView v) {
        return new ApplicantJobDetailResponse(
                v.id(),
                v.companyId(),
                v.title(),
                v.description(),
                v.areaId(),
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
                v.publishedAt(),
                v.suspended()
        );
    }
}
