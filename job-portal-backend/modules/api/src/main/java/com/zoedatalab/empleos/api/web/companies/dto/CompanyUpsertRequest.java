package com.zoedatalab.empleos.api.web.companies.dto;

import com.zoedatalab.empleos.api.web.validation.PeruRuc;
import jakarta.validation.constraints.Email;

import java.util.UUID;

public record CompanyUpsertRequest(
        String legalName,

        @PeruRuc
        String taxId,

        @Email(message = "Correo inválido.")
        String contactEmail,

        String contactPhone,

        UUID districtId
) {
}
