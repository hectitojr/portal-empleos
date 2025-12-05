package com.zoedatalab.empleos.persistence.jpa.companies.entity;

import com.vladmihalcea.hibernate.type.basic.PostgreSQLCITextType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "companies")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CompanyEntity {

    @Id
    @Column(name = "id", columnDefinition = "uuid", nullable = false)
    private UUID id;

    @Column(name = "user_id", nullable = false, columnDefinition = "uuid", unique = true)
    private UUID userId;

    @Column(name = "legal_name")
    private String legalName;

    @Column(name = "tax_id")
    private String taxId;

    @Column(name = "contact_email", columnDefinition = "citext")
    @Type(PostgreSQLCITextType.class)
    private String contactEmail;

    @Column(name = "contact_phone")
    private String contactPhone;

    @Column(name = "district_id", columnDefinition = "uuid")
    private UUID districtId;

    @Column(name = "profile_complete", nullable = false)
    private boolean profileComplete;

    @Column(name = "active", nullable = false)
    private boolean active;

    @Column(name = "suspended", nullable = false)
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