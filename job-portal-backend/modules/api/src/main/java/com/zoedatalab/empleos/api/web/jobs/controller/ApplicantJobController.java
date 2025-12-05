package com.zoedatalab.empleos.api.web.jobs.controller;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.jobs.dto.ApplicantJobDetailResponse;
import com.zoedatalab.empleos.api.web.jobs.dto.ApplicantJobSummaryResponse;
import com.zoedatalab.empleos.jobs.application.ports.in.JobQueryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/me/applicant/jobs")
@RequiredArgsConstructor
@PreAuthorize("hasRole('APPLICANT')")
public class ApplicantJobController {

    private final JobQueryService queries;

    @GetMapping
    public ResponseEntity<List<ApplicantJobSummaryResponse>> searchForApplicant(
            @RequestParam(required = false) UUID areaId,
            @RequestParam(required = false) UUID sectorId,
            @RequestParam(required = false) UUID districtId,
            @RequestParam(required = false) Boolean disabilityFriendly,
            @RequestParam(required = false) Instant fromDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size
    ) {
        var userId = CurrentUser.idOrThrow();

        var list = queries.searchForApplicant(
                        userId, areaId, sectorId, districtId,
                        disabilityFriendly, fromDate, page, size
                )
                .stream()
                .map(ApplicantJobSummaryResponse::from)
                .toList();

        return ResponseEntity.ok(list);
    }

    @GetMapping("/{jobId}")
    public ResponseEntity<ApplicantJobDetailResponse> detailForApplicant(@PathVariable UUID jobId) {
        var userId = CurrentUser.idOrThrow();
        var v = queries.getByIdForApplicant(userId, jobId);
        return ResponseEntity.ok(ApplicantJobDetailResponse.from(v));
    }
}
