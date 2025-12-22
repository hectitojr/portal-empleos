package com.zoedatalab.empleos.applications.application.service;

import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.applicants.domain.Applicant;
import com.zoedatalab.empleos.applicants.domain.exception.ApplicantNotFoundException;
import com.zoedatalab.empleos.applications.application.dto.ApplicationView;
import com.zoedatalab.empleos.applications.application.dto.ApplyToJobCommand;
import com.zoedatalab.empleos.applications.application.dto.UpdateApplicationStatusCommand;
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
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.any;
import static org.mockito.Mockito.anyInt;
import static org.mockito.Mockito.argThat;
import static org.mockito.Mockito.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class ApplicationServiceImplTest {

    private final UUID applicantUserId = UUID.randomUUID();
    private final UUID applicantId = UUID.randomUUID();
    private final UUID companyId = UUID.randomUUID();
    private final UUID jobId = UUID.randomUUID();
    private final UUID applicationId = UUID.randomUUID();
    private ApplicationRepositoryPort repo;
    private ApplicantRepositoryPort applicantRepo;
    private JobRepositoryPort jobRepo;
    private CompanyOwnershipPort ownershipPort;
    private ApplicationServiceImpl service;

    @BeforeEach
    void setUp() {
        repo = mock(ApplicationRepositoryPort.class);
        applicantRepo = mock(ApplicantRepositoryPort.class);
        jobRepo = mock(JobRepositoryPort.class);
        ownershipPort = mock(CompanyOwnershipPort.class);
        service = new ApplicationServiceImpl(repo, applicantRepo, jobRepo, ownershipPort);
    }

    private Applicant applicant(boolean complete, boolean active, boolean suspended) {
        return Applicant.builder()
                .id(applicantId)
                .userId(applicantUserId)
                .profileComplete(complete)
                .active(active)
                .suspended(suspended)
                .build();
    }

    private JobOffer job(JobOffer.Status status) {
        JobOffer job = JobOffer.create(
                jobId,
                companyId,
                "T",
                "D",
                null,
                null,
                UUID.randomUUID(),
                false,
                null,
                null,
                null,
                Instant.now()
        );

        if (status == JobOffer.Status.CLOSED) {
            job.close();
        }

        return job;
    }

    @Test
    void apply_ok_creaApplicationEnEstadoApplied() {
        when(applicantRepo.findByUserId(applicantUserId))
                .thenReturn(Optional.of(applicant(true, true, false)));
        when(jobRepo.findById(jobId)).thenReturn(Optional.of(job(JobOffer.Status.OPEN)));
        when(repo.existsByJobAndApplicant(jobId, applicantId)).thenReturn(false);

        var cmd = new ApplyToJobCommand("hola");
        var saved = Application.builder()
                .id(UUID.randomUUID())
                .jobId(jobId)
                .applicantId(applicantId)
                .status(Application.Status.APPLIED)
                .notes("hola")
                .appliedAt(Instant.now())
                .updatedAt(Instant.now())
                .createdBy(applicantUserId)
                .updatedBy(applicantUserId)
                .build();
        when(repo.save(any())).thenReturn(saved);

        ApplicationView view = service.apply(applicantUserId, jobId, cmd);

        assertEquals(saved.getId(), view.id());
        assertEquals(Application.Status.APPLIED, view.status());

        // además verificamos los datos enviados al repo
        ArgumentCaptor<Application> captor = ArgumentCaptor.forClass(Application.class);
        verify(repo).save(captor.capture());
        var toSave = captor.getValue();
        assertEquals(jobId, toSave.getJobId());
        assertEquals(applicantId, toSave.getApplicantId());
        assertEquals("hola", toSave.getNotes());
        assertEquals(applicantUserId, toSave.getCreatedBy());
        assertEquals(Application.Status.APPLIED, toSave.getStatus());
    }

    @Test
    void apply_falla_siApplicantNoExiste() {
        when(applicantRepo.findByUserId(applicantUserId)).thenReturn(Optional.empty());
        assertThrows(ApplicantNotFoundException.class,
                () -> service.apply(applicantUserId, jobId, new ApplyToJobCommand(null)));
    }

    @Test
    void apply_falla_siApplicantIncompletoInactivoOSuspendido() {
        when(applicantRepo.findByUserId(applicantUserId))
                .thenReturn(Optional.of(applicant(false, true, false)));
        assertThrows(ApplicantProfileIncompleteException.class,
                () -> service.apply(applicantUserId, jobId, new ApplyToJobCommand(null)));

        when(applicantRepo.findByUserId(applicantUserId))
                .thenReturn(Optional.of(applicant(true, false, false)));
        assertThrows(ApplicantProfileIncompleteException.class,
                () -> service.apply(applicantUserId, jobId, new ApplyToJobCommand(null)));

        when(applicantRepo.findByUserId(applicantUserId))
                .thenReturn(Optional.of(applicant(true, true, true)));
        assertThrows(ApplicantProfileIncompleteException.class,
                () -> service.apply(applicantUserId, jobId, new ApplyToJobCommand(null)));
    }

    @Test
    void apply_falla_siJobNoExiste() {
        when(applicantRepo.findByUserId(applicantUserId))
                .thenReturn(Optional.of(applicant(true, true, false)));
        when(jobRepo.findById(jobId)).thenReturn(Optional.empty());

        assertThrows(JobNotFoundException.class,
                () -> service.apply(applicantUserId, jobId, new ApplyToJobCommand(null)));
    }

    @Test
    void apply_falla_siJobCerrado() {
        when(applicantRepo.findByUserId(applicantUserId))
                .thenReturn(Optional.of(applicant(true, true, false)));
        when(jobRepo.findById(jobId)).thenReturn(Optional.of(job(JobOffer.Status.CLOSED)));

        assertThrows(JobClosedException.class,
                () -> service.apply(applicantUserId, jobId, new ApplyToJobCommand(null)));
    }

    @Test
    void apply_falla_siDuplicada() {
        when(applicantRepo.findByUserId(applicantUserId))
                .thenReturn(Optional.of(applicant(true, true, false)));
        when(jobRepo.findById(jobId)).thenReturn(Optional.of(job(JobOffer.Status.OPEN)));
        when(repo.existsByJobAndApplicant(jobId, applicantId)).thenReturn(true);

        assertThrows(DuplicateApplicationException.class,
                () -> service.apply(applicantUserId, jobId, new ApplyToJobCommand(null)));
    }

    // ===== updateStatus() =====

    @Test
    void updateStatus_ok_cambiaEstado_yAudita() {
        var app = Application.builder()
                .id(applicationId)
                .jobId(jobId)
                .applicantId(applicantId)
                .status(Application.Status.APPLIED)
                .build();

        when(repo.findById(applicationId)).thenReturn(Optional.of(app));
        // ownership ok
        var ownership = new CompanyOwnershipPort.CompanyOwnership(companyId, true, true);
        when(ownershipPort.getForUser(any())).thenReturn(ownership);
        when(jobRepo.isOwner(jobId, companyId)).thenReturn(true);

        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));

        var out = service.updateStatus(UUID.randomUUID(), applicationId,
                new UpdateApplicationStatusCommand(Application.Status.IN_REVIEW));

        assertEquals(Application.Status.IN_REVIEW, out.status());
        verify(repo).save(argThat(a ->
                a.getUpdatedBy() != null && a.getUpdatedAt() != null
        ));
    }

    @Test
    void updateStatus_falla_siNoExiste() {
        when(repo.findById(applicationId)).thenReturn(Optional.empty());
        assertThrows(ApplicationNotFoundException.class,
                () -> service.updateStatus(UUID.randomUUID(), applicationId,
                        new UpdateApplicationStatusCommand(Application.Status.IN_REVIEW)));
    }

    @Test
    void updateStatus_falla_siCompanyProfileIncompleto() {
        var app = Application.builder().id(applicationId).jobId(jobId).status(Application.Status.APPLIED).build();
        when(repo.findById(applicationId)).thenReturn(Optional.of(app));
        when(ownershipPort.getForUser(any())).thenReturn(new CompanyOwnershipPort.CompanyOwnership(null, false, false));

        assertThrows(CompanyIncompleteException.class,
                () -> service.updateStatus(UUID.randomUUID(), applicationId,
                        new UpdateApplicationStatusCommand(Application.Status.IN_REVIEW)));
    }

    @Test
    void updateStatus_falla_siNoEsOwner() {
        var app = Application.builder().id(applicationId).jobId(jobId).status(Application.Status.APPLIED).build();
        when(repo.findById(applicationId)).thenReturn(Optional.of(app));
        var ownership = new CompanyOwnershipPort.CompanyOwnership(companyId, true, true);
        when(ownershipPort.getForUser(any())).thenReturn(ownership);
        when(jobRepo.isOwner(jobId, companyId)).thenReturn(false);

        assertThrows(ForbiddenJobAccessException.class,
                () -> service.updateStatus(UUID.randomUUID(), applicationId,
                        new UpdateApplicationStatusCommand(Application.Status.IN_REVIEW)));
    }

    @Test
    void myApplications_ok_devuelveLista() {
        when(applicantRepo.findByUserId(applicantUserId))
                .thenReturn(Optional.of(applicant(true, true, false)));
        when(repo.findByApplicant(eq(applicantId), anyInt(), anyInt()))
                .thenReturn(List.of(
                        Application.builder().id(UUID.randomUUID()).jobId(jobId).applicantId(applicantId)
                                .status(Application.Status.APPLIED).build()
                ));

        var out = service.myApplications(applicantUserId, 0, 20);
        assertEquals(1, out.size());
        assertEquals(Application.Status.APPLIED, out.getFirst().status());
    }

    @Test
    void listForJob_ok_validaOwnerYDevuelveLista() {
        var ownership = new CompanyOwnershipPort.CompanyOwnership(companyId, true, true);
        when(ownershipPort.getForUser(any())).thenReturn(ownership);
        when(jobRepo.findById(jobId)).thenReturn(Optional.of(job(JobOffer.Status.OPEN)));
        when(jobRepo.isOwner(jobId, companyId)).thenReturn(true);
        when(repo.findByJob(eq(jobId), anyInt(), anyInt()))
                .thenReturn(List.of(
                        Application.builder().id(UUID.randomUUID()).jobId(jobId).applicantId(applicantId)
                                .status(Application.Status.APPLIED).build()
                ));

        var out = service.listForJob(UUID.randomUUID(), jobId, 0, 20);
        assertEquals(1, out.size());
        assertEquals(jobId, out.getFirst().jobId());
    }

    @Test
    void getByIdAuthorizedForCompany_ok_validaOwner() {
        var app = Application.builder().id(applicationId).jobId(jobId).status(Application.Status.APPLIED).build();
        when(repo.findById(applicationId)).thenReturn(Optional.of(app));
        var ownership = new CompanyOwnershipPort.CompanyOwnership(companyId, true, true);
        when(ownershipPort.getForUser(any())).thenReturn(ownership);
        when(jobRepo.isOwner(jobId, companyId)).thenReturn(true);

        var out = service.getByIdAuthorizedForCompany(UUID.randomUUID(), applicationId);
        assertEquals(applicationId, out.id());
    }
}