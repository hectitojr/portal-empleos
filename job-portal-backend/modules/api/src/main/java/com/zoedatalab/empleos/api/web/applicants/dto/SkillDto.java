package com.zoedatalab.empleos.api.web.applicants.dto;

import jakarta.validation.constraints.NotBlank;

public record SkillDto(
        @NotBlank String name,
        String level
) {
}
