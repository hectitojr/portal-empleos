package com.zoedatalab.empleos.persistence.jpa.repository;

import com.zoedatalab.empleos.persistence.jpa.entity.ApplicantEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.*;

public interface JpaApplicantRepository extends JpaRepository<ApplicantEntity, UUID> {
    Optional<ApplicantEntity> findByUserId(UUID userId);
}
