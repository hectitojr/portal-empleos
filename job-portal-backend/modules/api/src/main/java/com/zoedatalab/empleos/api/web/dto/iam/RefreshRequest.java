package com.zoedatalab.empleos.api.web.dto.iam;

import jakarta.validation.constraints.NotBlank;

public record RefreshRequest(
        @NotBlank String refreshToken
) {}