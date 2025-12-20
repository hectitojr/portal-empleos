package com.zoedatalab.empleos.api.web.companies.dto;

import com.zoedatalab.empleos.api.web.validation.PeruRuc;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record CompanyUpsertRequest(
        @NotBlank(message = "La razón social es obligatoria.")
        String legalName,

        @NotBlank(message = "El RUC es obligatorio.")
        @PeruRuc
        String taxId,

        @NotBlank(message = "El correo de contacto es obligatorio.")
        @Email(message = "Correo inválido.")
        String contactEmail,

        String contactPhone,

        @NotNull(message = "El distrito es obligatorio.")
        UUID districtId
) {
}
