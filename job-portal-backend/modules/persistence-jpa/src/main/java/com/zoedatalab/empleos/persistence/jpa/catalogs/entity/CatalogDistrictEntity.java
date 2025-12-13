package com.zoedatalab.empleos.persistence.jpa.catalogs.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Entity
@Table(
        name = "catalog_district",
        uniqueConstraints = {
                @UniqueConstraint(name = "uq_catalog_district__province_name", columnNames = {"province_id", "name"})
        }
)
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CatalogDistrictEntity {

    @Id
    private UUID id;

    @Column(name = "department_id", nullable = false)
    private UUID departmentId;

    @Column(name = "province_id", nullable = false)
    private UUID provinceId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private boolean active;
}

