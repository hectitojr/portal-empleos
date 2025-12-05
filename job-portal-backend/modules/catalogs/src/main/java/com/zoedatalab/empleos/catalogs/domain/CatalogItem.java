package com.zoedatalab.empleos.catalogs.domain;

import lombok.Value;

import java.util.UUID;

@Value
public class CatalogItem {
    UUID id;
    String name;
    boolean active;
}
