package com.zoedatalab.empleos.api.web.jobs.controller;

import com.zoedatalab.empleos.api.web.jobs.dto.JobDetailResponse;
import com.zoedatalab.empleos.api.web.jobs.dto.JobSummaryResponse;
import com.zoedatalab.empleos.jobs.application.ports.in.JobQueryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/jobs")
@RequiredArgsConstructor
public class PublicJobController {

    private final JobQueryService queries;

    @GetMapping
    public ResponseEntity<List<JobSummaryResponse>> search(
            @RequestParam(required = false) UUID areaId,
            @RequestParam(required = false) UUID sectorId,
            @RequestParam(required = false) UUID departmentId,
            @RequestParam(required = false) UUID provinceId,
            @RequestParam(required = false) UUID districtId,
            @RequestParam(required = false) Boolean disabilityFriendly,
            @RequestParam(required = false) Instant fromDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size
    ) {
        var list = queries.search(
                        areaId, sectorId, departmentId, provinceId, districtId,
                        disabilityFriendly, fromDate, page, size
                )
                .stream()
                .map(JobSummaryResponse::from)
                .toList();

        return ResponseEntity.ok(list);
    }

    @GetMapping("/{jobId}")
    public ResponseEntity<JobDetailResponse> detail(@PathVariable UUID jobId) {
        var v = queries.getById(jobId);
        return ResponseEntity.ok(JobDetailResponse.from(v));
    }
}
