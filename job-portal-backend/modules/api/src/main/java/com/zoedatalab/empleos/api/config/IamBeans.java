package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import com.zoedatalab.empleos.iam.application.ports.out.*;
import com.zoedatalab.empleos.iam.application.service.AuthServiceImpl;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.*;
import org.springframework.context.annotation.Configuration;

@Configuration
public class IamBeans {

    @Bean(name = "authServiceCore")
    AuthService authServiceCore(UserRepositoryPort userRepo,
                                RefreshTokenRepositoryPort refreshRepo,
                                PasswordEncoderPort passwordEncoder,
                                TokenServicePort tokenService,
                                ClockPort clock,
                                ApplicantProvisioningPort applicantProvisioning,
                                CompanyProvisioningPort companyProvisioning,
                                @Value("${security.jwt.refresh-ttl-seconds:2592000}") long refreshTtlSeconds) {
        return new AuthServiceImpl(
                userRepo, refreshRepo, passwordEncoder, tokenService, clock,
                applicantProvisioning, companyProvisioning, refreshTtlSeconds
        );
    }

    @Bean
    @Primary
    AuthService authService(@Qualifier("authServiceCore") AuthService core) {
        // Decorator que añade las transacciones sin acoplar el módulo IAM a Spring
        return new TransactionalAuthService(core);
    }
}
