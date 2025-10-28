package com.zoedatalab.empleos.persistence.jpa.repository;

import com.zoedatalab.empleos.persistence.jpa.entity.ApplicationEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.*;

public interface JpaApplicationRepository extends JpaRepository<ApplicationEntity, UUID> {
    boolean existsByJobIdAndApplicantId(UUID jobId, UUID applicantId);
    Page<ApplicationEntity> findByApplicantId(UUID applicantId, Pageable pageable);
    Page<ApplicationEntity> findByJobId(UUID jobId, Pageable pageable);
}
