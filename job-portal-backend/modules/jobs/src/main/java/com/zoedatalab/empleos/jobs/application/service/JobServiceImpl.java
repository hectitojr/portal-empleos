package com.zoedatalab.empleos.jobs.application.service;

import com.zoedatalab.empleos.jobs.application.dto.ApplicantJobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.ApplicantJobSummaryView;
import com.zoedatalab.empleos.jobs.application.dto.CreateJobCommand;
import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.JobSummaryView;
import com.zoedatalab.empleos.jobs.application.dto.UpdateJobCommand;
import com.zoedatalab.empleos.jobs.application.ports.in.JobCommandService;
import com.zoedatalab.empleos.jobs.application.ports.in.JobQueryService;
import com.zoedatalab.empleos.jobs.application.ports.out.ApplicantLookupPort;
import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobApplicantStatePort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.jobs.domain.JobOffer.Status;
import com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException;
import com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException;
import com.zoedatalab.empleos.jobs.domain.exception.JobClosedException;
import com.zoedatalab.empleos.jobs.domain.exception.JobNotFoundException;
import lombok.RequiredArgsConstructor;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
public class JobServiceImpl implements JobCommandService, JobQueryService {

    private final JobRepositoryPort repo;
    private final CompanyOwnershipPort ownership;

    private final ApplicantLookupPort applicantLookup;
    private final JobApplicantStatePort applicantState;

    // -------------------------
    // Commands (empresa)
    // -------------------------

    @Override
    public JobDetailView create(UUID companyUserId, CreateJobCommand cmd) {
        var own = ownership.getForUser(companyUserId);
        if (own.companyId() == null || !own.active() || !own.profileComplete()) {
            throw new CompanyIncompleteException();
        }

        var now = Instant.now();
        var job = JobOffer.builder()
                .id(UUID.randomUUID())
                .companyId(own.companyId())
                .title(cmd.title())
                .description(cmd.description())
                .areaId(cmd.areaId())
                .sectorId(cmd.sectorId())
                .districtId(cmd.districtId())
                .disabilityFriendly(cmd.disabilityFriendly())
                .employmentTypeId(cmd.employmentTypeId())
                .workModeId(cmd.workModeId())
                .salaryText(cmd.salaryText())
                .status(Status.OPEN)
                .publishedAt(now)
                .suspended(false)
                .build();

        job = repo.save(job);
        return detail(job);
    }

    @Override
    public JobDetailView update(UUID companyUserId, UUID jobId, UpdateJobCommand cmd) {
        var own = ownership.getForUser(companyUserId);
        var job = repo.findById(jobId).orElseThrow(JobNotFoundException::new);

        if (!repo.isOwner(jobId, own.companyId())) {
            throw new ForbiddenJobAccessException();
        }
        if (job.getStatus() == Status.CLOSED) {
            throw new JobClosedException();
        }

        job.edit(
                cmd.title(),
                cmd.description(),
                cmd.areaId(),
                cmd.sectorId(),
                cmd.districtId(),
                cmd.disabilityFriendly(),
                cmd.employmentTypeId(),
                cmd.workModeId(),
                cmd.salaryText()
        );

        job = repo.save(job);
        return detail(job);
    }

    @Override
    public JobDetailView close(UUID companyUserId, UUID jobId) {
        var own = ownership.getForUser(companyUserId);
        var job = repo.findById(jobId).orElseThrow(JobNotFoundException::new);

        if (!repo.isOwner(jobId, own.companyId())) {
            throw new ForbiddenJobAccessException();
        }

        job.close();
        job = repo.save(job);
        return detail(job);
    }

    // -------------------------
    // Queries públicas
    // -------------------------

    @Override
    public JobDetailView getById(UUID jobId) {
        return repo.findById(jobId)
                .map(this::detail)
                .orElseThrow(JobNotFoundException::new);
    }

