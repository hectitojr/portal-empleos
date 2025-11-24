package com.zoedatalab.empleos.applicants.application.dto;

import lombok.Builder;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Builder
public record ApplicantView(
        UUID id, String fullName, String contactEmail, String contactPhone, UUID districtId,
        String profileSummary, boolean profileComplete, boolean active, boolean suspended,
        List<ExperienceItem> experiences, List<EducationItem> educations, List<SkillItem> skills,
        Set<UUID> disabilityIds
) {
    @Builder public record ExperienceItem(String company, String role, LocalDate startDate, LocalDate endDate, String description) {}
    @Builder public record EducationItem(String institution, String degree, LocalDate startDate, LocalDate endDate, String description) {}
    @Builder public record SkillItem(String name, String level) {}
}
