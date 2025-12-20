package com.zoedatalab.empleos.catalogs.application.dto;

import java.util.UUID;

public record DistrictResolveView(
        UUID id,
        String name,
        UUID provinceId,
        UUID departmentId
) {
}
