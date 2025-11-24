package com.zoedatalab.empleos.api.web.dto.jobs;

import java.time.Instant;
import java.util.UUID;

public record JobSummaryResponse(
        UUID id, String title, String companyName,
        UUID sectorId, UUID districtId, boolean disabilityFriendly,
        String status, Instant publishedAt
) {
}
