package com.zoedatalab.empleos.applications.application.dto;

import com.zoedatalab.empleos.applications.domain.Application.Status;
import jakarta.validation.constraints.NotNull;

public record UpdateApplicationStatusCommand(@NotNull Status status) {}
