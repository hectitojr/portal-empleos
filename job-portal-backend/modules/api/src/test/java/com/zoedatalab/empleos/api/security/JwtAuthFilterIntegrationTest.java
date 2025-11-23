package com.zoedatalab.empleos.api.security;

import com.zoedatalab.empleos.api.security._support.RealJwtSecurityTestConfig;
import com.zoedatalab.empleos.api.security._support.SecurePingController;
import com.zoedatalab.empleos.api.web.exception.ApiErrorHttpHandler;
import com.zoedatalab.empleos.api.web.exception.GlobalExceptionHandler;
import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.iam.domain.User;
import com.zoedatalab.empleos.testsupport.SpringTestBase;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Answers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Base64;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;

import static org.hamcrest.Matchers.equalTo;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Prueba el JwtAuthFilter usando:
 *  - JwtTokenServiceAdapter REAL (firma y parseo)
 *  - Tokens reales: válido, expirado, inválido (otra firma)
 *  - ApiErrorHttpHandler (401/403 JSON contract)
 *  - UserRepositoryPort mockeado para devolver el usuario por ID
 */
@WebMvcTest(controllers = SecurePingController.class)
@Import({
        RealJwtSecurityTestConfig.class,
        ApiErrorHttpHandler.class,
        GlobalExceptionHandler.class
})
class JwtAuthFilterIntegrationTest extends SpringTestBase {

    @Autowired MockMvc mvc;
    @Autowired JwtTokenServiceAdapter jwt;

    @MockitoBean
    UserRepositoryPort userRepo;

    private UUID userId;
    private SecretKey testKey;
    private String issuer;

    @BeforeEach
    void setup() {
        userId = UUID.randomUUID();

        String raw = "0123456789abcdef0123456789abcdef";
        String b64 = Base64.getEncoder().encodeToString(raw.getBytes(StandardCharsets.UTF_8));
        byte[] secret = Decoders.BASE64.decode(b64);
        testKey = Keys.hmacShaKeyFor(secret);
        issuer = "test-issuer";

        User domainUser = mock(User.class, Answers.RETURNS_DEEP_STUBS);
        when(domainUser.getId()).thenReturn(userId);
        when(domainUser.isActive()).thenReturn(true);
        when(domainUser.isSuspended()).thenReturn(false);

        when(userRepo.findById(userId)).thenReturn(Optional.of(domainUser));
    }

    private String signToken(UUID subject, Role role, Instant issuedAt, Instant expiresAt) {
        return Jwts.builder()
                .subject(subject.toString())
                .issuer(issuer)
                .claim("email", "user@test.local")
                .claim("role", role.name())
                .issuedAt(Date.from(issuedAt))
                .expiration(Date.from(expiresAt))
                .signWith(testKey)
                .compact();
    }

    private String bearer(String jwt) {
        return "Bearer " + jwt;
    }

    @Test
    @DisplayName("200 OK con token válido → filtro autentica y pasa")
    void validToken_allowsAccess() throws Exception {
        Instant now = Instant.now();
        String token = signToken(userId, Role.COMPANY, now.minusSeconds(1), now.plusSeconds(60));

        mvc.perform(get("/secure/ping")
                        .header("Authorization", bearer(token))
                        .accept(MediaType.TEXT_PLAIN))
                .andExpect(status().isOk())
                .andExpect(content().string(equalTo("ok")));
    }

    @Test
    @DisplayName("200 OK en /secure/admin cuando el rol es ADMIN")
    void adminToken_allowsAdminEndpoint() throws Exception {
        Instant now = Instant.now();
        String token = signToken(userId, Role.ADMIN, now.minusSeconds(1), now.plusSeconds(60));

        mvc.perform(get("/secure/admin")
                        .header("Authorization", bearer(token)))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("401 TOKEN_EXPIRED cuando exp < now")
    void expiredToken_unauthorized() throws Exception {
        Instant now = Instant.now();
        String token = signToken(userId, Role.COMPANY, now.minusSeconds(120), now.minusSeconds(60));

        mvc.perform(get("/secure/ping")
                        .header("Authorization", bearer(token)))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error").value("TOKEN_EXPIRED"))
                .andExpect(jsonPath("$.status").value(401))
                .andExpect(jsonPath("$.path").value("/secure/ping"));
    }

    @Test
    @DisplayName("401 TOKEN_INVALID cuando la firma no coincide")
    void invalidSignature_unauthorized() throws Exception {
        String otherB64 = Base64.getEncoder().encodeToString(
                "other-secret-other-secret-other-32!!".getBytes(StandardCharsets.UTF_8)
        );
        SecretKey otherKey = Keys.hmacShaKeyFor(Decoders.BASE64.decode(otherB64));

        Instant now = Instant.now();
        String badToken = Jwts.builder()
                .subject(userId.toString())
                .issuer(issuer)
                .claim("role", Role.COMPANY.name())
                .issuedAt(Date.from(now))
                .expiration(Date.from(now.plusSeconds(60)))
                .signWith(otherKey)
                .compact();

        mvc.perform(get("/secure/ping")
                        .header("Authorization", bearer(badToken)))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error").value("TOKEN_INVALID"))
                .andExpect(jsonPath("$.status").value(401));
    }

    @Test
    @DisplayName("401 UNAUTHENTICATED sin header Authorization")
    void noToken_unauthenticated() throws Exception {
        mvc.perform(get("/secure/ping"))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error").value("UNAUTHENTICATED"))
                .andExpect(jsonPath("$.status").value(401));
    }

    @Test
    @DisplayName("403 FORBIDDEN cuando el rol no cumple @PreAuthorize('hasRole(ADMIN)')")
    void forbidden_whenRoleIsNotAdmin() throws Exception {
        Instant now = Instant.now();
        String token = signToken(userId, Role.COMPANY, now.minusSeconds(1), now.plusSeconds(60));

        mvc.perform(get("/secure/admin")
                        .header("Authorization", bearer(token)))
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error").value("FORBIDDEN"))
                .andExpect(jsonPath("$.status").value(403));
    }
}
