package com.zoedatalab.empleos.api.security;

import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.Customizer;
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

import java.util.List;

@Configuration
@EnableMethodSecurity // para @PreAuthorize en tus endpoints cuando los uses
public class SecurityConfig {

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    @Bean
    JwtAuthFilter jwtAuthFilter(JwtTokenServiceAdapter jwt, UserRepositoryPort userRepo) {
        return new JwtAuthFilter(jwt, userRepo);
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http, JwtAuthFilter jwtFilter) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint((req, res, e) -> {
                            res.setStatus(HttpStatus.UNAUTHORIZED.value());
                            res.setContentType("application/json");
                            res.getWriter().write("{\"error\":\"UNAUTHORIZED\"}");
                        })
                        .accessDeniedHandler((req, res, e) -> {
                            res.setStatus(HttpStatus.FORBIDDEN.value());
                            res.setContentType("application/json");
                            res.getWriter().write("{\"error\":\"FORBIDDEN\"}");
                        })
                )
                .authorizeHttpRequests(reg -> reg
                        .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()                 // CORS preflight
                        .requestMatchers(HttpMethod.POST, "/api/v1/auth/**").permitAll()       // register/login/refresh públicos
                        .requestMatchers("/actuator/health", "/actuator/info").permitAll()     // health+info abiertos
                        .anyRequest().authenticated()
                )
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
                .httpBasic(AbstractHttpConfigurer::disable) // sin Basic Auth, evitamos WWW-Authenticate
                .cors(Customizer.withDefaults());           // usa bean de CORS en dev/test

        return http.build();
    }

    /**
     * CORS solo para DEV/TEST: permite orígenes comunes de front local.
     * En PROD, no se registra este bean (restringe CORS según tus necesidades allí).
     */
    @Bean
    @Profile({"dev","test"})
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration cfg = new CorsConfiguration();
        // Para desarrollo puedes abrir a todos los orígenes. Ajusta si ya sabes tu front exacto.
        cfg.setAllowedOriginPatterns(List.of("*"));
        cfg.setAllowedMethods(List.of("GET","POST","PUT","PATCH","DELETE","OPTIONS"));
        cfg.setAllowedHeaders(List.of("Authorization","Content-Type","X-Requested-With"));
        cfg.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", cfg);
        return source;
    }
}
