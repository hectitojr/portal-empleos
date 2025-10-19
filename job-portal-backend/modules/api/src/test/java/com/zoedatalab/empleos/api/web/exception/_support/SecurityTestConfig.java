package com.zoedatalab.empleos.api.web.exception._support;

import com.zoedatalab.empleos.api.web.exception.ApiErrorHttpHandler;
import jakarta.annotation.Nullable;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

/**
 * Configuración de seguridad SOLO para tests.
 * Simula autenticación leyendo el header "X-Test-Auth": [ok|expired|invalid]
 */
@Configuration
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityTestConfig {

    private final ApiErrorHttpHandler apiErrorHandler;

    @Bean
    SecurityFilterChain testSecurity(HttpSecurity http, OncePerRequestFilter testAuthFilter) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint(apiErrorHandler)
                        .accessDeniedHandler(apiErrorHandler)
                )
                .authorizeHttpRequests(reg -> reg
                        .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()
                        .requestMatchers("/test/protected", "/test/admin-only").authenticated()
                        .anyRequest().permitAll()
                )
                .addFilterBefore(testAuthFilter, org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter.class)
                .httpBasic(AbstractHttpConfigurer::disable)
                .cors(Customizer.withDefaults());

        return http.build();
    }

    @Bean
    OncePerRequestFilter testAuthFilter() {
        return new OncePerRequestFilter() {
            @Override
            protected void doFilterInternal(
                    @Nullable HttpServletRequest req,
                    @Nullable HttpServletResponse res,
                    @Nullable FilterChain chain)
                    throws ServletException, IOException {
                assert req != null;
                String mode = req.getHeader("X-Test-Auth");
                if ("expired".equalsIgnoreCase(mode)) {
                    // Simula token expirado -> entry point responderá TOKEN_EXPIRED
                    req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR,
                            com.zoedatalab.empleos.api.web.exception.ApiErrorCode.TOKEN_EXPIRED);
                } else if ("invalid".equalsIgnoreCase(mode)) {
                    // Simula token inválido -> TOKEN_INVALID
                    req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR,
                            com.zoedatalab.empleos.api.web.exception.ApiErrorCode.TOKEN_INVALID);
                } else if ("ok".equalsIgnoreCase(mode)) {
                    // Autenticado como COMPANY
                    var auth = new UsernamePasswordAuthenticationToken(
                            "user-123", null, List.of(new SimpleGrantedAuthority("ROLE_COMPANY")));
                    org.springframework.security.core.context.SecurityContextHolder.getContext().setAuthentication(auth);
                }
                assert chain != null;
                chain.doFilter(req, res);
            }
        };
    }
}