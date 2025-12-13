package com.zoedatalab.empleos.jobs.application.service;

import com.zoedatalab.empleos.jobs.application.dto.CreateJobCommand;
import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.JobSummaryView;
import com.zoedatalab.empleos.jobs.application.dto.UpdateJobCommand;
import com.zoedatalab.empleos.jobs.application.ports.out.ApplicantLookupPort;
import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobApplicantStatePort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobLocationQueryPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.jobs.domain.JobOffer.Status;
import com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException;
import com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException;
import com.zoedatalab.empleos.jobs.domain.exception.JobClosedException;
import com.zoedatalab.empleos.jobs.domain.exception.JobNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class JobServiceImplTest {

    @Mock
    JobRepositoryPort repo;

    @Mock
    CompanyOwnershipPort ownership;

    @Mock
    JobLocationQueryPort jobLocationQueries;

    @Mock
    ApplicantLookupPort applicantLookup;

    @Mock
    JobApplicantStatePort applicantState;

    @InjectMocks
    JobServiceImpl service;

    UUID userId;
    UUID companyId;
    UUID jobId;

    @BeforeEach
    void setUp() {
        userId = UUID.randomUUID();
        companyId = UUID.randomUUID();
        jobId = UUID.randomUUID();
    }

    // ---------- CREATE ----------

    @Test
    void create_ok_whenCompanyActiveAndComplete() {
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, true));

        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));
        
        when(jobLocationQueries.findDetail(any(UUID.class)))
                .thenAnswer(inv -> Optional.of(sampleDetailRow(
                        inv.getArgument(0, UUID.class),
                        companyId,
                        "Backend Sr.",
                        "Spring Boot, DDD",
                        "OPEN",
                        false,
                        true
                )));

        var cmd = CreateJobCommand.builder()
                .title("Backend Sr.")
                .description("Spring Boot, DDD")
                .areaId(UUID.randomUUID())
                .sectorId(UUID.randomUUID())
                .districtId(UUID.randomUUID())
                .disabilityFriendly(true)
                .build();

        JobDetailView out = service.create(userId, cmd);

        assertNotNull(out.id());
        assertEquals("Backend Sr.", out.title());
        assertEquals("OPEN", out.status());
        assertTrue(out.disabilityFriendly());
        assertEquals(companyId, out.companyId());

        // Verifica que lo haya guardado con status/publishedAt correctamente
        ArgumentCaptor<JobOffer> cap = ArgumentCaptor.forClass(JobOffer.class);
        verify(repo).save(cap.capture());
        JobOffer saved = cap.getValue();
        assertEquals(Status.OPEN, saved.getStatus());
        assertNotNull(saved.getPublishedAt());
        assertEquals(companyId, saved.getCompanyId());

        // 🔥 CLAVE del fix: debe forzar flush antes de leer el read-model por JDBC
        verify(repo, times(1)).flush();

        // Verifica que el read-model se consultó con el ID realmente guardado
        verify(jobLocationQueries).findDetail(saved.getId());
    }

    @Test
    void create_throws_whenCompanyIncompleteOrInactive() {
        // Incompleta
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, false));
        assertThrows(CompanyIncompleteException.class, () -> service.create(userId, minimalCreate()));

        // Inactiva
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, false, true));
        assertThrows(CompanyIncompleteException.class, () -> service.create(userId, minimalCreate()));

        // Sin company (no provisionada aún)
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(null, false, false));
        assertThrows(CompanyIncompleteException.class, () -> service.create(userId, minimalCreate()));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    // ---------- UPDATE ----------

    @Test
    void update_ok_whenOwnerAndOpen() {
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, true));

        var existing = sampleJob(jobId, companyId, Status.OPEN);
        when(repo.findById(jobId)).thenReturn(Optional.of(existing));
        when(repo.isOwner(jobId, companyId)).thenReturn(true);
        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));

        // el retorno se construye desde el read-model, por eso debe reflejar el estado "post-update"
        when(jobLocationQueries.findDetail(jobId))
                .thenReturn(Optional.of(sampleDetailRow(
                        jobId,
                        companyId,
                        "Backend Lead",
                        "DDD + Hexagonal",
                        "OPEN",
                        false,
                        false
                )));

        var cmd = UpdateJobCommand.builder()
                .title("Backend Lead")
                .description("DDD + Hexagonal")
                .areaId(UUID.randomUUID())
                .sectorId(UUID.randomUUID())
                .districtId(UUID.randomUUID())
                .disabilityFriendly(false)
                .build();

        JobDetailView out = service.update(userId, jobId, cmd);

        assertEquals("Backend Lead", out.title());
        assertEquals("DDD + Hexagonal", out.description());
        assertEquals("OPEN", out.status());
        assertFalse(out.disabilityFriendly());

        verify(repo).save(any(JobOffer.class));
        verify(repo, times(1)).flush();
        verify(jobLocationQueries).findDetail(jobId);
    }

    @Test
    void update_throws_whenNotOwner() {
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, true));

        when(repo.findById(jobId))
                .thenReturn(Optional.of(sampleJob(jobId, UUID.randomUUID(), Status.OPEN))); // otro dueño

        when(repo.isOwner(eq(jobId), eq(companyId))).thenReturn(false);

        var cmd = UpdateJobCommand.builder().title("x").description("y").build();
        assertThrows(ForbiddenJobAccessException.class, () -> service.update(userId, jobId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    @Test
    void update_throws_whenClosed() {
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, true));

        when(repo.findById(jobId))
                .thenReturn(Optional.of(sampleJob(jobId, companyId, Status.CLOSED)));

        when(repo.isOwner(jobId, companyId)).thenReturn(true);

        var cmd = UpdateJobCommand.builder().title("x").description("y").build();
        assertThrows(JobClosedException.class, () -> service.update(userId, jobId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    // ---------- CLOSE ----------

    @Test
    void close_ok_whenOwner() {
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, true));

        when(repo.findById(jobId))
                .thenReturn(Optional.of(sampleJob(jobId, companyId, Status.OPEN)));

        when(repo.isOwner(jobId, companyId)).thenReturn(true);
        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));

        when(jobLocationQueries.findDetail(jobId))
                .thenReturn(Optional.of(sampleDetailRow(
                        jobId,
                        companyId,
                        "Backend Sr.",
                        "desc",
                        "CLOSED",
                        false,
                        true
                )));

        JobDetailView out = service.close(userId, jobId);
        assertEquals("CLOSED", out.status());

        verify(repo).save(any(JobOffer.class));
        verify(repo, times(1)).flush();
        verify(jobLocationQueries).findDetail(jobId);
    }

    @Test
    void close_idempotent_whenAlreadyClosed() {
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, true));

        when(repo.findById(jobId))
                .thenReturn(Optional.of(sampleJob(jobId, companyId, Status.CLOSED)));

        when(repo.isOwner(jobId, companyId)).thenReturn(true);
        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));

        when(jobLocationQueries.findDetail(jobId))
                .thenReturn(Optional.of(sampleDetailRow(
                        jobId,
                        companyId,
                        "Backend Sr.",
                        "desc",
                        "CLOSED",
                        false,
                        true
                )));

        JobDetailView out = service.close(userId, jobId);
        assertEquals("CLOSED", out.status());

        verify(repo).save(any(JobOffer.class));
        verify(repo, times(1)).flush();
        verify(jobLocationQueries).findDetail(jobId);
    }

    @Test
    void close_throws_whenNotOwner() {
        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, true));

        when(repo.findById(jobId))
                .thenReturn(Optional.of(sampleJob(jobId, UUID.randomUUID(), Status.OPEN)));

        when(repo.isOwner(jobId, companyId)).thenReturn(false);

        assertThrows(ForbiddenJobAccessException.class, () -> service.close(userId, jobId));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    // ---------- GET / SEARCH ----------

    @Test
    void getById_ok() {
        when(jobLocationQueries.findDetail(jobId))
                .thenReturn(Optional.of(sampleDetailRow(
                        jobId,
                        companyId,
                        "Backend Sr.",
                        "desc",
                        "OPEN",
                        false,
                        true
                )));

        JobDetailView out = service.getById(jobId);
        assertEquals(jobId, out.id());
        assertEquals("OPEN", out.status());
    }

    @Test
    void getById_throws_whenNotFound() {
        when(jobLocationQueries.findDetail(jobId)).thenReturn(Optional.empty());
        assertThrows(JobNotFoundException.class, () -> service.getById(jobId));
    }

    @Test
    void search_mapsCompanyPublicName() {
        when(jobLocationQueries.searchSummaries(any(), any(), any(), any(), any(), eq(0), eq(10)))
                .thenReturn(List.of(
                        sampleSummaryRow(UUID.randomUUID(), companyId, "OPEN", false),
                        sampleSummaryRow(UUID.randomUUID(), companyId, "OPEN", false)
                ));

        when(ownership.publicName(companyId)).thenReturn("ACME Corp.");

        List<JobSummaryView> list = service.search(null, null, null, null, null, 0, 10);

        assertEquals(2, list.size());
        assertEquals("ACME Corp.", list.get(0).companyPublicName());
        assertEquals("ACME Corp.", list.get(1).companyPublicName());
    }

    // ---------- Helpers ----------

    private CreateJobCommand minimalCreate() {
        return CreateJobCommand.builder()
                .title("t").description("d")
                .areaId(null).sectorId(null).districtId(null)
                .disabilityFriendly(false)
                .build();
    }

    private JobOffer sampleJob(UUID id, UUID companyId, Status status) {
        return JobOffer.builder()
                .id(id)
                .companyId(companyId)
                .title("Backend Sr.")
                .description("desc")
                .areaId(UUID.randomUUID())
                .sectorId(UUID.randomUUID())
                .districtId(UUID.randomUUID())
                .disabilityFriendly(true)
                .status(status)
                .publishedAt(Instant.now())
                .suspended(false)
                .build();
    }

    private JobLocationQueryPort.JobDetailRow sampleDetailRow(
            UUID id,
            UUID companyId,
            String title,
            String description,
            String status,
            boolean suspended,
            boolean disabilityFriendly
    ) {
        return new JobLocationQueryPort.JobDetailRow(
                id,
                companyId,
                title,
                description,
                UUID.randomUUID(), // areaId
                UUID.randomUUID(), // sectorId
                UUID.randomUUID(), // districtId
                "Lima",            // departmentName
                "Lima",            // provinceName
                "Miraflores",      // districtName
                disabilityFriendly,
                UUID.randomUUID(), // employmentTypeId
                UUID.randomUUID(), // workModeId
                "S/ 6000",         // salaryText
                status,
                Instant.now(),
                suspended
        );
    }

    private JobLocationQueryPort.JobSummaryRow sampleSummaryRow(
            UUID id, UUID companyId, String status, boolean suspended
    ) {
        return new JobLocationQueryPort.JobSummaryRow(
                id,
                "Backend Sr.",
                companyId,
                UUID.randomUUID(), // sectorId
                UUID.randomUUID(), // districtId
                "Lima",
                "Lima",
                "Miraflores",
                true,
                UUID.randomUUID(), // employmentTypeId
                UUID.randomUUID(), // workModeId
                "S/ 6000",
                status,
                Instant.now(),
                suspended
        );
    }
}
