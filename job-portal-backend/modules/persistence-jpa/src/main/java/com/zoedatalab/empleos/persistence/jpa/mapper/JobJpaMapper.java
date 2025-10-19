package com.zoedatalab.empleos.persistence.jpa.mapper;

import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.persistence.jpa.entity.JobOfferEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface JobJpaMapper {
    JobOffer toDomain(JobOfferEntity e);
    JobOfferEntity toEntity(JobOffer d);
}
