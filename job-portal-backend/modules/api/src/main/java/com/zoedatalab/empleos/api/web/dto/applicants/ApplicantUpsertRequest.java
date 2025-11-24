package com.zoedatalab.empleos.api.web.dto.applicants;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.List;
import java.util.Set;
import java.util.UUID;

public record ApplicantUpsertRequest(
        @NotBlank String fullName,
        @Email @NotBlank String contactEmail,
        String contactPhone,
        UUID districtId,
        String profileSummary,
        List<ExperienceDto> experiences,
        List<EducationDto> educations,
        List<SkillDto> skills,
        Set<UUID> disabilityIds
) {}
