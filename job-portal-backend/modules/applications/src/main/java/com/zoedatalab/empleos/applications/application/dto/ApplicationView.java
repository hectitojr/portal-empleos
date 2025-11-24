package com.zoedatalab.empleos.applications.application.dto;

import com.zoedatalab.empleos.applications.domain.Application.Status;

import java.time.Instant;
import java.util.UUID;

public record ApplicationView(
        UUID id,
        UUID jobId,
        UUID applicantId,
        Status status,
        String notes,
        Instant appliedAt
) {}
