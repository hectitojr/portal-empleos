package com.zoedatalab.empleos.persistence.jpa.jobs.mapper;

import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.persistence.jpa.jobs.entity.JobOfferEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface JobJpaMapper {

    JobOffer toDomain(JobOfferEntity e);

    JobOfferEntity toEntity(JobOffer d);

    default JobOffer.Status map(JobOfferEntity.Status status) {
        return status == null ? null : JobOffer.Status.valueOf(status.name());
    }

    default JobOfferEntity.Status map(JobOffer.Status status) {
        return status == null ? null : JobOfferEntity.Status.valueOf(status.name());
    }
}
