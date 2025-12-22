package com.zoedatalab.empleos.jobs.domain;

import com.zoedatalab.empleos.jobs.domain.text.JobTextNormalizer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Getter
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

    // -------------------------
    // Factory (DDD)
    // -------------------------
    public static JobOffer create(
            UUID id,
            UUID companyId,
            String title,
            String description,
            UUID areaId,
            UUID sectorId,
            UUID districtId,
            boolean disabilityFriendly,
            UUID employmentTypeId,
            UUID workModeId,
            String salaryText,
            Instant publishedAt
    ) {
        var job = new JobOffer();
        job.id = (id != null) ? id : UUID.randomUUID();
        job.companyId = companyId;

        job.title = JobTextNormalizer.normalizeTitle(title);
        job.description = JobTextNormalizer.normalizeDescription(description);

        job.areaId = areaId;
        job.sectorId = sectorId;
        job.districtId = districtId;
        job.disabilityFriendly = disabilityFriendly;

        job.employmentTypeId = employmentTypeId;
        job.workModeId = workModeId;
        job.salaryText = salaryText;

        job.status = Status.OPEN;
        job.publishedAt = (publishedAt != null) ? publishedAt : Instant.now();
        job.suspended = false;

        return job;
    }

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

        this.title = JobTextNormalizer.normalizeTitle(title);
        this.description = JobTextNormalizer.normalizeDescription(desc);

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
