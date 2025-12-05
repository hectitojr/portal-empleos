package com.zoedatalab.empleos.api.web.catalogs.dto;

import com.zoedatalab.empleos.catalogs.application.dto.CatalogItemView;

import java.util.UUID;

public record CatalogItemResponse(
        UUID id,
        String name,
        boolean active
) {
    public static CatalogItemResponse from(CatalogItemView v) {
        return new CatalogItemResponse(v.id(), v.name(), v.active());
    }
}
