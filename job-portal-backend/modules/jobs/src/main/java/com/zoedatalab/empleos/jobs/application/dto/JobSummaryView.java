package com.zoedatalab.empleos.jobs.application.dto;

import java.time.Instant;
import java.util.UUID;

public record JobSummaryView(
        UUID id, String title,
        UUID companyId, String companyPublicName,
        UUID sectorId, UUID districtId,
        boolean disabilityFriendly,
        String status, Instant publishedAt
) {}
