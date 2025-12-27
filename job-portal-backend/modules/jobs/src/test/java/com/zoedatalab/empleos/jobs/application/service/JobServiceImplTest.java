package com.zoedatalab.empleos.jobs.application.service;

import com.zoedatalab.empleos.common.catalogs.exception.AreaNotFoundException;
import com.zoedatalab.empleos.common.catalogs.exception.DistrictNotFoundException;
import com.zoedatalab.empleos.common.catalogs.exception.EmploymentTypeNotFoundException;
import com.zoedatalab.empleos.common.catalogs.exception.SectorNotFoundException;
import com.zoedatalab.empleos.common.catalogs.exception.WorkModeNotFoundException;
import com.zoedatalab.empleos.jobs.application.dto.CreateJobCommand;
import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.UpdateJobCommand;
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
import java.util.Set;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.isNull;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
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

    @Mock
    JobCatalogValidationPort catalogValidation;

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

    private void stubCatalogsAllExist() {
        when(catalogValidation.areaExists(any())).thenReturn(true);
        when(catalogValidation.sectorExists(any())).thenReturn(true);
        when(catalogValidation.districtExists(any())).thenReturn(true);
        when(catalogValidation.employmentTypeExists(any())).thenReturn(true);
        when(catalogValidation.workModeExists(any())).thenReturn(true);
    }

    private CompanyOwnershipPort.CompanyOwnership own(UUID companyId, boolean active, boolean profileComplete, boolean suspended) {
        return new CompanyOwnershipPort.CompanyOwnership(companyId, active, profileComplete, suspended);
    }

    @Test
    void create_ok_whenCompanyActiveCompleteAndNotSuspended() {
        stubCatalogsAllExist();

        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

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
                .title("Backend Java")
                .description("Descripción suficientemente larga para pasar validación.")
                .areaId(UUID.randomUUID())
                .sectorId(UUID.randomUUID())
                .districtId(UUID.randomUUID())
                .employmentTypeId(UUID.randomUUID())
                .workModeId(UUID.randomUUID())
                .disabilityFriendly(false)
                .build();

        JobDetailView out = service.create(userId, cmd);

        assertNotNull(out.id());
        assertEquals("Backend Sr.", out.title());
        assertEquals("OPEN", out.status());
        assertTrue(out.disabilityFriendly());
        assertEquals(companyId, out.companyId());

        ArgumentCaptor<JobOffer> cap = ArgumentCaptor.forClass(JobOffer.class);
        verify(repo).save(cap.capture());
        JobOffer saved = cap.getValue();

        assertEquals(Status.OPEN, saved.getStatus());
        assertNotNull(saved.getPublishedAt());
        assertEquals(companyId, saved.getCompanyId());

        verify(repo, times(1)).flush();
        verify(jobLocationQueries).findDetail(saved.getId());

        verify(catalogValidation).areaExists(eq(cmd.areaId()));
        verify(catalogValidation).sectorExists(eq(cmd.sectorId()));
        verify(catalogValidation).districtExists(eq(cmd.districtId()));
        verify(catalogValidation).employmentTypeExists(eq(cmd.employmentTypeId()));
        verify(catalogValidation).workModeExists(eq(cmd.workModeId()));
    }

    @Test
    void create_whenCompanyIncomplete_throwsCompanyIncompleteException() {
        var userId = UUID.randomUUID();

        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(null, false, false, false));

        var cmd = CreateJobCommand.builder()
                .title("Backend Java")
                .description("Descripción suficientemente larga para pasar validación.")
                .disabilityFriendly(false)
                .build();

        assertThrows(CompanyIncompleteException.class, () -> service.create(userId, cmd));

        verify(repo, never()).save(any(JobOffer.class));
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
        verifyNoInteractions(catalogValidation);
    }

    @Test
    void create_whenOk_persistsJobAndReturnsDetail() {
        stubCatalogsAllExist();

        var userId = UUID.randomUUID();
        var companyId = UUID.randomUUID();
        var jobId = UUID.randomUUID();

        when(ownership.getForUser(userId))
                .thenReturn(new CompanyOwnershipPort.CompanyOwnership(companyId, true, true, false));

        when(repo.save(any(JobOffer.class))).thenAnswer(inv -> inv.getArgument(0));

        when(jobLocationQueries.findDetail(any(UUID.class))).thenAnswer(inv -> {
            UUID id = inv.getArgument(0, UUID.class);
            return Optional.of(new JobLocationQueryPort.JobDetailRow(
                    id,
                    companyId,
                    "Backend Java",
                    "Descripción suficientemente larga para pasar validación.",
                    null, null, null,
                    "Lima", "Lima", "San Isidro",
                    false,
                    null, null,
                    null,
                    "OPEN",
                    java.time.Instant.parse("2025-01-01T00:00:00Z"),
                    false
            ));
        });

        var cmd = CreateJobCommand.builder()
                .title("Backend Java")
                .description("Descripción suficientemente larga para pasar validación.")
                .areaId(UUID.randomUUID())
                .sectorId(UUID.randomUUID())
                .districtId(UUID.randomUUID())
                .employmentTypeId(UUID.randomUUID())
                .workModeId(UUID.randomUUID())
                .disabilityFriendly(false)
                .build();

        var out = service.create(userId, cmd);

        assertNotNull(out);
        assertEquals(companyId, out.companyId());
        assertEquals("Backend Java", out.title());
        assertEquals("OPEN", out.status());

        verify(repo).save(any(JobOffer.class));
        verify(repo).flush();
        verify(jobLocationQueries).findDetail(any(UUID.class));
    }

    @Test
    void create_throws_whenCompanyIncompleteInactiveOrSuspended() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, false, false));
        assertThrows(CompanyIncompleteException.class, () -> service.create(userId, minimalCreate()));

        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, false, true, false));
        assertThrows(CompanyIncompleteException.class, () -> service.create(userId, minimalCreate()));

        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, true)); // suspended
        assertThrows(CompanyIncompleteException.class, () -> service.create(userId, minimalCreate()));

        when(ownership.getForUser(userId))
                .thenReturn(own(null, false, false, false));
        assertThrows(CompanyIncompleteException.class, () -> service.create(userId, minimalCreate()));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());

        verifyNoInteractions(catalogValidation);
    }

    @Test
    void create_throws_whenAreaNotFound() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        UUID areaId = UUID.randomUUID();
        when(catalogValidation.areaExists(areaId)).thenReturn(false);

        var cmd = CreateJobCommand.builder()
                .title("t").description("d")
                .areaId(areaId)
                .build();

        assertThrows(AreaNotFoundException.class, () -> service.create(userId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    @Test
    void create_throws_whenSectorNotFound() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        UUID sectorId = UUID.randomUUID();
        when(catalogValidation.sectorExists(sectorId)).thenReturn(false);

        var cmd = CreateJobCommand.builder()
                .title("t").description("d")
                .sectorId(sectorId)
                .build();

        assertThrows(SectorNotFoundException.class, () -> service.create(userId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    @Test
    void create_throws_whenDistrictNotFound() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        UUID districtId = UUID.randomUUID();
        when(catalogValidation.districtExists(districtId)).thenReturn(false);

        var cmd = CreateJobCommand.builder()
                .title("t").description("d")
                .districtId(districtId)
                .build();

        assertThrows(DistrictNotFoundException.class, () -> service.create(userId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    @Test
    void create_throws_whenEmploymentTypeNotFound() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        UUID employmentTypeId = UUID.randomUUID();
        when(catalogValidation.employmentTypeExists(employmentTypeId)).thenReturn(false);

        var cmd = CreateJobCommand.builder()
                .title("t").description("d")
                .employmentTypeId(employmentTypeId)
                .build();

        assertThrows(EmploymentTypeNotFoundException.class, () -> service.create(userId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    @Test
    void create_throws_whenWorkModeNotFound() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        UUID workModeId = UUID.randomUUID();
        when(catalogValidation.workModeExists(workModeId)).thenReturn(false);

        var cmd = CreateJobCommand.builder()
                .title("t").description("d")
                .workModeId(workModeId)
                .build();

        assertThrows(WorkModeNotFoundException.class, () -> service.create(userId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());
    }

    // ---------- UPDATE ----------

    @Test
    void update_ok_whenCompanyAllowedOwnerAndOpen() {
        stubCatalogsAllExist();

        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        var existing = sampleJob(jobId, companyId, Status.OPEN);
        when(repo.findById(jobId)).thenReturn(Optional.of(existing));
        when(repo.isOwner(jobId, companyId)).thenReturn(true);
        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));

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
                .employmentTypeId(UUID.randomUUID())
                .workModeId(UUID.randomUUID())
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

        verify(catalogValidation).areaExists(eq(cmd.areaId()));
        verify(catalogValidation).sectorExists(eq(cmd.sectorId()));
        verify(catalogValidation).districtExists(eq(cmd.districtId()));
        verify(catalogValidation).employmentTypeExists(eq(cmd.employmentTypeId()));
        verify(catalogValidation).workModeExists(eq(cmd.workModeId()));
    }

    @Test
    void update_throws_whenCompanySuspendedOrNotAllowed() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, true)); // suspended

        // Debe fallar antes de tocar repo/catálogos
        assertThrows(CompanyIncompleteException.class, () -> service.update(userId, jobId, UpdateJobCommand.builder().build()));

        verifyNoInteractions(repo);
        verifyNoInteractions(catalogValidation);
        verifyNoInteractions(jobLocationQueries);
    }

    @Test
    void update_throws_whenNotOwner() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        when(repo.findById(jobId))
                .thenReturn(Optional.of(sampleJob(jobId, UUID.randomUUID(), Status.OPEN)));

        when(repo.isOwner(eq(jobId), eq(companyId))).thenReturn(false);

        var cmd = UpdateJobCommand.builder().title("x").description("y").build();
        assertThrows(ForbiddenJobAccessException.class, () -> service.update(userId, jobId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());

        verifyNoInteractions(catalogValidation);
    }

    @Test
    void update_throws_whenClosed() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        when(repo.findById(jobId))
                .thenReturn(Optional.of(sampleJob(jobId, companyId, Status.CLOSED)));

        when(repo.isOwner(jobId, companyId)).thenReturn(true);

        var cmd = UpdateJobCommand.builder().title("x").description("y").build();
        assertThrows(JobClosedException.class, () -> service.update(userId, jobId, cmd));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());

        verifyNoInteractions(catalogValidation);
    }

    // ---------- CLOSE ----------

    @Test
    void close_ok_whenCompanyAllowedAndOwner() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

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

        verifyNoInteractions(catalogValidation);
    }

    @Test
    void close_throws_whenCompanySuspendedOrNotAllowed() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, true)); // suspended

        assertThrows(CompanyIncompleteException.class, () -> service.close(userId, jobId));

        verifyNoInteractions(repo);
        verifyNoInteractions(catalogValidation);
        verifyNoInteractions(jobLocationQueries);
    }

    @Test
    void close_idempotent_whenAlreadyClosed() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

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

        verifyNoInteractions(catalogValidation);
    }

    @Test
    void close_throws_whenNotOwner() {
        when(ownership.getForUser(userId))
                .thenReturn(own(companyId, true, true, false));

        when(repo.findById(jobId))
                .thenReturn(Optional.of(sampleJob(jobId, UUID.randomUUID(), Status.OPEN)));

        when(repo.isOwner(jobId, companyId)).thenReturn(false);

        assertThrows(ForbiddenJobAccessException.class, () -> service.close(userId, jobId));

        verify(repo, never()).save(any());
        verify(repo, never()).flush();
        verify(jobLocationQueries, never()).findDetail(any());

        verifyNoInteractions(catalogValidation);
    }

    // ---------- GET ----------

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

        verifyNoInteractions(catalogValidation);
    }

    @Test
    void getById_throws_whenNotFound() {
        when(jobLocationQueries.findDetail(jobId)).thenReturn(Optional.empty());
        assertThrows(JobNotFoundException.class, () -> service.getById(jobId));

        verifyNoInteractions(catalogValidation);
    }

    // ---------- SEARCH (geo precedence) ----------

    @Test
    void search_prefersDistrict_overProvinceAndDepartment() {
        UUID depId = UUID.randomUUID();
        UUID provId = UUID.randomUUID();
        UUID distId = UUID.randomUUID();

        when(jobLocationQueries.searchSummaries(
                any(), any(),
                isNull(), isNull(), eq(distId),
                any(), any(),
                eq(0), eq(10)
        )).thenReturn(List.of(sampleSummaryRow(UUID.randomUUID(), companyId, "OPEN", false)));

        when(ownership.publicName(companyId)).thenReturn("ACME");

        service.search(null, null, depId, provId, distId, null, null,
                0, 10);

        verify(jobLocationQueries).searchSummaries(
                isNull(), isNull(),
                isNull(), isNull(), eq(distId),
                isNull(), isNull(),
                eq(0), eq(10)
        );
    }

    @Test
    void search_prefersProvince_overDepartment_whenNoDistrict() {
        UUID depId = UUID.randomUUID();
        UUID provId = UUID.randomUUID();

        when(jobLocationQueries.searchSummaries(
                any(), any(),
                isNull(), eq(provId), isNull(),
                any(), any(),
                eq(0), eq(10)
        )).thenReturn(List.of(sampleSummaryRow(UUID.randomUUID(), companyId, "OPEN", false)));

        when(ownership.publicName(companyId)).thenReturn("ACME");

        service.search(null, null, depId, provId, null, null, null,
                0, 10);

        verify(jobLocationQueries).searchSummaries(
                isNull(), isNull(),
                isNull(), eq(provId), isNull(),
                isNull(), isNull(),
                eq(0), eq(10)
        );
    }

    @Test
    void search_usesDepartment_whenOnlyDepartmentProvided() {
        UUID depId = UUID.randomUUID();

        when(jobLocationQueries.searchSummaries(
                any(), any(),
                eq(depId), isNull(), isNull(),
                any(), any(),
                eq(0), eq(10)
        )).thenReturn(List.of(sampleSummaryRow(UUID.randomUUID(), companyId, "OPEN", false)));

        when(ownership.publicName(companyId)).thenReturn("ACME");

        service.search(null, null, depId, null, null, null, null, 0, 10);

        verify(jobLocationQueries).searchSummaries(
                isNull(), isNull(),
                eq(depId), isNull(), isNull(),
                isNull(), isNull(),
                eq(0), eq(10)
        );
    }

    @Test
    void searchForApplicant_prefersDistrict_overProvinceAndDepartment() {
        UUID depId = UUID.randomUUID();
        UUID provId = UUID.randomUUID();
        UUID distId = UUID.randomUUID();

        var rowId = UUID.randomUUID();

        when(jobLocationQueries.searchSummaries(
                any(), any(),
                isNull(), isNull(), eq(distId),
                any(), any(),
                eq(0), eq(10)
        )).thenReturn(List.of(sampleSummaryRow(rowId, companyId, "OPEN", false)));

        when(applicantLookup.getApplicantIdByUserId(userId)).thenReturn(UUID.randomUUID());
        when(applicantState.findAppliedJobIds(any(), anyList())).thenReturn(Set.of());
        when(applicantState.findViewedJobIds(any(), anyList())).thenReturn(Set.of());
        when(ownership.publicName(companyId)).thenReturn("ACME");

        service.searchForApplicant(userId, null, null, depId, provId, distId, null, null, 0, 10);

        verify(jobLocationQueries).searchSummaries(
                isNull(), isNull(),
                isNull(), isNull(), eq(distId),
                isNull(), isNull(),
                eq(0), eq(10)
        );
    }

    // ---------- Helpers ----------

    private CreateJobCommand minimalCreate() {
        return CreateJobCommand.builder()
                .title("t").description("d")
                .areaId(null).sectorId(null).districtId(null)
                .employmentTypeId(null).workModeId(null)
                .disabilityFriendly(false)
                .build();
    }

    private JobOffer sampleJob(UUID id, UUID companyId, Status status) {
        JobOffer job = JobOffer.create(
                id,
                companyId,
                "Backend Sr.",
                "desc",
                UUID.randomUUID(),
                UUID.randomUUID(),
                UUID.randomUUID(),
                true,
                UUID.randomUUID(),
                UUID.randomUUID(),
                "S/ 6000",
                Instant.now()
        );

        if (status == Status.CLOSED) {
            job.close();
        }

        return job;
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
