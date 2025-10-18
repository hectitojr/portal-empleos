package com.zoedatalab.empleos.applicants.domain;

import lombok.*;
import java.time.Instant;
import java.util.*;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Applicant {
    private UUID id;
    private UUID userId;
    private String fullName;
    private String contactEmail;
    private String contactPhone;
    private UUID districtId;

    @Builder.Default private List<Experience> experiences = new ArrayList<>();
    @Builder.Default private List<Education> educations = new ArrayList<>();
    @Builder.Default private List<Skill> skills = new ArrayList<>();
    @Builder.Default private Set<UUID> disabilityIds = new HashSet<>();

    private String profileSummary;
    private boolean profileComplete;
    private boolean active;
    private boolean suspended;

    private Instant createdAt;
    private Instant updatedAt;
    private UUID createdBy;
    private UUID updatedBy;
}
