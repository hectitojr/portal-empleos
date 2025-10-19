package com.zoedatalab.empleos.api.web.dto.applicants;

import jakarta.validation.constraints.NotBlank;

public record SkillDto(
        @NotBlank String name,
        String level
) {}
