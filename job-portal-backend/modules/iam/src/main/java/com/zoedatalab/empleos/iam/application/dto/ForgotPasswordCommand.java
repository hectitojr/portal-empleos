package com.zoedatalab.empleos.iam.application.dto;

import lombok.Builder;

@Builder
public record ForgotPasswordCommand(String email) {}
