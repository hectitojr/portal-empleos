package com.zoedatalab.empleos.persistence.jpa.iam.adapter;

import com.zoedatalab.empleos.companies.application.ports.out.CompanyRepositoryPort;
import com.zoedatalab.empleos.iam.application.ports.out.EmployerStatusPort;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class EmployerStatusAdapter implements EmployerStatusPort {

    private final CompanyRepositoryPort companies;

    @Override
    public Optional<EmployerStatus> findByUserId(UUID userId) {
        return companies.findByUserId(userId)
                .map(c -> new EmployerStatus(
                        c.getEmployerType(),
                        c.isProfileComplete(),
                        c.isActive(),
                        c.isSuspended()
                ));
    }
}
