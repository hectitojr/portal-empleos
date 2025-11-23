package com.zoedatalab.empleos.api.security;

import com.zoedatalab.empleos.api.web.exception.ApiErrorCode;
import com.zoedatalab.empleos.api.web.exception.ApiErrorHttpHandler;
import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import com.zoedatalab.empleos.iam.domain.Role;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

@RequiredArgsConstructor
public class JwtAuthFilter extends OncePerRequestFilter {

    private final JwtTokenServiceAdapter jwt;
    private final UserRepositoryPort userRepo;

    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest req,
                                    @NonNull HttpServletResponse res,
                                    @NonNull FilterChain chain)
            throws ServletException, IOException {

        String header = req.getHeader(HttpHeaders.AUTHORIZATION);

        if (StringUtils.hasText(header) && header.startsWith("Bearer ")) {
            String token = header.substring(7);

            try {
                Jws<Claims> jws = jwt.parse(token);

                String subject = jws.getPayload().getSubject();
                if (!StringUtils.hasText(subject)) {
                    req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_INVALID);
                    chain.doFilter(req, res);
                    return;
                }

                UUID userId = UUID.fromString(subject);

                Object roleObj = jws.getPayload().get("role");
                if (roleObj == null) {
                    req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_INVALID);
                    chain.doFilter(req, res);
                    return;
                }

                String roleRaw = roleObj.toString().trim().toUpperCase(Locale.ROOT);
                if (roleRaw.startsWith("ROLE_")) {
                    roleRaw = roleRaw.substring(5);
                }

                final Role role;
                try {
                    role = Role.valueOf(roleRaw);
                } catch (IllegalArgumentException ex) {
                    req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_INVALID);
                    chain.doFilter(req, res);
                    return;
                }

                var userOpt = userRepo.findById(userId);
                if (userOpt.isEmpty()) {
                    req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_INVALID);
                    chain.doFilter(req, res);
                    return;
                }

                var u = userOpt.get();

                if (!u.isActive() || u.isSuspended()) {
                    SecurityContextHolder.clearContext();
                    req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.USER_SUSPENDED);
                    chain.doFilter(req, res);
                    return;
                }

                var auth = new UsernamePasswordAuthenticationToken(
                        u.getId().toString(),
                        null,
                        List.of(new SimpleGrantedAuthority("ROLE_" + role.name()))
                );
                auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(req));
                SecurityContextHolder.getContext().setAuthentication(auth);

            } catch (ExpiredJwtException ex) {
                req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_EXPIRED);
            } catch (JwtException | IllegalArgumentException ex) {
                req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_INVALID);
            }
        }

        chain.doFilter(req, res);
    }
}
