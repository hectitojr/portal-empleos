package com.zoedatalab.empleos.api.web.controller.companies;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.dto.companies.CompanyMeResponse;
import com.zoedatalab.empleos.api.web.dto.companies.CompanyUpsertRequest;
import com.zoedatalab.empleos.companies.application.dto.UpsertMyCompanyCommand;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyCommandService;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyQueryService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/companies/me")
public class CompanyController {

    private final CompanyCommandService command;
    private final CompanyQueryService query;

    public CompanyController(CompanyCommandService command, CompanyQueryService query) {
        this.command = command; this.query = query;
    }

    @GetMapping
    @PreAuthorize("hasRole('COMPANY')")
    public ResponseEntity<CompanyMeResponse> me() {
        var u = CurrentUser.idOrThrow(); // ← antes: CurrentUser.id()
        var v = query.getMyCompany(u);
        return ResponseEntity.ok(toResp(v));
    }

    @PutMapping
    @PreAuthorize("hasRole('COMPANY')")
    public ResponseEntity<CompanyMeResponse> upsert(@Valid @RequestBody CompanyUpsertRequest body) {
        var u = CurrentUser.idOrThrow(); // ← antes: CurrentUser.id()
        var cmd = UpsertMyCompanyCommand.builder()
                .legalName(body.legalName())
                .taxId(body.taxId())
                .contactEmail(body.contactEmail())
                .contactPhone(body.contactPhone())
                .districtId(body.districtId())
                .build();
        var v = command.upsertMyCompany(u, cmd);
        return ResponseEntity.ok(toResp(v));
    }

    private static CompanyMeResponse toResp(com.zoedatalab.empleos.companies.application.dto.CompanyView v){
        return new CompanyMeResponse(v.id(), v.legalName(), v.taxId(), v.contactEmail(), v.contactPhone(),
                v.districtId(), v.profileComplete(), v.active(), v.suspended());
    }
}
