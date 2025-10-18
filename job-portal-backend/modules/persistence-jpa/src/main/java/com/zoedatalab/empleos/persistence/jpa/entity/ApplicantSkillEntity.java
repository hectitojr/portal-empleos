package com.zoedatalab.empleos.persistence.jpa.entity;

import jakarta.persistence.*;
import lombok.*;
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
