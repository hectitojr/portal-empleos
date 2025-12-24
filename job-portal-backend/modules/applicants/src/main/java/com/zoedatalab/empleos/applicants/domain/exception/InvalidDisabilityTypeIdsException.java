package com.zoedatalab.empleos.applicants.domain.exception;

import lombok.Getter;

import java.util.Collections;
import java.util.Set;
import java.util.UUID;

@Getter
public class InvalidDisabilityTypeIdsException extends RuntimeException {

    private final Set<UUID> invalidIds;

    public InvalidDisabilityTypeIdsException(Set<UUID> invalidIds) {
        super("Uno o más disabilityIds no existen o no están activos.");
        this.invalidIds = (invalidIds == null) ? Set.of() : Collections.unmodifiableSet(invalidIds);
    }
}
