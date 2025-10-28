package com.zoedatalab.empleos.persistence.jpa.mapper;

import com.zoedatalab.empleos.applications.domain.Application;
import com.zoedatalab.empleos.persistence.jpa.entity.ApplicationEntity;
import org.springframework.stereotype.Component;

@Component
public class ApplicationJpaMapper {

    public ApplicationEntity toEntity(Application a) {
        return ApplicationEntity.builder()
                .id(a.getId())
                .jobId(a.getJobId())
                .applicantId(a.getApplicantId())
                .status(ApplicationEntity.Status.valueOf(a.getStatus().name()))
                .notes(a.getNotes())
                .appliedAt(a.getAppliedAt())
                .updatedAt(a.getUpdatedAt())
                .createdBy(a.getCreatedBy())
                .updatedBy(a.getUpdatedBy())
                .build();
    }

    public Application toDomain(ApplicationEntity e) {
        return Application.builder()
                .id(e.getId())
                .jobId(e.getJobId())
                .applicantId(e.getApplicantId())
                .status(Application.Status.valueOf(e.getStatus().name()))
                .notes(e.getNotes())
                .appliedAt(e.getAppliedAt())
                .updatedAt(e.getUpdatedAt())
                .createdBy(e.getCreatedBy())
                .updatedBy(e.getUpdatedBy())
                .build();
    }
}
