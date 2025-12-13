package com.zoedatalab.empleos.persistence.jpa.catalogs.repository;

import com.zoedatalab.empleos.persistence.jpa.catalogs.entity.CatalogAreaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface JpaCatalogAreaRepository extends JpaRepository<CatalogAreaEntity, UUID> {

    List<CatalogAreaEntity> findByActiveTrueOrderByNameAsc();

    boolean existsByIdAndActiveTrue(UUID id);
}
