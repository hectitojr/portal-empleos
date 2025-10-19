package com.zoedatalab.empleos.api.web.exception._support;

import com.zoedatalab.empleos.applicants.domain.exception.ApplicantNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.CompanyNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.DistrictNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.TaxIdAlreadyExistsException;
import com.zoedatalab.empleos.jobs.domain.exception.JobClosedException;
import com.zoedatalab.empleos.jobs.domain.exception.JobNotFoundException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/test")
@Validated
public class TestErrorController {

    // ---------- Validación: @Valid body ----------
    public record SampleDto(@NotBlank String name) {}

    @PostMapping(value = "/validation-body", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void validationBody(@Valid @RequestBody SampleDto dto) {
        // vacío: solo valida
    }

    // ---------- Validación: @Validated params ----------
    @GetMapping("/constraint")
    public void constraintParam(@RequestParam @Min(1) int id) {
        // vacío: solo valida
    }

    // ---------- JSON mal formado ----------
    @PostMapping(value = "/malformed", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void malformed(@RequestBody SampleDto any) {
        // ahora SÍ: al intentar parsear JSON a SampleDto, un JSON inválido dispara HttpMessageNotReadableException
    }

    // ---------- Missing param ----------
    @GetMapping("/missing")
    public void missingParam(@RequestParam String requiredParam) { }

    // ---------- Type mismatch ----------
    @GetMapping("/type-mismatch")
    public void typeMismatch(@RequestParam int num) { }

    // ---------- Unsupported media type ----------
    @PostMapping(value = "/media", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void unsupportedMedia(@RequestBody SampleDto body) { }

    // ---------- DataIntegrity ----------
    @GetMapping("/integrity")
    public void integrity() {
        throw new DataIntegrityViolationException("unique violation");
    }

    // ---------- Dominio ----------
    @GetMapping("/domain/company-not-found")
    public void companyNotFound() { throw new CompanyNotFoundException(); }

    @GetMapping("/domain/tax-exists")
    public void taxExists() { throw new TaxIdAlreadyExistsException(); }

    @GetMapping("/domain/district-not-found")
    public void districtNotFound() { throw new DistrictNotFoundException(); }

    @GetMapping("/domain/applicant-not-found")
    public void applicantNotFound() { throw new ApplicantNotFoundException(); }

    @GetMapping("/domain/job-not-found")
    public void jobNotFound() { throw new JobNotFoundException(); }

    @GetMapping("/domain/job-closed")
    public void jobClosed() { throw new JobClosedException(); }

    // ---------- Seguridad ----------
    @GetMapping("/protected")
    public void protectedEndpoint() { /* requiere auth por SecurityTestConfig */ }

    @GetMapping("/admin-only")
    @PreAuthorize("hasRole('ADMIN')")
    public void adminOnly() { }
}
