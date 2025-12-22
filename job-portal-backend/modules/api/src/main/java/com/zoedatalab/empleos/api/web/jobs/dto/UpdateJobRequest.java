package com.zoedatalab.empleos.api.web.jobs.dto;

import com.zoedatalab.empleos.api.web.validation.ValidSalaryRange;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;

import java.math.BigDecimal;
import java.util.UUID;

@ValidSalaryRange
public record UpdateJobRequest(
        @NotBlank
        String title,

        @NotBlank
        String description,

        UUID areaId,
        UUID sectorId,
        UUID districtId,

        boolean disabilityFriendly,

        UUID employmentTypeId,
        UUID workModeId,

        @DecimalMin(value = "0.00", message = "El salario mínimo no puede ser negativo.")
        @DecimalMax(value = "1000000.00", message = "El salario mínimo es demasiado alto.")
        @Digits(integer = 9, fraction = 2, message = "El salario mínimo debe tener hasta 2 decimales.")
        BigDecimal salaryMin,

        @DecimalMin(value = "0.00", message = "El salario máximo no puede ser negativo.")
        @DecimalMax(value = "1000000.00", message = "El salario máximo es demasiado alto.")
        @Digits(integer = 9, fraction = 2, message = "El salario máximo debe tener hasta 2 decimales.")
        BigDecimal salaryMax
) {
}
