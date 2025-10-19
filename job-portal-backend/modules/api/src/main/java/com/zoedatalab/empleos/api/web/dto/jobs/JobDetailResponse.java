package com.zoedatalab.empleos.api.web.dto.jobs;

import java.time.Instant;
import java.util.UUID;

public record JobDetailResponse(
        UUID id, UUID companyId, String title, String description,
        UUID areaId, UUID sectorId, UUID districtId,
        boolean disabilityFriendly, String status, Instant publishedAt
) {}
