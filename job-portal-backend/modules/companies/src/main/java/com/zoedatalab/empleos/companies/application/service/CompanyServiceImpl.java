package com.zoedatalab.empleos.companies.application.service;

import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.companies.application.dto.CompanyView;
import com.zoedatalab.empleos.companies.application.dto.UpsertMyCompanyCommand;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyCommandService;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyQueryService;
import com.zoedatalab.empleos.companies.application.ports.out.CompanyRepositoryPort;
import com.zoedatalab.empleos.companies.application.ports.out.DistrictLookupPort;
import com.zoedatalab.empleos.companies.domain.Company;
import com.zoedatalab.empleos.companies.domain.exception.CompanyNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.DistrictNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.TaxIdAlreadyExistsException;
import lombok.RequiredArgsConstructor;

import java.util.UUID;

@RequiredArgsConstructor
public class CompanyServiceImpl implements CompanyCommandService, CompanyQueryService {

    private final CompanyRepositoryPort repo;
    private final ClockPort clock;
    private final DistrictLookupPort districts;

    private static boolean isFilled(String s) {
        return s != null && !s.trim().isEmpty();
    }

    private static String trimOr(String base, String cand) {
        return cand == null ? base : cand.trim();
    }

    private static String trimLowerOr(String base, String cand) {
        return cand == null ? base : cand.trim().toLowerCase();
    }

    private static CompanyView toView(Company c) {
        return CompanyView.builder()
                .id(c.getId())
                .legalName(c.getLegalName())
                .taxId(c.getTaxId())
                .contactEmail(c.getContactEmail())
                .contactPhone(c.getContactPhone())
                .districtId(c.getDistrictId())
                .profileComplete(c.isProfileComplete())
                .active(c.isActive())
                .suspended(c.isSuspended())
                .build();
    }

    @Override
    public CompanyView getMyCompany(UUID currentUserId) {
        var c = repo.findByUserId(currentUserId).orElseThrow(CompanyNotFoundException::new);
        return toView(c);
    }

    @Override
    public CompanyView upsertMyCompany(UUID userId, UpsertMyCompanyCommand cmd) {
        var existing = repo.findByUserId(userId).orElse(null);

        var legalName = trimOr(existing != null ? existing.getLegalName() : null, cmd.legalName());
        var taxId = trimOr(existing != null ? existing.getTaxId() : null, cmd.taxId());
        var contactEmail = trimLowerOr(existing != null ? existing.getContactEmail() : null, cmd.contactEmail());
        var contactPhone = trimOr(existing != null ? existing.getContactPhone() : null, cmd.contactPhone());
        var districtId = (cmd.districtId() != null ? cmd.districtId()
                : (existing != null ? existing.getDistrictId() : null));

        if (districtId != null) {
            boolean changed = (existing == null) || !districtId.equals(existing.getDistrictId());
            if (changed && !districts.existsById(districtId)) {
                throw new DistrictNotFoundException();
            }
        }

        if (taxId != null && !taxId.isBlank()) {
            boolean usedByOther = repo.existsByTaxIdIgnoreCaseAndUserIdNot(taxId, userId);
            if (usedByOther) {
                throw new TaxIdAlreadyExistsException();
            }
        }

        var profileComplete = isFilled(legalName) && isFilled(contactEmail);

        var now = clock.now();

        var toSave = (existing == null)
                ? Company.builder()
                .id(UUID.randomUUID())
                .userId(userId)
                .legalName(legalName)
                .taxId(taxId)
                .contactEmail(contactEmail)
                .contactPhone(contactPhone)
                .districtId(districtId)
                .profileComplete(profileComplete)
                .active(true)
                .suspended(false)
                .createdAt(now).updatedAt(now)
                .createdBy(userId).updatedBy(userId)
                .build()
                : Company.builder()
                .id(existing.getId())
                .userId(existing.getUserId())
                .legalName(legalName)
                .taxId(taxId)
                .contactEmail(contactEmail)
                .contactPhone(contactPhone)
                .districtId(districtId)
                .profileComplete(profileComplete)
                .active(existing.isActive())
                .suspended(existing.isSuspended())
                .createdAt(existing.getCreatedAt())
                .updatedAt(now)
                .createdBy(existing.getCreatedBy())
                .updatedBy(userId)
                .build();

        var saved = repo.save(toSave);
        return toView(saved);
    }
}