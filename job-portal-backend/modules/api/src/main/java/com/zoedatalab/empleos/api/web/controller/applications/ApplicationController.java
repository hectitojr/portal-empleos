package com.zoedatalab.empleos.api.web.controller.applications;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.dto.applications.ApplicationResponse;
import com.zoedatalab.empleos.api.web.dto.applications.ApplyRequest;
import com.zoedatalab.empleos.api.web.dto.applications.UpdateStatusRequest;
import com.zoedatalab.empleos.applications.application.dto.*;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationCommandService;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationQueryService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1")
@Validated
public class ApplicationController {

    private final ApplicationCommandService cmd;
    private final ApplicationQueryService qry;

    public ApplicationController(ApplicationCommandService cmd, ApplicationQueryService qry) {
        this.cmd = cmd;
        this.qry = qry;
    }

    // POST /jobs/{jobId}/applications (POSTULANTE)
    @PostMapping("/jobs/{jobId}/applications")
    @PreAuthorize("hasRole('APPLICANT')")
    public ApplicationResponse apply(@PathVariable UUID jobId, @RequestBody(required = false) ApplyRequest body) {
        var userId = CurrentUser.idOrThrow();
        var view = cmd.apply(userId, jobId, new ApplyToJobCommand(body != null ? body.notes() : null));
        return toResponse(view);
    }

    // GET /applications/me (POSTULANTE)
    @GetMapping("/applications/me")
    @PreAuthorize("hasRole('APPLICANT')")
    public List<ApplicationResponse> myApplications(@RequestParam(defaultValue = "0") int page,
                                                    @RequestParam(defaultValue = "20") int size) {
        var userId = CurrentUser.idOrThrow();
        return qry.myApplications(userId, page, size).stream().map(this::toResponse).toList();
    }

    // GET /jobs/{jobId}/applications (EMPRESA dueña)
    @GetMapping("/jobs/{jobId}/applications")
    @PreAuthorize("hasRole('COMPANY')")
    public List<ApplicationResponse> listForJob(@PathVariable UUID jobId,
                                                @RequestParam(defaultValue = "0") int page,
                                                @RequestParam(defaultValue = "20") int size) {
        var userId = CurrentUser.idOrThrow();
        return qry.listForJob(userId, jobId, page, size).stream().map(this::toResponse).toList();
    }

    // PATCH /applications/{id}/status (EMPRESA dueña)
    @PatchMapping("/applications/{id}/status")
    @PreAuthorize("hasRole('COMPANY')")
    public ApplicationResponse updateStatus(@PathVariable UUID id,
                                            @RequestBody @Validated UpdateStatusRequest body) {
        var userId = CurrentUser.idOrThrow();
        var view = cmd.updateStatus(userId, id, new UpdateApplicationStatusCommand(body.status()));
        return toResponse(view);
    }

    private ApplicationResponse toResponse(ApplicationView v) {
        return new ApplicationResponse(v.id(), v.jobId(), v.applicantId(), v.status(), v.notes(), v.appliedAt());
    }
}
