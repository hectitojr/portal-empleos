package com.zoedatalab.empleos.api.security;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import java.util.List;
import java.util.Set;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

class CurrentUserTest {

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    @Test
    void id_returns_null_when_no_auth() {
        SecurityContextHolder.clearContext();
        assertNull(CurrentUser.id());
    }

    @Test
    void id_returns_null_when_anonymous() {
        var anon = new AnonymousAuthenticationToken(
                "key",
                "anonymousUser",
                List.of(new SimpleGrantedAuthority("ROLE_ANONYMOUS"))
        );
        SecurityContextHolder.getContext().setAuthentication(anon);

        assertNull(CurrentUser.id());
    }

    @Test
    void id_returns_uuid_when_authenticated_and_name_is_uuid() {
        UUID id = UUID.randomUUID();
        var auth = new UsernamePasswordAuthenticationToken(
                id.toString(),
                null,
                List.of(new SimpleGrantedAuthority("ROLE_APPLICANT"))
        );
        SecurityContextHolder.getContext().setAuthentication(auth);

        assertEquals(id, CurrentUser.id());
    }

    @Test
    void id_returns_null_when_name_is_not_uuid() {
        var auth = new UsernamePasswordAuthenticationToken(
                "not-a-uuid",
                null,
                List.of(new SimpleGrantedAuthority("ROLE_APPLICANT"))
        );
        SecurityContextHolder.getContext().setAuthentication(auth);

        assertNull(CurrentUser.id());
    }

    @Test
    void idOrThrow_throws_when_no_valid_id() {
        SecurityContextHolder.clearContext();
        assertThrows(AuthenticationCredentialsNotFoundException.class, CurrentUser::idOrThrow);
    }

    @Test
    void roles_returns_empty_when_no_auth() {
        SecurityContextHolder.clearContext();
        assertEquals(Set.of(), CurrentUser.roles());
    }

    @Test
    void roles_returns_authorities() {
        var auth = new UsernamePasswordAuthenticationToken(
                UUID.randomUUID().toString(),
                null,
                List.of(
                        new SimpleGrantedAuthority("ROLE_APPLICANT"),
                        new SimpleGrantedAuthority("ROLE_OTHER")
                )
        );
        SecurityContextHolder.getContext().setAuthentication(auth);

        assertEquals(Set.of("ROLE_APPLICANT", "ROLE_OTHER"), CurrentUser.roles());
    }

    @Test
    void hasRole_accepts_role_without_prefix() {
        var auth = new UsernamePasswordAuthenticationToken(
                UUID.randomUUID().toString(),
                null,
                List.of(new SimpleGrantedAuthority("ROLE_COMPANY"))
        );
        SecurityContextHolder.getContext().setAuthentication(auth);

        assertTrue(CurrentUser.hasRole("COMPANY"));
    }

    @Test
    void hasRole_accepts_role_with_prefix() {
        var auth = new UsernamePasswordAuthenticationToken(
                UUID.randomUUID().toString(),
                null,
                List.of(new SimpleGrantedAuthority("ROLE_COMPANY"))
        );
        SecurityContextHolder.getContext().setAuthentication(auth);

        assertTrue(CurrentUser.hasRole("ROLE_COMPANY"));
    }

    @Test
    void hasRole_false_for_blank_or_missing() {
        var auth = new UsernamePasswordAuthenticationToken(
                UUID.randomUUID().toString(),
                null,
                List.of(new SimpleGrantedAuthority("ROLE_COMPANY"))
        );
        SecurityContextHolder.getContext().setAuthentication(auth);

        assertFalse(CurrentUser.hasRole(""));
        assertFalse(CurrentUser.hasRole("APPLICANT"));
    }
}