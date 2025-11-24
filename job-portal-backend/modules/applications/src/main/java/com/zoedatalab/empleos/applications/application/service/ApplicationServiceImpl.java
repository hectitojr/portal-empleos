package com.zoedatalab.empleos.applications.application.service;

import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.applicants.domain.Applicant;
import com.zoedatalab.empleos.applicants.domain.exception.ApplicantNotFoundException;
import com.zoedatalab.empleos.applications.application.dto.ApplicationView;
import com.zoedatalab.empleos.applications.application.dto.ApplyToJobCommand;
import com.zoedatalab.empleos.applications.application.dto.UpdateApplicationStatusCommand;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationCommandService;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationQueryService;
import com.zoedatalab.empleos.applications.application.ports.out.ApplicationRepositoryPort;
import com.zoedatalab.empleos.applications.domain.Application;
import com.zoedatalab.empleos.applications.domain.exception.ApplicantProfileIncompleteException;
import com.zoedatalab.empleos.applications.domain.exception.ApplicationNotFoundException;
import com.zoedatalab.empleos.applications.domain.exception.DuplicateApplicationException;
import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException;
import com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException;
import com.zoedatalab.empleos.jobs.domain.exception.JobClosedException;
import com.zoedatalab.empleos.jobs.domain.exception.JobNotFoundException;
import lombok.RequiredArgsConstructor;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
public class ApplicationServiceImpl implements ApplicationCommandService, ApplicationQueryService {

    private final ApplicationRepositoryPort repo;
    private final ApplicantRepositoryPort applicantRepo;
    private final JobRepositoryPort jobRepo;
    private final CompanyOwnershipPort ownershipPort;

    @Override
    public ApplicationView apply(UUID applicantUserId, UUID jobId, ApplyToJobCommand cmd) {

        Applicant applicant = applicantRepo.findByUserId(applicantUserId)
                .orElseThrow(ApplicantNotFoundException::new);

        if (!applicant.isActive() || applicant.isSuspended() || !applicant.isProfileComplete()) {
            throw new ApplicantProfileIncompleteException();
        }

        JobOffer job = jobRepo.findById(jobId).orElseThrow(JobNotFoundException::new);
        if (job.getStatus() == JobOffer.Status.CLOSED) {
            throw new JobClosedException();
        }

        if (repo.existsByJobAndApplicant(jobId, applicant.getId())) {
            throw new DuplicateApplicationException();
        }

        var now = Instant.now();
        var a = Application.builder()
                .id(null)
                .jobId(jobId)
                .applicantId(applicant.getId())
                .status(Application.Status.APPLIED)
                .notes(cmd != null ? cmd.notes() : null)
                .appliedAt(now)
                .updatedAt(now)
                .createdBy(applicantUserId)
                .updatedBy(applicantUserId)
                .build();

        var saved = repo.save(a);
        return toView(saved);
    }

    @Override
    public ApplicationView updateStatus(UUID companyUserId, UUID applicationId, UpdateApplicationStatusCommand cmd) {
        var app = getApplicationOrThrow(applicationId);

        var companyId = getCompanyIdOrThrow(companyUserId);
        assertJobOwner(app.getJobId(), companyId);

        app.moveTo(cmd.status());
        app.setUpdatedBy(companyUserId);
        app.setUpdatedAt(Instant.now());

        var saved = repo.save(app);
        return toView(saved);
    }

    @Override
    public List<ApplicationView> myApplications(UUID applicantUserId, int page, int size) {
        var applicant = applicantRepo.findByUserId(applicantUserId)
                .orElseThrow(ApplicantNotFoundException::new);

        return repo.findByApplicant(applicant.getId(), page, size)
                .stream()
                .map(this::toView)
                .toList();
    }

    @Override
    public List<ApplicationView> listForJob(UUID companyUserId, UUID jobId, int page, int size) {
        var companyId = getCompanyIdOrThrow(companyUserId);

        jobRepo.findById(jobId).orElseThrow(JobNotFoundException::new);
        assertJobOwner(jobId, companyId);

        return repo.findByJob(jobId, page, size)
                .stream()
                .map(this::toView)
                .toList();
    }

    @Override
    public ApplicationView getByIdAuthorizedForCompany(UUID companyUserId, UUID applicationId) {
        var app = getApplicationOrThrow(applicationId);

        var companyId = getCompanyIdOrThrow(companyUserId);
        assertJobOwner(app.getJobId(), companyId);

        return toView(app);
    }

    private Application getApplicationOrThrow(UUID applicationId) {
        return repo.findById(applicationId)
                .orElseThrow(ApplicationNotFoundException::new);
    }

    private UUID getCompanyIdOrThrow(UUID companyUserId) {
        var co = ownershipPort.getForUser(companyUserId);
        if (co == null || co.companyId() == null || !co.active() || !co.profileComplete()) {
            throw new CompanyIncompleteException();
        }
        return co.companyId();
    }

    private void assertJobOwner(UUID jobId, UUID companyId) {
        if (!jobRepo.isOwner(jobId, companyId)) {
            throw new ForbiddenJobAccessException();
        }
    }

    private ApplicationView toView(Application a) {
        return new ApplicationView(
                a.getId(),
                a.getJobId(),
                a.getApplicantId(),
                a.getStatus(),
                a.getNotes(),
                a.getAppliedAt()
        );
    }
}
