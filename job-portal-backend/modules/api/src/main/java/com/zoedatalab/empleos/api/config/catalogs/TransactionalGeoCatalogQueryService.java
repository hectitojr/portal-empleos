package com.zoedatalab.empleos.api.config.catalogs;

import com.zoedatalab.empleos.catalogs.application.dto.DistrictResolveView;
import com.zoedatalab.empleos.catalogs.application.dto.GeoItemView;
import com.zoedatalab.empleos.catalogs.application.ports.in.GeoCatalogQueryService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

public class TransactionalGeoCatalogQueryService implements GeoCatalogQueryService {

    private final GeoCatalogQueryService delegate;

    public TransactionalGeoCatalogQueryService(GeoCatalogQueryService delegate) {
        this.delegate = delegate;
    }

    @Override
    @Transactional(readOnly = true)
    public List<GeoItemView> getDepartments() {
        return delegate.getDepartments();
    }

    @Override
    @Transactional(readOnly = true)
    public List<GeoItemView> getProvincesByDepartment(UUID departmentId) {
        return delegate.getProvincesByDepartment(departmentId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<GeoItemView> getDistrictsByProvince(UUID provinceId) {
        return delegate.getDistrictsByProvince(provinceId);
    }

    @Override
    @Transactional(readOnly = true)
    public DistrictResolveView resolveDistrict(UUID districtId) {
        return delegate.resolveDistrict(districtId);
    }
}
