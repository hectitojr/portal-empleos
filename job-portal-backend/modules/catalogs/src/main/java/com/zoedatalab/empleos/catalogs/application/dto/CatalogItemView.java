package com.zoedatalab.empleos.catalogs.application.dto;

import java.util.UUID;

public record CatalogItemView(
        UUID id,
        String name,
        boolean active
) {
}
