package com.zoedatalab.empleos.api.security;

import com.zoedatalab.empleos.api.web.exception.ApiErrorHttpHandler;
import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;

@Configuration
@EnableMethodSecurity
public class SecurityConfig {

    private static final String CORS_MAPPING = "/**";
    private static final String ENV_CORS_ALLOWED_ORIGINS = "CORS_ALLOWED_ORIGINS";

    private static final List<String> ALLOWED_METHODS =
            List.of("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS");

    private static final List<String> ALLOWED_HEADERS =
            List.of(
                    HttpHeaders.AUTHORIZATION,
                    HttpHeaders.CONTENT_TYPE,
                    HttpHeaders.ACCEPT,
                    "X-Requested-With",
                    "X-Trace-Id"
            );

    private static final List<String> EXPOSED_HEADERS =
            List.of("X-Trace-Id");

    private static String corsAllowedOriginsEnv() {
        String v = System.getenv(ENV_CORS_ALLOWED_ORIGINS);
        return v == null ? "" : v.trim();
    }

    private static List<String> parseOrigins(String raw) {
        if (raw == null || raw.isBlank()) return List.of();
        return Arrays.stream(raw.split(","))
                .map(String::trim)
                .filter(s -> !s.isBlank())
                .toList();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    @Bean
    JwtAuthFilter jwtAuthFilter(JwtTokenServiceAdapter jwt,
                                UserRepositoryPort userRepo) {
        return new JwtAuthFilter(jwt, userRepo);
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http,
                                            JwtAuthFilter jwtFilter,
                                            ApiErrorHttpHandler apiErrorHandler,
                                            @Qualifier("corsConfigurationSource") CorsConfigurationSource corsSource) throws Exception {

        http
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint(apiErrorHandler)
                        .accessDeniedHandler(apiErrorHandler)
                )
                .authorizeHttpRequests(reg -> reg
                        .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()

                        .requestMatchers(HttpMethod.GET, "/api/v1/jobs", "/api/v1/jobs/*").permitAll()
                        .requestMatchers(HttpMethod.GET, "/api/v1/catalogs/**").permitAll()

                        .requestMatchers(HttpMethod.POST,
                                "/api/v1/auth/register",
                                "/api/v1/auth/login",
                                "/api/v1/auth/refresh",
                                "/api/v1/auth/forgot-password",
                                "/api/v1/auth/reset-password"
                        ).permitAll()

                        .requestMatchers("/actuator/health", "/actuator/info", "/error").permitAll()
                        .anyRequest().authenticated()
                )
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
                .httpBasic(AbstractHttpConfigurer::disable)
                .cors(cors -> cors.configurationSource(corsSource));

        return http.build();
    }

    @Bean(name = "corsConfigurationSource")
    @Profile({"dev", "test"})
    CorsConfigurationSource corsConfigurationSourceDev() {
        CorsConfiguration cfg = baseCorsConfig();
        cfg.setAllowedOriginPatterns(List.of("*"));
        return buildCorsSource(cfg);
    }

    @Bean(name = "corsConfigurationSource")
    @Profile("prod")
    CorsConfigurationSource corsConfigurationSourceProd() {
        List<String> origins = parseOrigins(corsAllowedOriginsEnv());
        if (origins.isEmpty()) {
            return request -> null;
        }

        CorsConfiguration cfg = baseCorsConfig();
        cfg.setAllowedOrigins(origins);
        return buildCorsSource(cfg);
    }

    private CorsConfiguration baseCorsConfig() {
        CorsConfiguration cfg = new CorsConfiguration();
        cfg.setAllowedMethods(ALLOWED_METHODS);
        cfg.setAllowedHeaders(ALLOWED_HEADERS);
        cfg.setExposedHeaders(EXPOSED_HEADERS);

        cfg.setAllowCredentials(false);

        cfg.setMaxAge(3600L);
        return cfg;
    }

    private CorsConfigurationSource buildCorsSource(CorsConfiguration cfg) {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration(CORS_MAPPING, cfg);
        return source;
    }
}
