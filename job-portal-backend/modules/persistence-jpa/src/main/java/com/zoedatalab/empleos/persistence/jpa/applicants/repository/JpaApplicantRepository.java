package com.zoedatalab.empleos.persistence.jpa.applicants.repository;

import com.zoedatalab.empleos.persistence.jpa.applicants.entity.ApplicantEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface JpaApplicantRepository extends JpaRepository<ApplicantEntity, UUID> {
    Optional<ApplicantEntity> findByUserId(UUID userId);
}
