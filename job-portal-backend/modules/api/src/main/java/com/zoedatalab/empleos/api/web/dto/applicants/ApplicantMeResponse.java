package com.zoedatalab.empleos.api.web.dto.applicants;

import java.util.List;
import java.util.Set;
import java.util.UUID;

public record ApplicantMeResponse(
        UUID id,
        String fullName,
        String contactEmail,
        String contactPhone,
        UUID districtId,
        String profileSummary,
        boolean profileComplete,
        boolean active,
        boolean suspended,
        List<ExperienceDto> experiences,
        List<EducationDto> educations,
        List<SkillDto> skills,
        Set<UUID> disabilityIds
) {}
