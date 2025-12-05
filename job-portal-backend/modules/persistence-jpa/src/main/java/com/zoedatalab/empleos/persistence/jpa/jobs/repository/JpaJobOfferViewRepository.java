package com.zoedatalab.empleos.persistence.jpa.jobs.repository;

import com.zoedatalab.empleos.persistence.jpa.jobs.entity.JobOfferViewEntity;
import com.zoedatalab.empleos.persistence.jpa.jobs.entity.JobOfferViewId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface JpaJobOfferViewRepository extends JpaRepository<JobOfferViewEntity, JobOfferViewId> {

    List<JobOfferViewEntity> findByApplicantIdAndJobIdIn(UUID applicantId, List<UUID> jobIds);

    boolean existsByApplicantIdAndJobId(UUID applicantId, UUID jobId);
}
