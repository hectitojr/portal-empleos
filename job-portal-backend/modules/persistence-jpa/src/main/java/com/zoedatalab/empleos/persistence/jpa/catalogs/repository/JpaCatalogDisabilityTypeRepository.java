package com.zoedatalab.empleos.persistence.jpa.catalogs.repository;

import com.zoedatalab.empleos.persistence.jpa.catalogs.entity.CatalogDisabilityTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface JpaCatalogDisabilityTypeRepository extends JpaRepository<CatalogDisabilityTypeEntity, UUID> {

    List<CatalogDisabilityTypeEntity> findByActiveTrueOrderByNameAsc();
}