    @Override
    public List<JobSummaryView> search(UUID areaId, UUID sectorId, UUID districtId,
                                       Boolean disabilityFriendly, Instant fromDate,
                                       int page, int size) {

        var jobs = repo.search(areaId, sectorId, districtId, disabilityFriendly, fromDate, page, size);

        return jobs.stream()
                .map(j -> {
                    boolean active = isActive(j);
                    boolean applied = false;
                    boolean viewed = false;

                    String quickText =
                            (j.getStatus() == Status.CLOSED || j.isSuspended())
                                    ? "Ya no se aceptan postulaciones"
                                    : "Postúlate a la oferta rápidamente";

                    return new JobSummaryView(
                            j.getId(),
                            j.getTitle(),
                            j.getCompanyId(),
                            ownership.publicName(j.getCompanyId()),
                            j.getSectorId(),
                            j.getDistrictId(),
                            j.isDisabilityFriendly(),
                            j.getEmploymentTypeId(),
                            j.getWorkModeId(),
                            j.getSalaryText(),

                            active,
                            applied,
                            viewed,
                            quickText,

                            j.getStatus().name(),
                            j.getPublishedAt()
                    );
                })
                .toList();
    }

    // -------------------------
    // Queries applicant logueado
    // -------------------------

    @Override
    public List<ApplicantJobSummaryView> searchForApplicant(UUID applicantUserId,
                                                            UUID areaId, UUID sectorId, UUID districtId,
                                                            Boolean disabilityFriendly, Instant fromDate,
                                                            int page, int size) {

        var jobs = repo.search(areaId, sectorId, districtId, disabilityFriendly, fromDate, page, size);

        var applicantId = applicantLookup.getApplicantIdByUserId(applicantUserId);

        var ids = jobs.stream().map(JobOffer::getId).toList();
        var appliedIds = applicantState.findAppliedJobIds(applicantId, ids);
        var viewedIds = applicantState.findViewedJobIds(applicantId, ids);

        return jobs.stream()
                .map(j -> {
                    boolean applied = appliedIds.contains(j.getId());
                    boolean viewed = viewedIds.contains(j.getId());
                    boolean active = isActive(j);

                    String quickText = quickApplyText(j, applied);

                    return new ApplicantJobSummaryView(
                            j.getId(),
                            j.getTitle(),
                            ownership.publicName(j.getCompanyId()),
                            j.getSectorId(),
                            j.getDistrictId(),
                            j.getEmploymentTypeId(),
                            j.getWorkModeId(),
                            j.getSalaryText(),
                            j.isDisabilityFriendly(),
                            j.getStatus().name(),
                            j.getPublishedAt(),
                            viewed,
                            applied,
                            quickText,
                            active
                    );
                })
                .toList();
    }

    @Override
    public ApplicantJobDetailView getByIdForApplicant(UUID applicantUserId, UUID jobId) {
        var job = repo.findById(jobId).orElseThrow(JobNotFoundException::new);

        var applicantId = applicantLookup.getApplicantIdByUserId(applicantUserId);

        applicantState.markViewed(applicantId, jobId, Instant.now());

        boolean applied = applicantState.isApplied(applicantId, jobId);
        boolean viewed = true;
        boolean active = isActive(job);

        String quickText = quickApplyText(job, applied);

        return new ApplicantJobDetailView(
                job.getId(),
                job.getCompanyId(),
                job.getTitle(),
                job.getDescription(),
                job.getAreaId(),
                job.getSectorId(),
                job.getDistrictId(),
                job.getEmploymentTypeId(),
                job.getWorkModeId(),
                job.getSalaryText(),
                job.isDisabilityFriendly(),
                job.getStatus().name(),
                job.getPublishedAt(),
                job.isSuspended(),
                viewed,
                applied,
                quickText,
                active
        );
    }

    // -------------------------
    // Helpers internos
    // -------------------------

    private boolean isActive(JobOffer j) {
        return j.getStatus() == Status.OPEN && !j.isSuspended();
    }

    private String quickApplyText(JobOffer j, boolean applied) {
        if (j.getStatus() == Status.CLOSED || j.isSuspended()) {
            return "Ya no se aceptan postulaciones";
        }
        if (applied) {
            return "Ya te postulaste a esta oferta";
        }
        return "Postúlate a la oferta rápidamente";
    }

    private JobDetailView detail(JobOffer j) {
        return new JobDetailView(
                j.getId(),
                j.getCompanyId(),
                j.getTitle(),
                j.getDescription(),
                j.getAreaId(),
                j.getSectorId(),
                j.getDistrictId(),
                j.isDisabilityFriendly(),
                j.getEmploymentTypeId(),
                j.getWorkModeId(),
                j.getSalaryText(),
                j.getStatus().name(),
                j.getPublishedAt(),
                j.isSuspended()
        );
    }
}
