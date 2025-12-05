package com.zoedatalab.empleos.persistence.jpa.catalogs.adapter;

import com.zoedatalab.empleos.catalogs.application.ports.out.CatalogQueryPort;
import com.zoedatalab.empleos.catalogs.domain.CatalogItem;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogAreaRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogDisabilityTypeRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogDistrictRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogEmploymentTypeRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogSectorRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogWorkModeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class CatalogRepositoryAdapter implements CatalogQueryPort {

    private final JpaCatalogAreaRepository areaRepo;
    private final JpaCatalogSectorRepository sectorRepo;
    private final JpaCatalogDistrictRepository districtRepo;
    private final JpaCatalogEmploymentTypeRepository employmentTypeRepo;
    private final JpaCatalogWorkModeRepository workModeRepo;
    private final JpaCatalogDisabilityTypeRepository disabilityTypeRepo;

    @Override
    public List<CatalogItem> findActiveAreas() {
        return areaRepo.findByActiveTrueOrderByNameAsc()
                .stream()
                .map(e -> new CatalogItem(e.getId(), e.getName(), e.isActive()))
                .toList();
    }

    @Override
    public List<CatalogItem> findActiveSectors() {
        return sectorRepo.findByActiveTrueOrderByNameAsc()
                .stream()
                .map(e -> new CatalogItem(e.getId(), e.getName(), e.isActive()))
                .toList();
    }

    @Override
    public List<CatalogItem> findActiveDistricts() {
        return districtRepo.findByActiveTrueOrderByNameAsc()
                .stream()
                .map(e -> new CatalogItem(e.getId(), e.getName(), e.isActive()))
                .toList();
    }

    @Override
    public List<CatalogItem> findActiveEmploymentTypes() {
        return employmentTypeRepo.findByActiveTrueOrderByNameAsc()
                .stream()
                .map(e -> new CatalogItem(e.getId(), e.getName(), e.isActive()))
                .toList();
    }

    @Override
    public List<CatalogItem> findActiveWorkModes() {
        return workModeRepo.findByActiveTrueOrderByNameAsc()
                .stream()
                .map(e -> new CatalogItem(e.getId(), e.getName(), e.isActive()))
                .toList();
    }

    @Override
    public List<CatalogItem> findActiveDisabilityTypes() {
        return disabilityTypeRepo.findByActiveTrueOrderByNameAsc()
                .stream()
                .map(e -> new CatalogItem(e.getId(), e.getName(), e.isActive()))
                .toList();
    }
}
