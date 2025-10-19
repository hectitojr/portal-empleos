package com.zoedatalab.empleos.persistence.jpa.repository;

import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.persistence.jpa.entity.RefreshTokenEntity;
import com.zoedatalab.empleos.persistence.jpa.entity.UserEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.time.Instant;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@Testcontainers
@DataJpaTest(properties = {
        "spring.jpa.hibernate.ddl-auto=none",
        "spring.flyway.enabled=true"
})
class JpaRefreshTokenRepositoryTest {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:15-alpine");

    @DynamicPropertySource
    static void dbProps(DynamicPropertyRegistry reg) {
        reg.add("spring.datasource.url", postgres::getJdbcUrl);
        reg.add("spring.datasource.username", postgres::getUsername);
        reg.add("spring.datasource.password", postgres::getPassword);
        reg.add("spring.datasource.driver-class-name", () -> "org.postgresql.Driver");
    }

    @Autowired
    private JpaRefreshTokenRepository repo;

    @Autowired
    private JpaUserRepository users;

    // ---------- helpers ----------

    /** Inserta un usuario válido vía JPA para satisfacer la FK de refresh_tokens.user_id */
    private UUID seedUser() {
        var u = new UserEntity();
        u.setId(UUID.randomUUID());
        u.setEmail("test+" + u.getId() + "@example.com");
        u.setPasswordHash("{noop}pw"); // en tests basta un hash dummy
        // Si tu UserEntity usa String para role:
        u.setRole(Role.APPLICANT);
        // Si en tu mapeo fuera Enum, reemplaza por: u.setRole(Role.APPLICANT);
        u.setActive(true);
        u.setSuspended(false);
        // created_at / updated_at tienen DEFAULT NOW() en DB según tu DDL,
        // así que no es necesario setearlos (a menos que tu entidad los requiera).
        users.save(u);
        return u.getId();
    }

    private static RefreshTokenEntity token(UUID userId, String token, Instant expiresAt, boolean revoked) {
        var e = new RefreshTokenEntity();
        e.setId(UUID.randomUUID());
        e.setUserId(userId);
        e.setToken(token);
        e.setExpiresAt(expiresAt);
        e.setRevoked(revoked);
        e.setCreatedAt(Instant.now());
        return e;
    }

    // ---------- tests ----------

    @Test
    void findByToken_returnsEntity_whenExists() {
        var userId = seedUser();
        repo.save(token(userId, "tok-123", Instant.now().plusSeconds(3600), false));

        var found = repo.findByToken("tok-123");

        assertThat(found).isPresent();
        assertThat(found.get().getUserId()).isEqualTo(userId);
    }

    @Test
    void deleteByUserId_removesAllTokensOfUser() {
        var user1 = seedUser();
        var user2 = seedUser();

        repo.save(token(user1, "a", Instant.now().plusSeconds(3600), false));
        repo.save(token(user1, "b", Instant.now().plusSeconds(3600), false));
        repo.save(token(user2, "c", Instant.now().plusSeconds(3600), false));

        long deleted = repo.deleteByUserId(user1);

        assertThat(deleted).isEqualTo(2);
        assertThat(repo.findByToken("a")).isEmpty();
        assertThat(repo.findByToken("b")).isEmpty();
        assertThat(repo.findByToken("c")).isPresent();
    }

    @Test
    void deleteByExpiresAtBefore_removesExpiredOnly() {
        var u1 = seedUser();
        var u2 = seedUser();

        var past = Instant.now().minusSeconds(60);
        var future = Instant.now().plusSeconds(3600);

        repo.save(token(u1, "x", past, false));
        repo.save(token(u2, "y", future, false));

        long deleted = repo.deleteByExpiresAtBefore(Instant.now());

        assertThat(deleted).isEqualTo(1);
        assertThat(repo.findByToken("x")).isEmpty();
        assertThat(repo.findByToken("y")).isPresent();
    }
}