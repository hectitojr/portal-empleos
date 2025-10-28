package com.zoedatalab.empleos.applications.application.dto;

import jakarta.validation.constraints.Size;

public record ApplyToJobCommand(
        @Size(max = 2000) String notes
) {}
