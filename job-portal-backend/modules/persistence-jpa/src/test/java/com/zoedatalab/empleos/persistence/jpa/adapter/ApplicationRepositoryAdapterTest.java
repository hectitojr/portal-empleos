package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.applications.domain.Application;
import com.zoedatalab.empleos.persistence.jpa.TestDataSeeder;
import com.zoedatalab.empleos.persistence.jpa.mapper.ApplicationJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.repository.JpaApplicationRepository;
import com.zoedatalab.empleos.testsupport.SpringTestBase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@Testcontainers
@DataJpaTest(properties = {
        "spring.jpa.hibernate.ddl-auto=validate",
        "spring.flyway.enabled=true",
        "spring.flyway.default-schema=job_portal",
        "spring.flyway.schemas=job_portal"
})
@Import({
        ApplicationRepositoryAdapter.class,
        ApplicationJpaMapper.class
})
class ApplicationRepositoryAdapterTest extends SpringTestBase {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    @DynamicPropertySource
    static void dbProps(DynamicPropertyRegistry reg) {
        reg.add("spring.datasource.url", () -> postgres.getJdbcUrl() + "&currentSchema=job_portal");
        reg.add("spring.datasource.username", postgres::getUsername);
        reg.add("spring.datasource.password", postgres::getPassword);
        reg.add("spring.datasource.driver-class-name", () -> "org.postgresql.Driver");

        reg.add("spring.jpa.properties.hibernate.default_schema", () -> "job_portal");
    }


    @Autowired private ApplicationRepositoryAdapter adapter;
    @Autowired private JpaApplicationRepository jpaRepo;
    @Autowired private JdbcTemplate jdbc;

    private UUID applicant1;
    private UUID applicant2;
    private UUID job1;
    private UUID job2;

    @BeforeEach
    void setup() {
        TestDataSeeder seeder = new TestDataSeeder(jdbc);

        // Usuarios y entidades base
        UUID uA1 = seeder.seedUser("app1@test.com");
        applicant1 = seeder.seedApplicant(uA1);

        UUID uA2 = seeder.seedUser("app2@test.com");
        applicant2 = seeder.seedApplicant(uA2);

        UUID uCo = seeder.seedCompanyUser("co@test.com");
        UUID companyId = seeder.seedCompany(uCo);

        job1 = seeder.seedOpenJob(companyId);
        job2 = seeder.seedOpenJob(companyId);
    }

    @Test
    void save_and_find_ok() {
        var now = Instant.now();
        var a = Application.builder()
                .jobId(job1)
                .applicantId(applicant1)
                .status(Application.Status.APPLIED)
                .appliedAt(now)
                .updatedAt(now)
                .build();

        Application saved = adapter.save(a);
        assertNotNull(saved.getId());

        var byId = adapter.findById(saved.getId());
        assertTrue(byId.isPresent());
        assertEquals(saved.getId(), byId.get().getId());
    }

    @Test
    void finders_paginan_por_appliedAt_desc() {
        var olderForApplicant1 = Application.builder()
                .jobId(job1)
                .applicantId(applicant1)
                .status(Application.Status.APPLIED)
                .appliedAt(Instant.now().minusSeconds(3600))
                .updatedAt(Instant.now().minusSeconds(3600))
                .build();

        var newerForApplicant1 = Application.builder()
                .jobId(job2)
                .applicantId(applicant1)
                .status(Application.Status.APPLIED)
                .appliedAt(Instant.now())
                .updatedAt(Instant.now())
                .build();

        adapter.save(olderForApplicant1);
        adapter.save(newerForApplicant1);
        
        var midForJob1_applicant2 = Application.builder()
                .jobId(job1)           // mismo job1
                .applicantId(applicant2) // applicant distinto
                .status(Application.Status.APPLIED)
                .appliedAt(Instant.now().plusSeconds(10))
                .updatedAt(Instant.now().plusSeconds(10))
                .build();

        adapter.save(midForJob1_applicant2);

        // --- Assertions ---

        // byApplicant: debe devolver 2 y el más reciente primero
        List<Application> byApplicant = adapter.findByApplicant(applicant1, 0, 10);
        assertEquals(2, byApplicant.size());
        assertEquals(newerForApplicant1.getAppliedAt(), byApplicant.getFirst().getAppliedAt());

        // byJob(job1): debe devolver 2 (applicant1 + applicant2) y el más reciente primero
        List<Application> byJob = adapter.findByJob(job1, 0, 10);
        assertEquals(2, byJob.size());
        assertThat(byJob.getFirst().getAppliedAt())
                .isAfterOrEqualTo(byJob.get(1).getAppliedAt());
        assertEquals(midForJob1_applicant2.getAppliedAt(), byJob.getFirst().getAppliedAt());
    }

    @Test
    void existsByJobAndApplicant_true_false() {
        var now = Instant.now();
        var a = Application.builder()
                .jobId(job1)
                .applicantId(applicant1)
                .status(Application.Status.APPLIED)
                .appliedAt(now)
                .updatedAt(now)
                .build();

        var saved = adapter.save(a);

        assertTrue(adapter.existsByJobAndApplicant(job1, applicant1));
        assertFalse(adapter.existsByJobAndApplicant(job1, UUID.randomUUID()));
        assertFalse(adapter.existsByJobAndApplicant(UUID.randomUUID(), saved.getApplicantId()));
    }
}
