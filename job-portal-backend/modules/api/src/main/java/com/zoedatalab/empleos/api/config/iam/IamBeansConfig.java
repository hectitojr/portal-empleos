package com.zoedatalab.empleos.api.config.iam;

import com.zoedatalab.empleos.api.config.maintenance.MaintenanceProperties;
import com.zoedatalab.empleos.common.provisioning.ApplicantProvisioningPort;
import com.zoedatalab.empleos.common.provisioning.CompanyProvisioningPort;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import com.zoedatalab.empleos.iam.application.ports.out.NotificationsOutboxPort;
import com.zoedatalab.empleos.iam.application.ports.out.PasswordEncoderPort;
import com.zoedatalab.empleos.iam.application.ports.out.PasswordResetTokenRepositoryPort;
import com.zoedatalab.empleos.iam.application.ports.out.RefreshTokenRepositoryPort;
import com.zoedatalab.empleos.iam.application.ports.out.TokenServicePort;
import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import com.zoedatalab.empleos.iam.application.service.AuthServiceImpl;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
@org.springframework.boot.context.properties.EnableConfigurationProperties(MaintenanceProperties.class)
public class IamBeansConfig {

    @Bean(name = "authServiceCore")
    AuthService authServiceCore(UserRepositoryPort userRepo,
                                RefreshTokenRepositoryPort refreshRepo,
                                PasswordEncoderPort passwordEncoder,
                                TokenServicePort tokenService,
                                ClockPort clock,
                                CompanyProvisioningPort companyProvisioning,
                                ApplicantProvisioningPort applicantProvisioning,
                                @Value("${security.jwt.refresh-ttl-seconds:2592000}") long refreshTtlSeconds,
                                // NUEVO:
                                PasswordResetTokenRepositoryPort resetTokenRepo,
                                NotificationsOutboxPort outbox,
                                @Value("${security.reset.ttl-seconds:1800}") long resetTtlSeconds,           // 30 min
                                @Value("${security.reset.rate-limit-seconds:300}") long resetRateLimitSeconds // 5 min
    ) {

        return new AuthServiceImpl(
                userRepo,
                refreshRepo,
                passwordEncoder,
                tokenService,
                clock,
                applicantProvisioning,
                companyProvisioning,
                refreshTtlSeconds,
                resetTokenRepo,
                outbox,
                resetTtlSeconds,
                resetRateLimitSeconds
        );
    }

    @Bean
    @Primary
    AuthService authService(@Qualifier("authServiceCore") AuthService core) {
        return new TransactionalAuthService(core);
    }
}
