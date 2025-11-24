package com.zoedatalab.empleos.persistence.jpa.repository;

import com.zoedatalab.empleos.persistence.jpa.TestDataSeeder;
import com.zoedatalab.empleos.persistence.jpa.entity.ApplicationEntity;
import com.zoedatalab.empleos.testsupport.SpringTestBase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.time.Instant;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

@Testcontainers
@DataJpaTest(properties = {
        "spring.jpa.hibernate.ddl-auto=validate",
        "spring.flyway.enabled=true",
        "spring.flyway.default-schema=job_portal",
        "spring.flyway.schemas=job_portal"
})
class JpaApplicationRepositoryTest extends SpringTestBase {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");
    @Autowired
    private JpaApplicationRepository repo;
    @Autowired
    private JdbcTemplate jdbc;
    private TestDataSeeder seeder;

    @DynamicPropertySource
    static void dbProps(DynamicPropertyRegistry reg) {
        reg.add("spring.datasource.url", () -> postgres.getJdbcUrl() + "&currentSchema=job_portal");
        reg.add("spring.datasource.username", postgres::getUsername);
        reg.add("spring.datasource.password", postgres::getPassword);
        reg.add("spring.datasource.driver-class-name", () -> "org.postgresql.Driver");

        reg.add("spring.jpa.properties.hibernate.default_schema", () -> "job_portal");
    }

    @BeforeEach
    void init() {
        this.seeder = new TestDataSeeder(jdbc);
    }

    @Test
    void save_and_find_paginado_por_appliedAt_desc() {
        UUID u1 = seeder.seedUser("a1@test.com");
        UUID applicantId = seeder.seedApplicant(u1);

        UUID u2 = seeder.seedCompanyUser("c1@test.com");
        UUID companyId = seeder.seedCompany(u2);
        UUID jobId1 = seeder.seedOpenJob(companyId);
        UUID jobId2 = seeder.seedOpenJob(companyId);

        var now = Instant.now();

        var newer = ApplicationEntity.builder()
                .id(UUID.randomUUID())
                .jobId(jobId2) // distinto job
                .applicantId(applicantId)
                .status(ApplicationEntity.Status.APPLIED)
                .appliedAt(now)
                .updatedAt(now)
                .build();

        var older = ApplicationEntity.builder()
                .id(UUID.randomUUID())
                .jobId(jobId1) // distinto job
                .applicantId(applicantId)
                .status(ApplicationEntity.Status.APPLIED)
                .appliedAt(now.minusSeconds(3600))
                .updatedAt(now.minusSeconds(3600))
                .build();

        repo.save(older);
        repo.save(newer);

        var page = repo.findByApplicantId(
                applicantId,
                PageRequest.of(0, 10, Sort.by(Sort.Direction.DESC, "appliedAt"))
        );

        assertThat(page.getTotalElements()).isEqualTo(2);
        assertThat(page.getContent().getFirst().getId()).isEqualTo(newer.getId());
    }

    @Test
    void uniqueConstraint_job_applicant() {
        UUID u1 = seeder.seedUser("a2@test.com");
        UUID applicantId = seeder.seedApplicant(u1);

        UUID u2 = seeder.seedCompanyUser("c2@test.com");
        UUID companyId = seeder.seedCompany(u2);
        UUID jobId = seeder.seedOpenJob(companyId);

        var one = ApplicationEntity.builder()
                .id(UUID.randomUUID())
                .jobId(jobId)
                .applicantId(applicantId)
                .status(ApplicationEntity.Status.APPLIED)
                .appliedAt(Instant.now())
                .updatedAt(Instant.now())
                .build();
        repo.save(one);

        var dup = ApplicationEntity.builder()
                .id(UUID.randomUUID())
                .jobId(jobId)
                .applicantId(applicantId)
                .status(ApplicationEntity.Status.APPLIED)
                .appliedAt(Instant.now())
                .updatedAt(Instant.now())
                .build();

        assertThrows(DataIntegrityViolationException.class, () -> repo.saveAndFlush(dup));
    }
}
