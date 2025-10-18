package com.zoedatalab.empleos.applicants.domain;

import lombok.*;
import java.time.LocalDate;
import java.util.UUID;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Experience {
    private UUID id;
    private String company;
    private String role;
    private LocalDate startDate;
    private LocalDate endDate; // null = actual
    private String description;
}
