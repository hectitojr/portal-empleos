package com.zoedatalab.empleos.api.web.dto.applications;

import com.zoedatalab.empleos.applications.domain.Application.Status;
import jakarta.validation.constraints.NotNull;

public record UpdateStatusRequest(@NotNull Status status) {}
