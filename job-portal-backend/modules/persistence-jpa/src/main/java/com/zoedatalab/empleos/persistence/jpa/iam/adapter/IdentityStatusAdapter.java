package com.zoedatalab.empleos.persistence.jpa.iam.adapter;

import com.zoedatalab.empleos.jobs.application.ports.out.IdentityStatusPort;
import com.zoedatalab.empleos.persistence.jpa.iam.repository.JpaUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class IdentityStatusAdapter implements IdentityStatusPort {

    private final JpaUserRepository users;

    @Override
    public boolean isIdentityCompleted(UUID userId) {
        return users.findById(userId)
                .map(u -> u.getDocumentType() != null
                        && u.getDocumentNumber() != null
                        && !u.getDocumentNumber().trim().isEmpty())
                .orElse(false);
    }
}
