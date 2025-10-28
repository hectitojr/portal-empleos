package com.zoedatalab.empleos.persistence.jpa.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "applications",
        uniqueConstraints = @UniqueConstraint(
                name = "uq_applications__job_applicant",
                columnNames = {"job_id","applicant_id"}
        ))
@Getter @Setter @Builder @AllArgsConstructor @NoArgsConstructor
public class ApplicationEntity {

    @Id
    @Column(nullable = false, columnDefinition = "uuid")
    private UUID id;

    @Column(name = "job_id", nullable = false, columnDefinition = "uuid")
    private UUID jobId;

    @Column(name = "applicant_id", nullable = false, columnDefinition = "uuid")
    private UUID applicantId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status;

    @Column(columnDefinition = "text")
    private String notes;

    @Column(name = "applied_at", nullable = false)
    private Instant appliedAt;

    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;

    @Column(name = "created_by", columnDefinition = "uuid")
    private UUID createdBy;

    @Column(name = "updated_by", columnDefinition = "uuid")
    private UUID updatedBy;

    public enum Status { APPLIED, IN_REVIEW, SHORTLISTED, HIRED, REJECTED }

    @PrePersist
    void prePersist() {
        if (this.id == null) this.id = UUID.randomUUID();
    }
}

