package com.zoedatalab.empleos.persistence.jpa.catalogs.repository;

import com.zoedatalab.empleos.persistence.jpa.catalogs.entity.CatalogWorkModeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface JpaCatalogWorkModeRepository extends JpaRepository<CatalogWorkModeEntity, UUID> {

    List<CatalogWorkModeEntity> findByActiveTrueOrderByNameAsc();
}
