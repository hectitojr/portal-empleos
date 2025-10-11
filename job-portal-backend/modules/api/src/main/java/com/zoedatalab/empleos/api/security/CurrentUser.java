package com.zoedatalab.empleos.api.security;

import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

public final class CurrentUser {
    private CurrentUser() {}

    /** Devuelve el UUID del usuario autenticado o null si no hay autenticación válida. */
    public static UUID id() {
        Authentication auth = SecurityContextHolder.getContext() != null
                ? SecurityContextHolder.getContext().getAuthentication()
                : null;

        if (auth == null || !auth.isAuthenticated() || auth.getName() == null) {
            return null;
        }
        try {
            return UUID.fromString(auth.getName());
        } catch (IllegalArgumentException ex) {
            return null; // Principal no es un UUID válido
        }
    }

    /** Devuelve el UUID del usuario o lanza 401 si no hay credenciales. */
    public static UUID idOrThrow() {
        UUID id = id();
        if (id == null) throw new AuthenticationCredentialsNotFoundException("UNAUTHENTICATED");
        return id;
    }

    /** Roles del usuario autenticado (por ejemplo, ROLE_COMPANY). */
    public static Set<String> roles() {
        Authentication auth = SecurityContextHolder.getContext() != null
                ? SecurityContextHolder.getContext().getAuthentication()
                : null;

        if (auth == null || auth.getAuthorities() == null) return Set.of();
        return auth.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toUnmodifiableSet());
    }

    /** True si el usuario tiene el rol indicado (con o sin prefijo ROLE_). */
    public static boolean hasRole(String role) {
        String target = role.startsWith("ROLE_") ? role : "ROLE_" + role;
        return roles().contains(target);
    }
}
