package com.zoedatalab.empleos.api.security._support;

import com.zoedatalab.empleos.api.security.JwtAuthFilter;
import com.zoedatalab.empleos.api.security.JwtTokenServiceAdapter;
import com.zoedatalab.empleos.api.web.exception.ApiErrorHttpHandler;
import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

@TestConfiguration
@EnableMethodSecurity
public class RealJwtSecurityTestConfig {

    /**
     * Bean real del adapter, con secreto base64 generado en runtime para que
     * el test pueda firmar/verificar tokens igual que producción.
     * TTL corto (60s) para pruebas; el token expirado lo firmaremos a mano con exp en el pasado.
     */
    @Bean
    JwtTokenServiceAdapter jwtTokenServiceAdapter() {
        String raw = "0123456789abcdef0123456789abcdef"; // 32 chars = 32 bytes
        String b64 = Base64.getEncoder().encodeToString(raw.getBytes(StandardCharsets.UTF_8));
        long ttlSeconds = 60L;
        String issuer = "test-issuer";
        return new JwtTokenServiceAdapter(b64, ttlSeconds, issuer);
    }

    @Bean
    JwtAuthFilter jwtAuthFilter(JwtTokenServiceAdapter jwt, UserRepositoryPort userRepo) {
        return new JwtAuthFilter(jwt, userRepo);
    }

    @Bean
    SecurityFilterChain testChain(HttpSecurity http,
                                  JwtAuthFilter jwtFilter,
                                  ApiErrorHttpHandler apiErrorHandler) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint(apiErrorHandler)
                        .accessDeniedHandler(apiErrorHandler)
                )
                .authorizeHttpRequests(reg -> reg
                        .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()
                        .requestMatchers("/secure/**").authenticated()
                        .anyRequest().permitAll()
                )
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
                .httpBasic(AbstractHttpConfigurer::disable)
                .cors(Customizer.withDefaults());
        return http.build();
    }
}
