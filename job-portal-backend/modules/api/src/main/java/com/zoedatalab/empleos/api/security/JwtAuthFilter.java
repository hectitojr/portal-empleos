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
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;
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
                UUID userId = UUID.fromString(jws.getPayload().getSubject());
                String role = (String) jws.getPayload().get("role");
                if (role != null) {
                    userRepo.findById(userId).ifPresent(u -> {
                        var auth = new UsernamePasswordAuthenticationToken(
                                u.getId().toString(),
                                null,
                                List.of(new SimpleGrantedAuthority("ROLE_" + Role.valueOf(role).name()))
                        );
                        SecurityContextHolder.getContext().setAuthentication(auth);
                    });
                }
            } catch (ExpiredJwtException ex) {
                // Token expirado -> dejamos anónimo y marcamos para que el entry point responda TOKEN_EXPIRED
                req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_EXPIRED);
            } catch (JwtException | IllegalArgumentException ex) {
                // Token inválido -> dejamos anónimo y marcamos TOKEN_INVALID
                req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_INVALID);
            }
        }
        chain.doFilter(req, res);
    }
}
