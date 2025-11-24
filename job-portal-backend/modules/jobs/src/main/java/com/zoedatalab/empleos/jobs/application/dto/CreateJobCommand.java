package com.zoedatalab.empleos.jobs.application.dto;

import lombok.Builder;

import java.util.UUID;

@Builder
public record CreateJobCommand(
        String title,
        String description,
        UUID areaId,
        UUID sectorId,
        UUID districtId,
        boolean disabilityFriendly
) {}
