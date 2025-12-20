package com.zoedatalab.empleos.api.web.catalogs.dto;

import java.util.UUID;

public record DistrictResolveResponse(
        UUID id,
        String name,
        UUID provinceId,
        UUID departmentId
) {
    public static DistrictResolveResponse from(UUID id, String name, UUID provinceId, UUID departmentId) {
        return new DistrictResolveResponse(id, name, provinceId, departmentId);
    }
}
