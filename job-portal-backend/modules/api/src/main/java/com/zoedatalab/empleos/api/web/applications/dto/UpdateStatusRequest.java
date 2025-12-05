package com.zoedatalab.empleos.api.web.applications.dto;

import com.zoedatalab.empleos.applications.domain.Application.Status;
import jakarta.validation.constraints.NotNull;

public record UpdateStatusRequest(@NotNull Status status) {
}
