package com.zoedatalab.empleos.persistence.jpa.entity;

import com.vladmihalcea.hibernate.type.basic.PostgreSQLCITextType;
import jakarta.persistence.CascadeType;
import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Type;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Entity
@Table(name = "applicants")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ApplicantEntity {

    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    @Column(name = "user_id", nullable = false, unique = true, columnDefinition = "uuid")
    private UUID userId;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column(name = "contact_email", nullable = false, columnDefinition = "citext")
    @Type(PostgreSQLCITextType.class)
    private String contactEmail;

    @Column(name = "contact_phone")
    private String contactPhone;

    @Column(name = "district_id", columnDefinition = "uuid")
    private UUID districtId;

    @Builder.Default
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("startDate DESC, id ASC") // orden estable para experiencia
    @OneToMany(mappedBy = "applicant", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<ApplicantExperienceEntity> experiences = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "applicant", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("startDate DESC, id ASC") // orden estable para educación
    private List<ApplicantEducationEntity> educations = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "applicant", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("name ASC, id ASC") // orden estable para skills
    private List<ApplicantSkillEntity> skills = new ArrayList<>();

    @Builder.Default
    @ElementCollection
    @CollectionTable(name = "applicant_disability", joinColumns = @JoinColumn(name = "applicant_id"))
    @Column(name = "disability_id", columnDefinition = "uuid")
    private Set<UUID> disabilityIds = new HashSet<>();

    @Column(name = "profile_summary")
    private String profileSummary;

    @Column(name = "profile_complete", nullable = false)
    private boolean profileComplete;

    @Column(nullable = false)
    private boolean active;

    @Column(nullable = false)
    private boolean suspended;

    @Column(name = "created_at", nullable = false, insertable = false, updatable = false)
    private Instant createdAt;

    @Column(name = "updated_at", nullable = false, insertable = false, updatable = false)
    private Instant updatedAt;

    @Column(name = "created_by")
    private UUID createdBy;

    @Column(name = "updated_by")
    private UUID updatedBy;

    @PrePersist
    void prePersist() {
        if (this.id == null) this.id = UUID.randomUUID();
    }
}
