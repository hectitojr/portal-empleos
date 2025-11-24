package com.zoedatalab.empleos.api.web.dto.applicants;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;

public record ExperienceDto(
        @NotBlank String company,
        @NotBlank String role,
        @NotNull LocalDate startDate,
        LocalDate endDate,
        String description
) {}
