package com.zoedatalab.empleos.catalogs.application.ports.in;

import com.zoedatalab.empleos.catalogs.application.dto.DistrictResolveView;
import com.zoedatalab.empleos.catalogs.application.dto.GeoItemView;

import java.util.List;
import java.util.UUID;

public interface GeoCatalogQueryService {

    List<GeoItemView> getDepartments();

    List<GeoItemView> getProvincesByDepartment(UUID departmentId);

    List<GeoItemView> getDistrictsByProvince(UUID provinceId);

    DistrictResolveView resolveDistrict(UUID districtId);
}
