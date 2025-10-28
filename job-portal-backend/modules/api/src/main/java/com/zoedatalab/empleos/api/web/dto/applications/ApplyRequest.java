package com.zoedatalab.empleos.api.web.dto.applications;

import jakarta.validation.constraints.Size;

public record ApplyRequest(@Size(max = 2000) String notes) {}
