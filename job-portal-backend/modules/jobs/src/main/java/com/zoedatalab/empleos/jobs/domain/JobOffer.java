package com.zoedatalab.empleos.jobs.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class JobOffer {

    private UUID id;
    private UUID companyId;
    private String title;
    private String description;
    private UUID areaId;
    private UUID sectorId;
    private UUID districtId;
    private boolean disabilityFriendly;
    
    private UUID employmentTypeId;
    private UUID workModeId;
    private String salaryText;

    private Status status;
    private Instant publishedAt;
    private boolean suspended;

    /**
     * Editar una oferta de empleo.
     * Solo se permite edición cuando está OPEN.
     */
    public void edit(
            String title,
            String desc,
            UUID areaId,
            UUID sectorId,
            UUID districtId,
            boolean disability,
            UUID employmentTypeId,
            UUID workModeId,
            String salaryText
    ) {
        if (this.status == Status.CLOSED) throw new IllegalStateException("JOB_CLOSED");

        this.title = title;
        this.description = desc;
        this.areaId = areaId;
        this.sectorId = sectorId;
        this.districtId = districtId;
        this.disabilityFriendly = disability;

        this.employmentTypeId = employmentTypeId;
        this.workModeId = workModeId;
        this.salaryText = salaryText;
    }

    /**
     * Cierra la oferta para postulaciones.
     */
    public void close() {
        if (this.status == Status.CLOSED) return;
        this.status = Status.CLOSED;
    }

    public enum Status {OPEN, CLOSED}
}
