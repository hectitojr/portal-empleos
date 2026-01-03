package com.zoedatalab.empleos.api.web.companies.dto;

import com.zoedatalab.empleos.api.web.validation.PeruRuc;
import com.zoedatalab.empleos.companies.domain.EmployerType;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record CompanyUpsertRequest(

        @NotNull EmployerType employerType,

        String legalName,

        @PeruRuc
        String taxId,

        @Email(message = "Correo inválido.")
        String contactEmail,

        String contactPhone,

        UUID districtId
) {

    @AssertTrue(message = "El RUC es obligatorio cuando el tipo de empleador es COMPANY.")
    public boolean isRucValidForCompany() {
        if (employerType == null) return true;

        if (employerType == EmployerType.FREELANCE) return true;

        return taxId != null && !taxId.trim().isEmpty();
    }
}
