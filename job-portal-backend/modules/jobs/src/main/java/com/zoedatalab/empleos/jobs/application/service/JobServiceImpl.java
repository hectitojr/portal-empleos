package com.zoedatalab.empleos.jobs.application.service;

import com.zoedatalab.empleos.common.catalogs.exception.AreaNotFoundException;
import com.zoedatalab.empleos.common.catalogs.exception.DistrictNotFoundException;
import com.zoedatalab.empleos.common.catalogs.exception.EmploymentTypeNotFoundException;
import com.zoedatalab.empleos.common.catalogs.exception.SectorNotFoundException;
import com.zoedatalab.empleos.common.catalogs.exception.WorkModeNotFoundException;
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
import com.zoedatalab.empleos.jobs.application.ports.out.JobCatalogValidationPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobLocationQueryPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.jobs.domain.JobOffer.Status;
import com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException;
import com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException;
import com.zoedatalab.empleos.jobs.domain.exception.JobClosedException;
import com.zoedatalab.empleos.jobs.domain.exception.JobNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static com.zoedatalab.empleos.jobs.application.util.SalaryTextFormatter.toPenText;

@Slf4j
@RequiredArgsConstructor
public class JobServiceImpl implements JobCommandService, JobQueryService {

    private final JobRepositoryPort repo;
    private final CompanyOwnershipPort ownership;
    private final ApplicantLookupPort applicantLookup;
    private final JobApplicantStatePort applicantState;
    private final JobLocationQueryPort jobLocationQueries;

    private final JobCatalogValidationPort catalogValidation;

    // -------------------------
    // Geo filter normalization
    // -------------------------
    private GeoFilter normalizeGeo(UUID departmentId, UUID provinceId, UUID districtId) {
        if (districtId != null) return new GeoFilter(null, null, districtId);
        if (provinceId != null) return new GeoFilter(null, provinceId, null);
        if (departmentId != null) return new GeoFilter(departmentId, null, null);
        return new GeoFilter(null, null, null);
    }

    @Override
    public JobDetailView create(UUID companyUserId, CreateJobCommand cmd) {
        var own = ownership.getForUser(companyUserId);
        if (own.companyId() == null || !own.active() || !own.profileComplete()) {
            throw new CompanyIncompleteException();
        }

        validateCatalogs(cmd.areaId(), cmd.sectorId(), cmd.districtId(), cmd.employmentTypeId(), cmd.workModeId());

        String salaryText = toPenText(cmd.salaryMin(), cmd.salaryMax());

        var now = Instant.now();

        var job = JobOffer.create(
                UUID.randomUUID(),
                own.companyId(),
                cmd.title(),
                cmd.description(),
                cmd.areaId(),
                cmd.sectorId(),
                cmd.districtId(),
                cmd.disabilityFriendly(),
                cmd.employmentTypeId(),
                cmd.workModeId(),
                salaryText,
                now
        );

        job = repo.save(job);
        repo.flush();
        return getById(job.getId());
    }

    // -------------------------
    // Commands (empresa)
    // -------------------------

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

        validateCatalogs(cmd.areaId(), cmd.sectorId(), cmd.districtId(), cmd.employmentTypeId(), cmd.workModeId());

        String salaryText = toPenText(cmd.salaryMin(), cmd.salaryMax());

        job.edit(
                cmd.title(),
                cmd.description(),
                cmd.areaId(),
                cmd.sectorId(),
                cmd.districtId(),
                cmd.disabilityFriendly(),
                cmd.employmentTypeId(),
                cmd.workModeId(),
                salaryText
        );

        repo.save(job);
        repo.flush();

