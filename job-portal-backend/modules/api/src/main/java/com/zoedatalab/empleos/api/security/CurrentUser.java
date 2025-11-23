package com.zoedatalab.empleos.api.security;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

public final class CurrentUser {
    private CurrentUser() {}

    private static Authentication auth() {
        var context = SecurityContextHolder.getContext();
        return (context != null) ? context.getAuthentication() : null;
    }

    public static UUID id() {
        Authentication auth = auth();

        if (auth == null
                || !auth.isAuthenticated()
                || auth instanceof AnonymousAuthenticationToken
                || auth.getName() == null) {
            return null;
        }

        return tryParseUuid(auth.getName());
    }

    public static UUID idOrThrow() {
        UUID id = id();
        if (id == null) {
            throw new AuthenticationCredentialsNotFoundException("UNAUTHENTICATED");
        }
        return id;
    }

    public static Set<String> roles() {
        Authentication auth = auth();

        if (auth == null
                || !auth.isAuthenticated()
                || auth instanceof AnonymousAuthenticationToken
                || auth.getAuthorities() == null) {
            return Set.of();
        }

        return auth.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toUnmodifiableSet());
    }

    public static boolean hasRole(String role) {
        if (role == null || role.isBlank()) return false;
        String target = role.startsWith("ROLE_") ? role : "ROLE_" + role;
        return roles().contains(target);
    }

    private static UUID tryParseUuid(String value) {
        try {
            return UUID.fromString(value);
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }
}