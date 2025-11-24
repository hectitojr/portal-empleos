package com.zoedatalab.empleos.companies.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.Instant;
import java.util.UUID;

@Getter @Builder @AllArgsConstructor @NoArgsConstructor @ToString
public class Company {
    private UUID id;
    private UUID userId;
    private String legalName;
    private String taxId;
    private String contactEmail;
    private String contactPhone;
    private UUID districtId;
    private boolean profileComplete;
    private boolean active;
    private boolean suspended;
    private Instant createdAt;
    private Instant updatedAt;
    private UUID createdBy;
    private UUID updatedBy;
}
