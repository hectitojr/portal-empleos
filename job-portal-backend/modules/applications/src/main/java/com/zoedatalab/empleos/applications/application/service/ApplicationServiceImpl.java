package com.zoedatalab.empleos.applications.application.service;

import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.applicants.domain.Applicant;
import com.zoedatalab.empleos.applicants.domain.exception.ApplicantNotFoundException;
import com.zoedatalab.empleos.applications.application.dto.*;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationCommandService;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationQueryService;
import com.zoedatalab.empleos.applications.application.ports.out.ApplicationRepositoryPort;
import com.zoedatalab.empleos.applications.domain.Application;
import com.zoedatalab.empleos.applications.domain.exception.*;
import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.domain.JobOffer;
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
        // 1) Applicant (por user) existe y perfil completo/activo/no suspendido
        Applicant applicant = applicantRepo.findByUserId(applicantUserId)
                .orElseThrow(ApplicantNotFoundException::new);
        if (!applicant.isActive() || applicant.isSuspended() || !applicant.isProfileComplete()) {
            throw new ApplicantProfileIncompleteException();
        }

        // 2) Job existe y está OPEN (dominio)
        JobOffer job = jobRepo.findById(jobId).orElseThrow(JobNotFoundException::new);
        if (job.getStatus() == JobOffer.Status.CLOSED) {
            throw new JobClosedException();
        }

        // 3) Unicidad (job, applicant)
        if (repo.existsByJobAndApplicant(jobId, applicant.getId())) {
            throw new DuplicateApplicationException();
        }

        // 4) Persistir
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
        var app = repo.findById(applicationId).orElseThrow(ApplicationNotFoundException::new);

        // Autorizar: el usuario company debe ser dueño del job
        var co = ownershipPort.getForUser(companyUserId);
        if (co == null || co.companyId() == null || !co.active() || !co.profileComplete()) {
            throw new com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException();
        }
        if (!jobRepo.isOwner(app.getJobId(), co.companyId())) {
            throw new com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException();
        }

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
        return repo.findByApplicant(applicant.getId(), page, size).stream().map(this::toView).toList();
    }

    @Override
    public List<ApplicationView> listForJob(UUID companyUserId, UUID jobId, int page, int size) {
        var co = ownershipPort.getForUser(companyUserId);
        if (co == null || co.companyId() == null || !co.active() || !co.profileComplete()) {
            throw new com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException();
        }
        // Job existente y de la empresa
        jobRepo.findById(jobId).orElseThrow(JobNotFoundException::new);
        if (!jobRepo.isOwner(jobId, co.companyId())) {
            throw new com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException();
        }
        return repo.findByJob(jobId, page, size).stream().map(this::toView).toList();
    }

    @Override
    public ApplicationView getByIdAuthorizedForCompany(UUID companyUserId, UUID applicationId) {
        var app = repo.findById(applicationId).orElseThrow(ApplicationNotFoundException::new);
        var co = ownershipPort.getForUser(companyUserId);
        if (co == null || co.companyId() == null || !co.active() || !co.profileComplete()) {
            throw new com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException();
        }
        if (!jobRepo.isOwner(app.getJobId(), co.companyId())) {
            throw new com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException();
        }
        return toView(app);
    }

    private ApplicationView toView(Application a) {
        return new ApplicationView(
                a.getId(), a.getJobId(), a.getApplicantId(), a.getStatus(), a.getNotes(), a.getAppliedAt()
        );
    }
}