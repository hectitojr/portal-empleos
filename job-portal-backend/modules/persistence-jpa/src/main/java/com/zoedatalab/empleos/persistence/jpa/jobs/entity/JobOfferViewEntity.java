package com.zoedatalab.empleos.persistence.jpa.jobs.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
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
@Table(name = "job_offer_views")
@IdClass(JobOfferViewId.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JobOfferViewEntity {

    @Id
    @Column(name = "applicant_id", columnDefinition = "uuid", nullable = false)
    private UUID applicantId;

    @Id
    @Column(name = "job_id", columnDefinition = "uuid", nullable = false)
    private UUID jobId;

    @Column(name = "first_viewed_at", nullable = false)
    private Instant firstViewedAt;

    @PrePersist
    void prePersist() {
        if (this.firstViewedAt == null) this.firstViewedAt = Instant.now();
    }
}
