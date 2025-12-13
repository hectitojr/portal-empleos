package com.zoedatalab.empleos.persistence.jpa.catalogs.adapter;

import com.zoedatalab.empleos.jobs.application.ports.out.JobCatalogValidationPort;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogAreaRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogDistrictRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogEmploymentTypeRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogSectorRepository;
import com.zoedatalab.empleos.persistence.jpa.catalogs.repository.JpaCatalogWorkModeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class JobCatalogValidationAdapter implements JobCatalogValidationPort {

    private final JpaCatalogAreaRepository areas;
    private final JpaCatalogSectorRepository sectors;
    private final JpaCatalogDistrictRepository districts;
    private final JpaCatalogEmploymentTypeRepository employmentTypes;
    private final JpaCatalogWorkModeRepository workModes;

    @Override
    public boolean areaExists(UUID areaId) {
        return areas.existsByIdAndActiveTrue(areaId);
    }

    @Override
    public boolean sectorExists(UUID sectorId) {
        return sectors.existsByIdAndActiveTrue(sectorId);
    }

    @Override
    public boolean districtExists(UUID districtId) {
        return districts.existsByIdAndActiveTrue(districtId);
    }

    @Override
    public boolean employmentTypeExists(UUID employmentTypeId) {
        return employmentTypes.existsByIdAndActiveTrue(employmentTypeId);
    }

    @Override
    public boolean workModeExists(UUID workModeId) {
        return workModes.existsByIdAndActiveTrue(workModeId);
    }
}
