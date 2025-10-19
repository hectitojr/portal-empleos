package com.zoedatalab.empleos.api.web.dto.applicants;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;

public record EducationDto(
        @NotBlank String institution,
        @NotBlank String degree,
        @NotNull LocalDate startDate,
        LocalDate endDate,
        String description
) {}
