package com.zoedatalab.empleos.applicants.application.dto;


import java.time.LocalDate;
import java.util.List;
import java.util.Set;
import java.util.UUID;

public record UpsertMyApplicantCommand(
        String fullName,
        String contactEmail,
        String contactPhone,
        UUID districtId,
        String profileSummary,
        List<ExperienceItem> experiences,
        List<EducationItem> educations,
        List<SkillItem> skills,
        Set<UUID> disabilityIds
) {
    public record ExperienceItem(String company, String role, LocalDate startDate, LocalDate endDate, String description) {}
    public record EducationItem(String institution, String degree, LocalDate startDate, LocalDate endDate, String description) {}
    public record SkillItem(String name, String level) {}
}
