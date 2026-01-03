package com.zoedatalab.empleos.api.web.iam.dto;

import com.zoedatalab.empleos.companies.domain.EmployerType;

public record AuthMeResponse(
        String id,
        String email,
        String role,
        boolean active,
        boolean suspended,
        boolean identityCompleted,
        EmployerType employerType,
        boolean employerProfileCompleted,
        boolean employerActive,
        boolean employerSuspended
) {
}
