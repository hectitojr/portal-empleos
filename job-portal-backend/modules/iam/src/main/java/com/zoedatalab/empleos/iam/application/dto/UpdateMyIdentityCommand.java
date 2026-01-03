package com.zoedatalab.empleos.iam.application.dto;

import com.zoedatalab.empleos.iam.domain.DocumentType;
import lombok.Builder;

@Builder
public record UpdateMyIdentityCommand(
        DocumentType documentType,
        String documentNumber
) {
}
