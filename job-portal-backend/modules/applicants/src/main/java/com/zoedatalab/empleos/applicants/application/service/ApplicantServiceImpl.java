package com.zoedatalab.empleos.applicants.application.service;

import com.zoedatalab.empleos.applicants.domain.exception.ApplicantNotFoundException;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.applicants.application.dto.*;
import com.zoedatalab.empleos.applicants.application.ports.in.ApplicantCommandService;
import com.zoedatalab.empleos.applicants.application.ports.in.ApplicantQueryService;
import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.applicants.domain.*;
import lombok.RequiredArgsConstructor;

import java.util.*;

@RequiredArgsConstructor
public class ApplicantServiceImpl implements ApplicantCommandService, ApplicantQueryService {

    private final ApplicantRepositoryPort repo;
    private final ClockPort clock;

    @Override
    public ApplicantView getMyProfile(UUID currentUserId) {
        var a = repo.findByUserId(currentUserId).orElseThrow(ApplicantNotFoundException::new);
        return toView(a);
    }

    @Override
    public ApplicantView upsertMyProfile(UUID userId, UpsertMyApplicantCommand cmd) {
        var draft = toDomainDraft(cmd);
        var existing = repo.findByUserId(userId).orElse(null);

        boolean minData = isFilled(draft.getFullName()) && isFilled(draft.getContactEmail());
        boolean hasExpOrEdu = (draft.getExperiences()!=null && !draft.getExperiences().isEmpty())
                || (draft.getEducations()!=null  && !draft.getEducations().isEmpty());
        boolean profileComplete = minData && hasExpOrEdu;

        var now = clock.now();

        var toSave = (existing == null)
                ? Applicant.builder()
                .id(UUID.randomUUID())
                .userId(userId)
                .fullName(trim(draft.getFullName()))
                .contactEmail(trimLower(draft.getContactEmail()))
                .contactPhone(trim(draft.getContactPhone()))
                .districtId(draft.getDistrictId())
                .profileSummary(trim(draft.getProfileSummary()))
                .experiences(normalizeExperiences(draft.getExperiences()))
                .educations(normalizeEducations(draft.getEducations()))
                .skills(normalizeSkills(draft.getSkills()))
                .disabilityIds(draft.getDisabilityIds()==null? new HashSet<>() : new HashSet<>(draft.getDisabilityIds()))
                .profileComplete(profileComplete)
                .active(true).suspended(false)
                .createdAt(now).updatedAt(now)
                .createdBy(userId).updatedBy(userId)
                .build()
                : Applicant.builder()
                .id(existing.getId())
                .userId(existing.getUserId())
                .fullName(trimOr(existing.getFullName(), draft.getFullName()))
                .contactEmail(trimLowerOr(existing.getContactEmail(), draft.getContactEmail()))
                .contactPhone(trimOr(existing.getContactPhone(), draft.getContactPhone()))
                .districtId(draft.getDistrictId()!=null? draft.getDistrictId() : existing.getDistrictId())
                .profileSummary(trimOr(existing.getProfileSummary(), draft.getProfileSummary()))
                .experiences(normalizeExperiences(draft.getExperiences()))
                .educations(normalizeEducations(draft.getEducations()))
                .skills(normalizeSkills(draft.getSkills()))
                .disabilityIds(draft.getDisabilityIds()==null? existing.getDisabilityIds() : new HashSet<>(draft.getDisabilityIds()))
                .profileComplete(profileComplete)
                .active(existing.isActive())
                .suspended(existing.isSuspended())
                .createdAt(existing.getCreatedAt())
                .updatedAt(now)
                .createdBy(existing.getCreatedBy())
                .updatedBy(userId)
                .build();

        var saved = repo.save(toSave);
        return toView(saved);
    }

    // --- mapping helpers ---
    private static Applicant toDomainDraft(UpsertMyApplicantCommand c){
        return Applicant.builder()
                .fullName(c.fullName())
                .contactEmail(c.contactEmail())
                .contactPhone(c.contactPhone())
                .districtId(c.districtId())
                .profileSummary(c.profileSummary())
                .experiences(c.experiences()==null? List.of() : c.experiences().stream().map(e ->
                        Experience.builder().company(e.company()).role(e.role())
                                .startDate(e.startDate()).endDate(e.endDate()).description(e.description()).build()
                ).toList())
                .educations(c.educations()==null? List.of() : c.educations().stream().map(e ->
                        Education.builder().institution(e.institution()).degree(e.degree())
                                .startDate(e.startDate()).endDate(e.endDate()).description(e.description()).build()
                ).toList())
                .skills(c.skills()==null? List.of() : c.skills().stream().map(s ->
                        Skill.builder().name(s.name()).level(s.level()).build()
                ).toList())
                .disabilityIds(c.disabilityIds()==null? Set.of() : new HashSet<>(c.disabilityIds()))
                .build();
    }

    private static ApplicantView toView(Applicant a){
        var exps = a.getExperiences().stream()
                .map(e -> new ApplicantView.ExperienceItem(e.getCompany(), e.getRole(), e.getStartDate(), e.getEndDate(), e.getDescription()))
                .toList();
        var edus = a.getEducations().stream()
                .map(e -> new ApplicantView.EducationItem(e.getInstitution(), e.getDegree(), e.getStartDate(), e.getEndDate(), e.getDescription()))
                .toList();
        var skills = a.getSkills().stream()
                .map(s -> new ApplicantView.SkillItem(s.getName(), s.getLevel()))
                .toList();

        return ApplicantView.builder()
                .id(a.getId()).fullName(a.getFullName()).contactEmail(a.getContactEmail()).contactPhone(a.getContactPhone())
                .districtId(a.getDistrictId()).profileSummary(a.getProfileSummary())
                .profileComplete(a.isProfileComplete()).active(a.isActive()).suspended(a.isSuspended())
                .experiences(exps).educations(edus).skills(skills).disabilityIds(a.getDisabilityIds())
                .build();
    }

    // normalizaciones (idénticas a las que ya tenías)
    private static boolean isFilled(String s){ return s != null && !s.trim().isEmpty(); }
    private static String trim(String s){ return s == null? null : s.trim(); }
    private static String trimLower(String s){ return s == null? null : s.trim().toLowerCase(); }
    private static String trimOr(String base, String cand){ return cand==null? base : trim(cand); }
    private static String trimLowerOr(String base, String cand){ return cand==null? base : trimLower(cand); }
    private static List<Experience> normalizeExperiences(List<Experience> list){ if (list==null) return List.of();
        return list.stream().map(e -> Experience.builder()
                .id(e.getId()==null? UUID.randomUUID(): e.getId())
                .company(trim(e.getCompany())).role(trim(e.getRole()))
                .startDate(e.getStartDate()).endDate(e.getEndDate())
                .description(trim(e.getDescription()))
                .build()).toList();
    }
    private static List<Education> normalizeEducations(List<Education> list){ if (list==null) return List.of();
        return list.stream().map(e -> Education.builder()
                .id(e.getId()==null? UUID.randomUUID(): e.getId())
                .institution(trim(e.getInstitution())).degree(trim(e.getDegree()))
                .startDate(e.getStartDate()).endDate(e.getEndDate())
                .description(trim(e.getDescription()))
                .build()).toList();
    }
    private static List<Skill> normalizeSkills(List<Skill> list){ if (list==null) return List.of();
        return list.stream().map(s -> Skill.builder()
                .id(s.getId()==null? UUID.randomUUID(): s.getId())
                .name(trim(s.getName())).level(trim(s.getLevel()))
                .build()).toList();
    }
}
