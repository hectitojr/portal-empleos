package com.zoedatalab.empleos.api.web.dto.applications;

import com.zoedatalab.empleos.applications.domain.Application.Status;
import java.time.Instant;
import java.util.UUID;

public record ApplicationResponse(
        UUID id, UUID jobId, UUID applicantId, Status status, String notes, Instant appliedAt
) {}
