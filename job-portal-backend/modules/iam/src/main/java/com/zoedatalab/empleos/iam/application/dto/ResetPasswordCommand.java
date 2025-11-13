package com.zoedatalab.empleos.iam.application.dto;

import lombok.Builder;

@Builder
public record ResetPasswordCommand(String selector, String token, String newPassword) {}
