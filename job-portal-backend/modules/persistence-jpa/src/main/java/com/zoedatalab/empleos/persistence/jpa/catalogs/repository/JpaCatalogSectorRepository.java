package com.zoedatalab.empleos.persistence.jpa.catalogs.repository;

import com.zoedatalab.empleos.persistence.jpa.catalogs.entity.CatalogSectorEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface JpaCatalogSectorRepository extends JpaRepository<CatalogSectorEntity, UUID> {

    List<CatalogSectorEntity> findByActiveTrueOrderByNameAsc();

    boolean existsByIdAndActiveTrue(UUID id);
}
