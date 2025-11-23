package com.zoedatalab.empleos.api.security;

import com.zoedatalab.empleos.api.web.exception.ApiErrorCode;
import com.zoedatalab.empleos.api.web.exception.ApiErrorHttpHandler;
import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.iam.domain.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockFilterChain;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Base64;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class JwtAuthFilterTest {

    private UserRepositoryPort userRepo;
    private JwtTokenServiceAdapter jwt;
    private JwtAuthFilter sut;

    private static String base64Secret32Bytes() {
        byte[] key = new byte[32];
        for (int i = 0; i < key.length; i++) key[i] = (byte) i;
        return Base64.getEncoder().encodeToString(key);
    }

    @BeforeEach
    void setUp() {
        userRepo = mock(UserRepositoryPort.class);
        jwt = new JwtTokenServiceAdapter(base64Secret32Bytes(), 900, "job-portal");
        sut = new JwtAuthFilter(jwt, userRepo);
        SecurityContextHolder.clearContext();
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    @Test
    void no_authorization_header_does_not_authenticate() throws Exception {
        var req = new MockHttpServletRequest();
        var res = new MockHttpServletResponse();
        var chain = new MockFilterChain();

        sut.doFilter(req, res, chain);

        assertNull(SecurityContextHolder.getContext().getAuthentication());
        assertNull(req.getAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR));
    }

    @Test
    void invalid_subject_sets_TOKEN_INVALID() throws Exception {
        var req = new MockHttpServletRequest();
        var res = new MockHttpServletResponse();
        var chain = new MockFilterChain();

        req.addHeader("Authorization", "Bearer " + "invalid.token.here");

        sut.doFilter(req, res, chain);

        assertEquals(ApiErrorCode.TOKEN_INVALID,
                req.getAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR));
        assertNull(SecurityContextHolder.getContext().getAuthentication());
    }

    @Test
    void missing_role_claim_sets_TOKEN_INVALID() throws Exception {
        var req = new MockHttpServletRequest();
        var res = new MockHttpServletResponse();
        var chain = new MockFilterChain();

        UUID id = UUID.randomUUID();
        String raw = io.jsonwebtoken.Jwts.builder()
                .subject(id.toString())
                .issuer("job-portal")
                .issuedAt(new java.util.Date())
                .expiration(new java.util.Date(System.currentTimeMillis() + 60_000))
                .signWith(io.jsonwebtoken.security.Keys.hmacShaKeyFor(
                        java.util.Base64.getDecoder().decode(base64Secret32Bytes())))
                .compact();

        req.addHeader("Authorization", "Bearer " + raw);

        sut.doFilter(req, res, chain);

        assertEquals(ApiErrorCode.TOKEN_INVALID,
                req.getAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR));
        assertNull(SecurityContextHolder.getContext().getAuthentication());
    }

    @Test
    void user_not_found_sets_TOKEN_INVALID() throws Exception {
        UUID id = UUID.randomUUID();

        User u = mock(User.class);
        when(u.getId()).thenReturn(id);
        when(u.getEmail()).thenReturn("a@a.com");
        when(u.getRole()).thenReturn(Role.APPLICANT);

        String token = jwt.issueAccessToken(u);

        when(userRepo.findById(id)).thenReturn(Optional.empty());

        var req = new MockHttpServletRequest();
        req.addHeader("Authorization", "Bearer " + token);
        var res = new MockHttpServletResponse();
        var chain = new MockFilterChain();

        sut.doFilter(req, res, chain);

        assertEquals(ApiErrorCode.TOKEN_INVALID,
                req.getAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR));
        assertNull(SecurityContextHolder.getContext().getAuthentication());
    }

    @Test
    void suspended_user_sets_USER_SUSPENDED_and_clears_context() throws Exception {
        UUID id = UUID.randomUUID();

        User tokenUser = mock(User.class);
        when(tokenUser.getId()).thenReturn(id);
        when(tokenUser.getEmail()).thenReturn("a@a.com");
        when(tokenUser.getRole()).thenReturn(Role.COMPANY);

        String token = jwt.issueAccessToken(tokenUser);

        User dbUser = mock(User.class);
        when(dbUser.getId()).thenReturn(id);
        when(dbUser.isActive()).thenReturn(true);
        when(dbUser.isSuspended()).thenReturn(true);

        when(userRepo.findById(id)).thenReturn(Optional.of(dbUser));

        var req = new MockHttpServletRequest();
        req.addHeader("Authorization", "Bearer " + token);
        var res = new MockHttpServletResponse();
        var chain = new MockFilterChain();

        sut.doFilter(req, res, chain);

        assertEquals(ApiErrorCode.USER_SUSPENDED,
                req.getAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR));
        assertNull(SecurityContextHolder.getContext().getAuthentication());
    }

    @Test
    void valid_token_authenticates_and_sets_SECURITY_CONTEXT() throws Exception {
        UUID id = UUID.randomUUID();

        User tokenUser = mock(User.class);
        when(tokenUser.getId()).thenReturn(id);
        when(tokenUser.getEmail()).thenReturn("a@a.com");
        when(tokenUser.getRole()).thenReturn(Role.APPLICANT);

        String token = jwt.issueAccessToken(tokenUser);

        User dbUser = mock(User.class);
        when(dbUser.getId()).thenReturn(id);
        when(dbUser.isActive()).thenReturn(true);
        when(dbUser.isSuspended()).thenReturn(false);

        when(userRepo.findById(id)).thenReturn(Optional.of(dbUser));

        var req = new MockHttpServletRequest();
        req.addHeader("Authorization", "Bearer " + token);
        var res = new MockHttpServletResponse();
        var chain = new MockFilterChain();

        sut.doFilter(req, res, chain);

        var auth = SecurityContextHolder.getContext().getAuthentication();
        assertNotNull(auth);
        assertEquals(id.toString(), auth.getName());
        assertTrue(auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_APPLICANT")));
        assertNull(req.getAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR));
    }
}
