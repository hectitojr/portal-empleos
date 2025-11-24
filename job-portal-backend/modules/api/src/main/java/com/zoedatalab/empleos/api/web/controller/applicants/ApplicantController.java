package com.zoedatalab.empleos.api.web.controller.applicants;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.dto.applicants.ApplicantMeResponse;
import com.zoedatalab.empleos.api.web.dto.applicants.ApplicantUpsertRequest;
import com.zoedatalab.empleos.api.web.dto.applicants.EducationDto;
import com.zoedatalab.empleos.api.web.dto.applicants.ExperienceDto;
import com.zoedatalab.empleos.api.web.dto.applicants.SkillDto;
import com.zoedatalab.empleos.applicants.application.dto.ApplicantView;
import com.zoedatalab.empleos.applicants.application.dto.UpsertMyApplicantCommand;
import com.zoedatalab.empleos.applicants.application.ports.in.ApplicantCommandService;
import com.zoedatalab.empleos.applicants.application.ports.in.ApplicantQueryService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/api/v1/applicants/me")
public class ApplicantController {

    private final ApplicantCommandService command;
    private final ApplicantQueryService query;

    public ApplicantController(ApplicantCommandService command, ApplicantQueryService query) {
        this.command = command;
        this.query = query;
    }

    @GetMapping
    @PreAuthorize("hasRole('APPLICANT')")
    public ResponseEntity<ApplicantMeResponse> me() {
        var u = CurrentUser.idOrThrow();
        ApplicantView v = query.getMyProfile(u);
        return ResponseEntity.ok(toResp(v));
    }

    @PutMapping
    @PreAuthorize("hasRole('APPLICANT')")
    public ResponseEntity<ApplicantMeResponse> upsert(@Valid @RequestBody ApplicantUpsertRequest body) {
        var u = CurrentUser.idOrThrow();

        var cmd = new UpsertMyApplicantCommand(
                body.fullName(),
                body.contactEmail(),
                body.contactPhone(),
                body.districtId(),
                body.profileSummary(),
                body.experiences() == null ? List.of()
                        : body.experiences().stream()
                        .map(e -> new UpsertMyApplicantCommand.ExperienceItem(
                                e.company(), e.role(), e.startDate(), e.endDate(), e.description()))
                        .toList(),
                body.educations() == null ? List.of()
                        : body.educations().stream()
                        .map(e -> new UpsertMyApplicantCommand.EducationItem(
                                e.institution(), e.degree(), e.startDate(), e.endDate(), e.description()))
                        .toList(),
                body.skills() == null ? List.of()
                        : body.skills().stream()
                        .map(s -> new UpsertMyApplicantCommand.SkillItem(s.name(), s.level()))
                        .toList(),
                body.disabilityIds() == null ? Set.of() : body.disabilityIds()
        );

        ApplicantView v = command.upsertMyProfile(u, cmd);
        return ResponseEntity.ok(toResp(v));
    }

    private static ApplicantMeResponse toResp(ApplicantView v) {
        var exps = v.experiences().stream()
                .map(e -> new ExperienceDto(e.company(), e.role(), e.startDate(), e.endDate(), e.description()))
                .toList();
        var edus = v.educations().stream()
                .map(e -> new EducationDto(e.institution(), e.degree(), e.startDate(), e.endDate(), e.description()))
                .toList();
        var skills = v.skills().stream()
                .map(s -> new SkillDto(s.name(), s.level()))
                .toList();

        return new ApplicantMeResponse(
                v.id(),
                v.fullName(),
                v.contactEmail(),
                v.contactPhone(),
                v.districtId(),
                v.profileSummary(),
                v.profileComplete(),
                v.active(),
                v.suspended(),
                exps,
                edus,
                skills,
                v.disabilityIds()
        );
    }
}