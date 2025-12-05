package com.zoedatalab.empleos.api.web.jobs.dto;

import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;

import java.time.Instant;
import java.util.UUID;

public record JobDetailResponse(
        UUID id,
        UUID companyId,
        String title,
        String description,
        UUID areaId,
        UUID sectorId,
        UUID districtId,
        boolean disabilityFriendly,
        UUID employmentTypeId,
        UUID workModeId,
        String salaryText,
        String status,
        Instant publishedAt
) {
    public static JobDetailResponse from(JobDetailView v) {
        return new JobDetailResponse(
                v.id(),
                v.companyId(),
                v.title(),
                v.description(),
                v.areaId(),
                v.sectorId(),
                v.districtId(),
                v.disabilityFriendly(),
                v.employmentTypeId(),
                v.workModeId(),
                v.salaryText(),
                v.status(),
                v.publishedAt()
        );
    }
}
