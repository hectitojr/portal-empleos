package com.zoedatalab.empleos.persistence.jpa.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Entity
@Table(name = "applicant_skill")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ApplicantSkillEntity {

    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "applicant_id", nullable = false, columnDefinition = "uuid")
    private ApplicantEntity applicant;

    @Column(nullable = false)
    private String name;

    private String level;

    @PrePersist
    void prePersist() {
        if (this.id == null) this.id = UUID.randomUUID();
    }
}
