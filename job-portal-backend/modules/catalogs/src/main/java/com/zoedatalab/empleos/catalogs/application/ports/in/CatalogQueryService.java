package com.zoedatalab.empleos.catalogs.application.ports.in;

import com.zoedatalab.empleos.catalogs.application.dto.CatalogItemView;

import java.util.List;

public interface CatalogQueryService {

    List<CatalogItemView> getAreas();

    List<CatalogItemView> getSectors();

    List<CatalogItemView> getDistricts();

    List<CatalogItemView> getEmploymentTypes();

    List<CatalogItemView> getWorkModes();

    List<CatalogItemView> getDisabilityTypes();
}