package com.zoedatalab.empleos.persistence.jpa.jobs.repository;

import com.zoedatalab.empleos.persistence.jpa.jobs.entity.JobOfferEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.UUID;

public interface JpaJobOfferRepository
        extends JpaRepository<JobOfferEntity, UUID>,
        JpaSpecificationExecutor<JobOfferEntity> {

    boolean existsByIdAndCompanyId(UUID id, UUID companyId);
}
