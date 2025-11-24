package com.zoedatalab.empleos.persistence.jpa.entity;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "job_offers")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class JobOfferEntity {

    @Id
    @Column(columnDefinition = "uuid", nullable = false)
    private UUID id;

    @Column(name = "company_id", columnDefinition = "uuid", nullable = false)
    private UUID companyId;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false, columnDefinition = "text")
    private String description;

    @Column(name = "area_id", columnDefinition = "uuid")
    private UUID areaId;

    @Column(name = "sector_id", columnDefinition = "uuid")
    private UUID sectorId;

    @Column(name = "district_id", columnDefinition = "uuid")
    private UUID districtId;

    @Column(name = "disability_friendly", nullable = false)
    private boolean disabilityFriendly;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status;

    @Column(name = "published_at", nullable = false)
    private Instant publishedAt;

    @Column(nullable = false)
    private boolean suspended;

    public enum Status { OPEN, CLOSED }

    @PrePersist
    void prePersist() {
        if (this.id == null) this.id = UUID.randomUUID();
    }
}
