package com.zoedatalab.empleos.api.web.iam.dto;

import com.zoedatalab.empleos.iam.domain.DocumentType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record UpdateMyIdentityRequest(
        @NotNull DocumentType documentType,
        @NotBlank String documentNumber
) {
}
