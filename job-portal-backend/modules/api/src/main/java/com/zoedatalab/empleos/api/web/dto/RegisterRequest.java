package com.zoedatalab.empleos.api.web.dto;

import com.zoedatalab.empleos.iam.domain.Role;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record RegisterRequest(
        @NotBlank @Email String email,
        @NotBlank String password,
        @NotNull Role role
) {}