        return getById(jobId);
    }

    @Override
    public JobDetailView close(UUID companyUserId, UUID jobId) {
        var own = ownership.getForUser(companyUserId);
        var job = repo.findById(jobId).orElseThrow(JobNotFoundException::new);

        if (!repo.isOwner(jobId, own.companyId())) {
            throw new ForbiddenJobAccessException();
        }

        job.close();
        repo.save(job);
        repo.flush();

        return getById(jobId);
    }

    @Override
    public JobDetailView getById(UUID jobId) {
        var r = jobLocationQueries.findDetail(jobId)
                .orElseThrow(JobNotFoundException::new);

        return new JobDetailView(
                r.id(),
                r.companyId(),
                r.title(),
                r.description(),
                r.areaId(),
                r.sectorId(),
                r.districtId(),
                r.departmentName(),
                r.provinceName(),
                r.districtName(),
                r.disabilityFriendly(),
                r.employmentTypeId(),
                r.workModeId(),
                r.salaryText(),
                r.status(),
                r.publishedAt(),
                r.suspended()
        );
    }

    // -------------------------
    // Queries públicas
    // -------------------------

    @Override
    public List<JobSummaryView> search(UUID areaId,
                                       UUID sectorId,
                                       UUID departmentId,
                                       UUID provinceId,
                                       UUID districtId,
                                       Boolean disabilityFriendly,
                                       Instant fromDate,
                                       int page,
                                       int size) {

        var geo = normalizeGeo(departmentId, provinceId, districtId);

        var rows = jobLocationQueries.searchSummaries(
                areaId,
                sectorId,
                geo.departmentId(),
                geo.provinceId(),
                geo.districtId(),
                disabilityFriendly,
                fromDate,
                page,
                size
        );

        return rows.stream()
                .map(r -> {
                    boolean active = isActive(r.status(), r.suspended());

                    String quickText =
                            (!active)
                                    ? "Ya no se aceptan postulaciones"
                                    : "Postúlate a la oferta rápidamente";

                    return new JobSummaryView(
                            r.id(),
                            r.title(),
                            r.companyId(),
                            ownership.publicName(r.companyId()),
                            r.sectorId(),
                            r.districtId(),
                            r.provinceName(),
                            r.districtName(),
                            r.departmentName(),
                            r.disabilityFriendly(),
                            r.employmentTypeId(),
                            r.workModeId(),
                            r.salaryText(),
                            active,
                            false,
                            false,
                            quickText,
                            r.status(),
                            r.publishedAt()
                    );
                })
                .toList();
    }

    // -------------------------
    // Queries company (mis ofertas)
    // -------------------------

    @Override
    public List<JobSummaryView> searchForCompany(UUID companyUserId,
                                                 String q,
                                                 String status,
                                                 Instant fromDate,
                                                 int page,
                                                 int size) {

        var own = ownership.getForUser(companyUserId);
        if (own.companyId() == null || !own.active() || !own.profileComplete()) {
            throw new CompanyIncompleteException();
        }

        var rows = jobLocationQueries.searchCompanySummaries(
                own.companyId(),
                q,
                status,
                fromDate,
                page,
                size
        );

        return rows.stream()
                .map(r -> {
                    boolean active = isActive(r.status(), r.suspended());

                    String quickText = null;

                    if (r.suspended()) {
                        quickText = "Oferta suspendida temporalmente";
                    } else if ("CLOSED".equals(r.status())) {
                        quickText = "Ya no se aceptan postulaciones";
                    }

                    return new JobSummaryView(
                            r.id(),
                            r.title(),
                            r.companyId(),
                            ownership.publicName(r.companyId()),
                            r.sectorId(),
                            r.districtId(),
                            r.provinceName(),
                            r.districtName(),
                            r.departmentName(),
                            r.disabilityFriendly(),
                            r.employmentTypeId(),
                            r.workModeId(),
                            r.salaryText(),
                            active,
                            false,
                            false,
                            quickText,
                            r.status(),
                            r.publishedAt()
                    );
                })
                .toList();
    }

    @Override
    public List<ApplicantJobSummaryView> searchForApplicant(UUID applicantUserId,
                                                            UUID areaId,
                                                            UUID sectorId,
                                                            UUID departmentId,
                                                            UUID provinceId,
                                                            UUID districtId,
                                                            Boolean disabilityFriendly,
                                                            Instant fromDate,
                                                            int page,
                                                            int size) {

        var geo = normalizeGeo(departmentId, provinceId, districtId);

        var rows = jobLocationQueries.searchSummaries(
                areaId,
                sectorId,
                geo.departmentId(),
                geo.provinceId(),
                geo.districtId(),
                disabilityFriendly,
                fromDate,
                page,
                size
        );

        var applicantId = resolveApplicantId(applicantUserId);

        var ids = rows.stream().map(JobLocationQueryPort.JobSummaryRow::id).toList();
        var appliedIds = applicantState.findAppliedJobIds(applicantId, ids);
        var viewedIds = applicantState.findViewedJobIds(applicantId, ids);

        return rows.stream()
                .map(r -> {
                    boolean applied = appliedIds.contains(r.id());
                    boolean viewed = viewedIds.contains(r.id());
                    boolean active = isActive(r.status(), r.suspended());
                    String quickText = quickApplyText(r.status(), r.suspended(), applied);

                    return new ApplicantJobSummaryView(
                            r.id(),
                            r.title(),
                            ownership.publicName(r.companyId()),
                            r.sectorId(),
                            r.districtId(),
                            r.departmentName(),
                            r.provinceName(),
                            r.districtName(),
                            r.employmentTypeId(),
                            r.workModeId(),
                            r.salaryText(),
                            r.disabilityFriendly(),
                            r.status(),
                            r.publishedAt(),
                            viewed,
                            applied,
                            quickText,
                            active
                    );
                })
                .toList();
    }

    // -------------------------
    // Queries applicant logueado
    // -------------------------

    @Override
    public ApplicantJobDetailView getByIdForApplicant(UUID applicantUserId, UUID jobId) {
        var r = jobLocationQueries.findDetail(jobId)
                .orElseThrow(JobNotFoundException::new);

        var applicantId = resolveApplicantId(applicantUserId);

        applicantState.markViewed(applicantId, jobId, Instant.now());

        boolean applied = applicantState.isApplied(applicantId, jobId);
        boolean viewed = true;
        boolean active = isActive(r.status(), r.suspended());
        String quickText = quickApplyText(r.status(), r.suspended(), applied);

        return new ApplicantJobDetailView(
                r.id(),
                r.companyId(),
                r.title(),
                r.description(),
                r.areaId(),
                r.sectorId(),
                r.districtId(),
                r.departmentName(),
                r.provinceName(),
                r.districtName(),
                r.employmentTypeId(),
                r.workModeId(),
                r.salaryText(),
                r.disabilityFriendly(),
                r.status(),
                r.publishedAt(),
                r.suspended(),
                viewed,
                applied,
                quickText,
                active
        );
    }

    private boolean isActive(String status, boolean suspended) {
        return "OPEN".equals(status) && !suspended;
    }

    // -------------------------
    // Helpers internos
    // -------------------------

    private String quickApplyText(String status, boolean suspended, boolean applied) {
        if (!"OPEN".equals(status) || suspended) {
            return "Ya no se aceptan postulaciones";
        }
        if (applied) {
            return "Ya te postulaste a esta oferta";
        }
        return "Postúlate a la oferta rápidamente";
    }

    private void logApplicantResolved(UUID applicantUserId, UUID applicantId) {
        log.debug("Resolved applicantId for userId={} applicantId={}", applicantUserId, applicantId);
    }

    private UUID resolveApplicantId(UUID applicantUserId) {
        UUID applicantId = applicantLookup.getApplicantIdByUserId(applicantUserId);
        logApplicantResolved(applicantUserId, applicantId);
        return applicantId;
    }

    private void validateCatalogs(UUID areaId,
                                  UUID sectorId,
                                  UUID districtId,
                                  UUID employmentTypeId,
                                  UUID workModeId) {

        if (areaId != null && !catalogValidation.areaExists(areaId)) {
            throw new AreaNotFoundException();
        }
        if (sectorId != null && !catalogValidation.sectorExists(sectorId)) {
            throw new SectorNotFoundException();
        }
        if (districtId != null && !catalogValidation.districtExists(districtId)) {
            throw new DistrictNotFoundException();
        }
        if (employmentTypeId != null && !catalogValidation.employmentTypeExists(employmentTypeId)) {
            throw new EmploymentTypeNotFoundException();
        }
        if (workModeId != null && !catalogValidation.workModeExists(workModeId)) {
            throw new WorkModeNotFoundException();
        }
    }

    private record GeoFilter(UUID departmentId, UUID provinceId, UUID districtId) {
    }
}
