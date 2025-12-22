package com.zoedatalab.empleos.persistence.jpa.jobs.mapper;

import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.persistence.jpa.jobs.entity.JobOfferEntity;
import org.springframework.stereotype.Component;

@Component
public class JobJpaMapper {

    public JobOffer toDomain(JobOfferEntity e) {
        if (e == null) return null;
        
        return new JobOffer(
                e.getId(),
                e.getCompanyId(),
                e.getTitle(),
                e.getDescription(),
                e.getAreaId(),
                e.getSectorId(),
                e.getDistrictId(),
                e.isDisabilityFriendly(),
                e.getEmploymentTypeId(),
                e.getWorkModeId(),
                e.getSalaryText(),
                map(e.getStatus()),
                e.getPublishedAt(),
                e.isSuspended()
        );
    }

    public JobOfferEntity toEntity(JobOffer d) {
        if (d == null) return null;

        return JobOfferEntity.builder()
                .id(d.getId())
                .companyId(d.getCompanyId())
                .title(d.getTitle())
                .description(d.getDescription())
                .areaId(d.getAreaId())
                .sectorId(d.getSectorId())
                .districtId(d.getDistrictId())
                .disabilityFriendly(d.isDisabilityFriendly())
                .employmentTypeId(d.getEmploymentTypeId())
                .workModeId(d.getWorkModeId())
                .salaryText(d.getSalaryText())
                .status(map(d.getStatus()))
                .publishedAt(d.getPublishedAt())
                .suspended(d.isSuspended())
                .build();
    }

    private JobOffer.Status map(JobOfferEntity.Status status) {
        return status == null ? null : JobOffer.Status.valueOf(status.name());
    }

    private JobOfferEntity.Status map(JobOffer.Status status) {
        return status == null ? null : JobOfferEntity.Status.valueOf(status.name());
    }
}
