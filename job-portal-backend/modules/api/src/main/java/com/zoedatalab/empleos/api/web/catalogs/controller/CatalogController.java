package com.zoedatalab.empleos.api.web.catalogs.controller;

import com.zoedatalab.empleos.api.web.catalogs.dto.CatalogItemResponse;
import com.zoedatalab.empleos.api.web.catalogs.dto.DistrictResolveResponse;
import com.zoedatalab.empleos.api.web.catalogs.dto.GeoItemResponse;
import com.zoedatalab.empleos.catalogs.application.dto.GeoItemView;
import com.zoedatalab.empleos.catalogs.application.ports.in.CatalogQueryService;
import com.zoedatalab.empleos.catalogs.application.ports.in.GeoCatalogQueryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/catalogs")
@RequiredArgsConstructor
public class CatalogController {

    private final CatalogQueryService catalogs;
    private final GeoCatalogQueryService geo;

    // --------- Catálogos "simples" ---------

    @GetMapping("/areas")
    public ResponseEntity<List<CatalogItemResponse>> areas() {
        var list = catalogs.getAreas()
                .stream()
                .map(CatalogItemResponse::from)
                .toList();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/sectors")
    public ResponseEntity<List<CatalogItemResponse>> sectors() {
        var list = catalogs.getSectors()
                .stream()
                .map(CatalogItemResponse::from)
                .toList();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/employment-types")
    public ResponseEntity<List<CatalogItemResponse>> employmentTypes() {
        var list = catalogs.getEmploymentTypes()
                .stream()
                .map(CatalogItemResponse::from)
                .toList();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/work-modes")
    public ResponseEntity<List<CatalogItemResponse>> workModes() {
        var list = catalogs.getWorkModes()
                .stream()
                .map(CatalogItemResponse::from)
                .toList();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/disability-types")
    public ResponseEntity<List<CatalogItemResponse>> disabilityTypes() {
        var list = catalogs.getDisabilityTypes()
                .stream()
                .map(CatalogItemResponse::from)
                .toList();
        return ResponseEntity.ok(list);
    }

    // --------- Geo catálogos ---------

    @GetMapping("/departments")
    public ResponseEntity<List<GeoItemResponse>> departments() {
        var list = geo.getDepartments().stream()
                .map(i -> GeoItemResponse.from(i.id(), i.name()))
                .toList();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/provinces")
    public ResponseEntity<List<GeoItemResponse>> provinces(@RequestParam UUID departmentId) {
        var list = geo.getProvincesByDepartment(departmentId).stream()
                .map(i -> GeoItemResponse.from(i.id(), i.name()))
                .toList();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/districts")
    public ResponseEntity<List<GeoItemResponse>> districts(@RequestParam(required = false) UUID provinceId) {

        var stream = (provinceId != null)
                ? geo.getDistrictsByProvince(provinceId).stream()
                : catalogs.getDistricts().stream().map(v -> new GeoItemView(v.id(), v.name()));

        var list = stream
                .map(i -> GeoItemResponse.from(i.id(), i.name()))
                .toList();

        return ResponseEntity.ok(list);
    }

    @GetMapping("/districts/{districtId}")
    public ResponseEntity<DistrictResolveResponse> resolveDistrict(@PathVariable UUID districtId) {
        var r = geo.resolveDistrict(districtId);
        return ResponseEntity.ok(DistrictResolveResponse.from(r.id(), r.name(), r.provinceId(), r.departmentId()));
    }

}
