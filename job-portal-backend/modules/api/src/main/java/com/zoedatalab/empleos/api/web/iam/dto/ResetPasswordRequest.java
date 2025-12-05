package com.zoedatalab.empleos.api.web.iam.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record ResetPasswordRequest(
        @NotBlank String selector,
        @NotBlank String token,
        @NotBlank @Size(min = 8, max = 100) String newPassword
) {
}
