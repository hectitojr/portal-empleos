package com.zoedatalab.empleos.jobs.application.dto;

import java.time.Instant;
import java.util.UUID;

public record JobDetailView(
        UUID id, UUID companyId,
        String title, String description,
        UUID areaId, UUID sectorId, UUID districtId,
        boolean disabilityFriendly,
        String status, Instant publishedAt, boolean suspended
) {}
