package com.zoedatalab.empleos.api.web.catalogs.controller;

import com.zoedatalab.empleos.api.web.catalogs.dto.CatalogItemResponse;
import com.zoedatalab.empleos.catalogs.application.ports.in.CatalogQueryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/catalogs")
@RequiredArgsConstructor
public class CatalogController {

    private final CatalogQueryService catalogs;

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

    @GetMapping("/districts")
    public ResponseEntity<List<CatalogItemResponse>> districts() {
        var list = catalogs.getDistricts()
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
}
