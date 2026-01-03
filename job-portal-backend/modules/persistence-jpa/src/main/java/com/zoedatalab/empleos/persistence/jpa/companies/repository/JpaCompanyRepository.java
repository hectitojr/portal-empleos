package com.zoedatalab.empleos.persistence.jpa.companies.repository;

import com.zoedatalab.empleos.persistence.jpa.companies.entity.CompanyEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface JpaCompanyRepository extends JpaRepository<CompanyEntity, UUID> {
    Optional<CompanyEntity> findByUserId(UUID userId);

    boolean existsByTaxIdIgnoreCaseAndUserIdNot(String taxId, UUID userId);
}
