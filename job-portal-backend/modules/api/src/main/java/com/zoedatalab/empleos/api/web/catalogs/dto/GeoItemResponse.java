package com.zoedatalab.empleos.api.web.catalogs.dto;

import java.util.UUID;

public record GeoItemResponse(UUID id, String name) {
    public static GeoItemResponse from(UUID id, String name) {
        return new GeoItemResponse(id, name);
    }
}
