package com.zoedatalab.empleos.api.web.applications.dto;

import jakarta.validation.constraints.Size;

public record ApplyRequest(@Size(max = 2000) String notes) {
}
