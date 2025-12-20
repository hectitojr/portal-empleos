package com.zoedatalab.empleos.api.web.jobs.controller;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.jobs.dto.CreateJobRequest;
import com.zoedatalab.empleos.api.web.jobs.dto.JobDetailResponse;
import com.zoedatalab.empleos.api.web.jobs.dto.JobSummaryResponse;
import com.zoedatalab.empleos.api.web.jobs.dto.UpdateJobRequest;
import com.zoedatalab.empleos.jobs.application.dto.CreateJobCommand;
import com.zoedatalab.empleos.jobs.application.dto.UpdateJobCommand;
import com.zoedatalab.empleos.jobs.application.ports.in.JobCommandService;
import com.zoedatalab.empleos.jobs.application.ports.in.JobQueryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/company/jobs")
@RequiredArgsConstructor
@PreAuthorize("hasRole('COMPANY')")
public class CompanyJobController {

    private final JobCommandService commands;
    private final JobQueryService queries;

    @GetMapping
    public ResponseEntity<List<JobSummaryResponse>> listMine(
            @RequestParam(required = false) String q,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Instant fromDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size
    ) {
        var u = CurrentUser.idOrThrow();

        var rows = queries.searchForCompany(
                u,
                q,
                status,
                fromDate,
                page,
                size
        );

        var out = rows.stream()
                .map(JobSummaryResponse::from)
                .toList();

        return ResponseEntity.ok(out);
    }

    @PostMapping
    public ResponseEntity<JobDetailResponse> create(
            @Valid @RequestBody CreateJobRequest body
    ) {
        var u = CurrentUser.idOrThrow();

        var v = commands.create(u, CreateJobCommand.builder()
                .title(body.title())
                .description(body.description())
                .areaId(body.areaId())
                .sectorId(body.sectorId())
                .districtId(body.districtId())
                .disabilityFriendly(body.disabilityFriendly())
                .employmentTypeId(body.employmentTypeId())
                .workModeId(body.workModeId())
                .salaryText(body.salaryText())
                .build());

        return ResponseEntity.ok(JobDetailResponse.from(v));
    }

    @PutMapping("/{jobId}")
    public ResponseEntity<JobDetailResponse> update(
            @PathVariable UUID jobId,
            @Valid @RequestBody UpdateJobRequest body
    ) {
        var u = CurrentUser.idOrThrow();

        var v = commands.update(u, jobId, UpdateJobCommand.builder()
                .title(body.title())
                .description(body.description())
                .areaId(body.areaId())
                .sectorId(body.sectorId())
                .districtId(body.districtId())
                .disabilityFriendly(body.disabilityFriendly())
                .employmentTypeId(body.employmentTypeId())
                .workModeId(body.workModeId())
                .salaryText(body.salaryText())
                .build());

        return ResponseEntity.ok(JobDetailResponse.from(v));
    }

    @PostMapping("/{jobId}/close")
    public ResponseEntity<JobDetailResponse> close(@PathVariable UUID jobId) {
        var u = CurrentUser.idOrThrow();
        var v = commands.close(u, jobId);
        return ResponseEntity.ok(JobDetailResponse.from(v));
    }
}
