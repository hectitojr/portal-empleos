package com.zoedatalab.empleos.persistence.jpa.catalogs.repository;

import com.zoedatalab.empleos.persistence.jpa.catalogs.entity.CatalogEmploymentTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface JpaCatalogEmploymentTypeRepository extends JpaRepository<CatalogEmploymentTypeEntity, UUID> {

    List<CatalogEmploymentTypeEntity> findByActiveTrueOrderByNameAsc();
}
