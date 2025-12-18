package com.zoedatalab.empleos.catalogs.application.service;

import com.zoedatalab.empleos.catalogs.application.dto.GeoItemView;
import com.zoedatalab.empleos.catalogs.application.ports.in.GeoCatalogQueryService;
import com.zoedatalab.empleos.catalogs.application.ports.out.GeoCatalogQueryPort;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
public class GeoCatalogQueryServiceImpl implements GeoCatalogQueryService {

    private final GeoCatalogQueryPort port;

    @Override
    public List<GeoItemView> getDepartments() {
        return port.findActiveDepartments().stream()
                .map(i -> new GeoItemView(i.id(), i.name()))
                .toList();
    }

    @Override
    public List<GeoItemView> getProvincesByDepartment(UUID departmentId) {
        return port.findActiveProvincesByDepartment(departmentId).stream()
                .map(i -> new GeoItemView(i.id(), i.name()))
                .toList();
    }

    @Override
    public List<GeoItemView> getDistrictsByProvince(UUID provinceId) {
        return port.findActiveDistrictsByProvince(provinceId).stream()
                .map(i -> new GeoItemView(i.id(), i.name()))
                .toList();
    }
}
