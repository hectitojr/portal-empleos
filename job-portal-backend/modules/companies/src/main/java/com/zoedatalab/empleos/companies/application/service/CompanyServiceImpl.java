package com.zoedatalab.empleos.companies.application.service;

import com.zoedatalab.empleos.common.catalogs.DistrictLookupPort;
import com.zoedatalab.empleos.common.catalogs.exception.DistrictNotFoundException;
import com.zoedatalab.empleos.common.time.ClockPort;
import com.zoedatalab.empleos.companies.application.dto.CompanyView;
import com.zoedatalab.empleos.companies.application.dto.UpsertMyCompanyCommand;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyCommandService;
import com.zoedatalab.empleos.companies.application.ports.in.CompanyQueryService;
import com.zoedatalab.empleos.companies.application.ports.out.CompanyJobStatsPort;
import com.zoedatalab.empleos.companies.application.ports.out.CompanyRepositoryPort;
import com.zoedatalab.empleos.companies.domain.Company;
import com.zoedatalab.empleos.companies.domain.exception.CompanyNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.CompanyProfileLockedException;
import com.zoedatalab.empleos.companies.domain.exception.TaxIdAlreadyExistsException;
import lombok.RequiredArgsConstructor;

import java.util.UUID;

@RequiredArgsConstructor
public class CompanyServiceImpl implements CompanyCommandService, CompanyQueryService {

    private final CompanyRepositoryPort repo;
    private final CompanyJobStatsPort jobStats;
    private final ClockPort clock;
    private final DistrictLookupPort districts;

    private static boolean isFilled(String s) {
        return s != null && !s.trim().isEmpty();
    }

    private static String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private static String trimLowerToNull(String s) {
        String t = trimToNull(s);
        return t == null ? null : t.toLowerCase();
    }

    private static String digitsOnlyToNull(String s) {
        String t = trimToNull(s);
        if (t == null) return null;
        String digits = t.replaceAll("\\D+", "");
        return digits.isEmpty() ? null : digits;
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
        
        var legalName = trimToNull(cmd.legalName());
        var taxId = digitsOnlyToNull(cmd.taxId());
        var contactEmail = trimLowerToNull(cmd.contactEmail());
        var contactPhone = trimToNull(cmd.contactPhone());
        var districtId = cmd.districtId();

        if (existing != null) {
            boolean wipingProfile =
                    legalName == null
                            && taxId == null
                            && contactEmail == null
                            && contactPhone == null
                            && districtId == null;

            if (wipingProfile && jobStats.hasCreatedJobs(existing.getId())) {
                throw new CompanyProfileLockedException();
            }
        }

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

        var profileComplete =
                isFilled(legalName)
                        && isFilled(taxId)
                        && isFilled(contactEmail)
                        && (districtId != null);

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
