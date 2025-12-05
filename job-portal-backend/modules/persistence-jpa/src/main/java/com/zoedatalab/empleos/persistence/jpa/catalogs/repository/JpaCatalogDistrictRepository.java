package com.zoedatalab.empleos.persistence.jpa.catalogs.repository;

import com.zoedatalab.empleos.persistence.jpa.catalogs.entity.CatalogDistrictEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface JpaCatalogDistrictRepository extends JpaRepository<CatalogDistrictEntity, UUID> {

    List<CatalogDistrictEntity> findByActiveTrueOrderByNameAsc();
}
