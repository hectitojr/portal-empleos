package com.zoedatalab.empleos.iam.application.dto;

import com.zoedatalab.empleos.iam.domain.Role;

import java.util.UUID;

public record AuthMeView(
        UUID id,
        String email,
        Role role,
        boolean active,
        boolean suspended
) {}
