package com.zoedatalab.empleos.iam.application.dto;

import com.zoedatalab.empleos.companies.domain.EmployerType;
import com.zoedatalab.empleos.iam.domain.Role;

import java.util.UUID;

public record AuthMeView(
        UUID id,
        String email,
        Role role,
        boolean active,
        boolean suspended,
        boolean identityCompleted,
        EmployerType employerType,
        boolean employerProfileCompleted,
        boolean employerActive,
        boolean employerSuspended
) {
}
