package com.zoedatalab.empleos.persistence.jpa.spec;

import com.zoedatalab.empleos.persistence.jpa.jobs.entity.JobOfferEntity;
import org.springframework.data.jpa.domain.Specification;

import java.time.Instant;
import java.util.UUID;

public final class JobOfferSpecs {
    private JobOfferSpecs() {
    }

    public static Specification<JobOfferEntity> notSuspended() {
        return (root, q, cb) -> cb.isFalse(root.get("suspended"));
    }

    public static Specification<JobOfferEntity> areaEquals(UUID areaId) {
        return (root, q, cb) -> areaId == null ? cb.conjunction()
                : cb.equal(root.get("areaId"), areaId);
    }

    public static Specification<JobOfferEntity> sectorEquals(UUID sectorId) {
        return (root, q, cb) -> sectorId == null ? cb.conjunction()
                : cb.equal(root.get("sectorId"), sectorId);
    }

    public static Specification<JobOfferEntity> districtEquals(UUID districtId) {
        return (root, q, cb) -> districtId == null ? cb.conjunction()
                : cb.equal(root.get("districtId"), districtId);
    }

    public static Specification<JobOfferEntity> disabilityEquals(Boolean disability) {
        return (root, q, cb) -> disability == null ? cb.conjunction()
                : cb.equal(root.get("disabilityFriendly"), disability);
    }

    public static Specification<JobOfferEntity> publishedFrom(Instant fromDate) {
        return (root, q, cb) -> fromDate == null ? cb.conjunction()
                : cb.greaterThanOrEqualTo(root.get("publishedAt"), fromDate);
    }
}
