package com.zoedatalab.empleos.catalogs.application.service;

import com.zoedatalab.empleos.catalogs.application.dto.CatalogItemView;
import com.zoedatalab.empleos.catalogs.application.ports.in.CatalogQueryService;
import com.zoedatalab.empleos.catalogs.application.ports.out.CatalogQueryPort;
import com.zoedatalab.empleos.catalogs.domain.CatalogItem;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class CatalogQueryServiceImpl implements CatalogQueryService {

    private final CatalogQueryPort port;

    @Override
    public List<CatalogItemView> getAreas() {
        return map(port.findActiveAreas());
    }

    @Override
    public List<CatalogItemView> getSectors() {
        return map(port.findActiveSectors());
    }

    @Override
    public List<CatalogItemView> getDistricts() {
        return map(port.findActiveDistricts());
    }

    @Override
    public List<CatalogItemView> getEmploymentTypes() {
        return map(port.findActiveEmploymentTypes());
    }

    @Override
    public List<CatalogItemView> getWorkModes() {
        return map(port.findActiveWorkModes());
    }

    @Override
    public List<CatalogItemView> getDisabilityTypes() {
        return map(port.findActiveDisabilityTypes());
    }

    private List<CatalogItemView> map(List<CatalogItem> items) {
        return items.stream()
                .map(i -> new CatalogItemView(i.getId(), i.getName(), i.isActive()))
                .toList();
    }
}
