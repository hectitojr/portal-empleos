package com.zoedatalab.empleos.api.web.controller.jobs;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.dto.jobs.*;
import com.zoedatalab.empleos.api.web.dto.jobs.CreateJobRequest;
import com.zoedatalab.empleos.api.web.dto.jobs.JobDetailResponse;
import com.zoedatalab.empleos.api.web.dto.jobs.JobSummaryResponse;
import com.zoedatalab.empleos.api.web.dto.jobs.UpdateJobRequest;
import com.zoedatalab.empleos.jobs.application.dto.*;
import com.zoedatalab.empleos.jobs.application.ports.in.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/jobs")
@RequiredArgsConstructor
public class JobController {

    private final JobCommandService commands;
    private final JobQueryService queries;

    @GetMapping
    public ResponseEntity<List<JobSummaryResponse>> search(
            @RequestParam(required=false) UUID areaId,
            @RequestParam(required=false) UUID sectorId,
            @RequestParam(required=false) UUID districtId,
            @RequestParam(required=false) Boolean disabilityFriendly,
            @RequestParam(required=false) Instant fromDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        var list = queries.search(areaId, sectorId, districtId, disabilityFriendly, fromDate, page, size).stream()
                .map(v -> new JobSummaryResponse(v.id(), v.title(), v.companyPublicName(),
                        v.sectorId(), v.districtId(), v.disabilityFriendly(),
                        v.status(), v.publishedAt()))
                .toList();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/{jobId}")
    public ResponseEntity<JobDetailResponse> detail(@PathVariable UUID jobId) {
        var v = queries.getById(jobId);
        return ResponseEntity.ok(new JobDetailResponse(
                v.id(), v.companyId(), v.title(), v.description(),
                v.areaId(), v.sectorId(), v.districtId(),
                v.disabilityFriendly(), v.status(), v.publishedAt()
        ));
    }

    @PostMapping
    @PreAuthorize("hasRole('COMPANY')")
    public ResponseEntity<JobDetailResponse> create(@Valid @RequestBody CreateJobRequest body) {
        var u = CurrentUser.idOrThrow();
        var v = commands.create(u, CreateJobCommand.builder()
                .title(body.title()).description(body.description())
                .areaId(body.areaId()).sectorId(body.sectorId()).districtId(body.districtId())
                .disabilityFriendly(body.disabilityFriendly())
                .build());
        return ResponseEntity.ok(new JobDetailResponse(
                v.id(), v.companyId(), v.title(), v.description(),
                v.areaId(), v.sectorId(), v.districtId(),
                v.disabilityFriendly(), v.status(), v.publishedAt()
        ));
    }

    @PutMapping("/{jobId}")
    @PreAuthorize("hasRole('COMPANY')")
    public ResponseEntity<JobDetailResponse> update(@PathVariable UUID jobId,
                                                    @Valid @RequestBody UpdateJobRequest body) {
        var u = CurrentUser.idOrThrow();
        var v = commands.update(u, jobId, UpdateJobCommand.builder()
                .title(body.title()).description(body.description())
                .areaId(body.areaId()).sectorId(body.sectorId()).districtId(body.districtId())
                .disabilityFriendly(body.disabilityFriendly())
                .build());
        return ResponseEntity.ok(new JobDetailResponse(
                v.id(), v.companyId(), v.title(), v.description(),
                v.areaId(), v.sectorId(), v.districtId(),
                v.disabilityFriendly(), v.status(), v.publishedAt()
        ));
    }

    @PostMapping("/{jobId}/close")
    @PreAuthorize("hasRole('COMPANY')")
    public ResponseEntity<JobDetailResponse> close(@PathVariable UUID jobId) {
        var u = CurrentUser.idOrThrow();
        var v = commands.close(u, jobId);
        return ResponseEntity.ok(new JobDetailResponse(
                v.id(), v.companyId(), v.title(), v.description(),
                v.areaId(), v.sectorId(), v.districtId(),
                v.disabilityFriendly(), v.status(), v.publishedAt()
        ));
    }
}
