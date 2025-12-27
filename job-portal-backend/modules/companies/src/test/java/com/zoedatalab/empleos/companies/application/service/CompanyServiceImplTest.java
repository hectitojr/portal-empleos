package com.zoedatalab.empleos.companies.application.service;

import com.zoedatalab.empleos.common.catalogs.DistrictLookupPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.companies.application.dto.UpsertMyCompanyCommand;
import com.zoedatalab.empleos.companies.application.ports.out.CompanyJobStatsPort;
import com.zoedatalab.empleos.companies.application.ports.out.CompanyRepositoryPort;
import com.zoedatalab.empleos.companies.domain.Company;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.any;
import static org.mockito.Mockito.anyString;
import static org.mockito.Mockito.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

class CompanyServiceImplTest {

    private CompanyRepositoryPort repo;
    private CompanyJobStatsPort jobStats;
    private ClockPort clock;
    private DistrictLookupPort districts;

    private CompanyServiceImpl service;

    @BeforeEach
    void setUp() {
        repo = mock(CompanyRepositoryPort.class);
        jobStats = mock(CompanyJobStatsPort.class);
        clock = mock(ClockPort.class);
        districts = mock(DistrictLookupPort.class);

        service = new CompanyServiceImpl(repo, jobStats, clock, districts);
    }

    @Test
    void upsertMyCompany_whenAllRequiredFieldsPresent_setsProfileCompleteTrue() {
        var userId = UUID.randomUUID();
        var districtId = UUID.randomUUID();
        var now = Instant.parse("2025-01-01T00:00:00Z");

        when(repo.findByUserId(userId)).thenReturn(Optional.empty());
        when(districts.existsById(districtId)).thenReturn(true);
        when(repo.existsByTaxIdIgnoreCaseAndUserIdNot(anyString(), eq(userId))).thenReturn(false);
        when(clock.now()).thenReturn(now);

        when(repo.save(any(Company.class))).thenAnswer(inv -> inv.getArgument(0));

        var cmd = new UpsertMyCompanyCommand(
                "Mi Empresa SAC",
                "  20.123.456.789  ",
                "  Contacto@Empresa.COM ",
                "999888777",
                districtId
        );

        var out = service.upsertMyCompany(userId, cmd);

        assertTrue(out.profileComplete());
        assertEquals("Mi Empresa SAC", out.legalName());
        assertEquals("20123456789", out.taxId());
        assertEquals("contacto@empresa.com", out.contactEmail()); // lower
        assertEquals(districtId, out.districtId());

        verify(repo).save(any(Company.class));
        verifyNoInteractions(jobStats);
    }

    @Test
    void upsertMyCompany_whenMissingRequiredFields_setsProfileCompleteFalse() {
        var userId = UUID.randomUUID();
        var now = Instant.parse("2025-01-01T00:00:00Z");

        when(repo.findByUserId(userId)).thenReturn(Optional.empty());
        when(clock.now()).thenReturn(now);
        when(repo.save(any(Company.class))).thenAnswer(inv -> inv.getArgument(0));

        var cmd = new UpsertMyCompanyCommand(
                "  ",
                null,
                null,
                null,
                null
        );

        var out = service.upsertMyCompany(userId, cmd);

        assertFalse(out.profileComplete());
        verify(repo).save(any(Company.class));
        verifyNoInteractions(jobStats);
    }
}
