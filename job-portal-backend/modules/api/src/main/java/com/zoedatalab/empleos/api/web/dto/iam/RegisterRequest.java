package com.zoedatalab.empleos.api.web.dto.iam;

import com.zoedatalab.empleos.iam.domain.Role;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record RegisterRequest(
        @NotBlank @Email String email,
        @NotBlank String password,
        @NotNull Role role,

        @AssertTrue(message = "Debes aceptar los Términos y Condiciones y la Política de Privacidad.")
        boolean acceptTerms,

        @AssertTrue(message = "Debes autorizar el tratamiento de tus datos personales.")
        boolean acceptDataPolicy
) {}
