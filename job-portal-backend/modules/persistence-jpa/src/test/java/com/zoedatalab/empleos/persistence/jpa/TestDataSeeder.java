package com.zoedatalab.empleos.persistence.jpa;

import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.UUID;

public class TestDataSeeder {

    private final JdbcTemplate jdbc;

    public TestDataSeeder(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public UUID seedUser(String email) {
        UUID id = UUID.randomUUID();
        jdbc.update("""
                insert into job_portal.users(id, email, password_hash, role, active, suspended, created_by, updated_by)
                values (?, ?, 'x', 'APPLICANT', true, false, null, null)
                """, id, email);
        return id;
    }

    public UUID seedCompanyUser(String email) {
        UUID id = UUID.randomUUID();
        jdbc.update("""
                insert into job_portal.users(id, email, password_hash, role, active, suspended, created_by, updated_by)
                values (?, ?, 'x', 'COMPANY', true, false, null, null)
                """, id, email);
        return id;
    }

    public UUID seedApplicant(UUID userId) {
        UUID id = UUID.randomUUID();
        jdbc.update("""
                insert into job_portal.applicants(id, user_id, full_name, contact_email, profile_complete, active, suspended, created_by, updated_by)
                values (?, ?, 'John Doe', 'john@example.com', true, true, false, null, null)
                """, id, userId);
        return id;
    }

    public UUID seedCompany(UUID userId) {
        UUID id = UUID.randomUUID();
        jdbc.update("""
                insert into job_portal.companies(id, user_id, legal_name, profile_complete, active, suspended, created_by, updated_by)
                values (?, ?, 'ACME INC', true, true, false, null, null)
                """, id, userId);
        return id;
    }

    /**
     * Inserta un job OPEN con published_at = now(UTC).
     */
    public UUID seedOpenJob(UUID companyId) {
        return seedOpenJob(companyId, Instant.now());
    }

    /**
     * Inserta un job OPEN con un published_at controlado (útil si algún test necesita un tiempo específico).
     */
    public UUID seedOpenJob(UUID companyId, Instant publishedAt) {
        UUID id = UUID.randomUUID();
        String sql = """
                insert into job_portal.job_offers(id, company_id, title, description, status, published_at, suspended)
                values (?, ?, 'Dev', 'Role', 'OPEN', ?, false)
                """;

        jdbc.update(con -> {
            var ps = con.prepareStatement(sql);
            ps.setObject(1, id);                         // UUID OK
            ps.setObject(2, companyId);                  // UUID OK
            ps.setObject(3, OffsetDateTime.ofInstant(publishedAt, ZoneOffset.UTC));
            return ps;
        });

        return id;
    }

    @SuppressWarnings("unused")
    private static Timestamp ts(Instant i) {
        return Timestamp.from(i);
    }
}
