package com.zoedatalab.empleos.applicants.domain;

import lombok.*;
import java.time.LocalDate;
import java.util.UUID;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Education {
    private UUID id;
    private String institution;
    private String degree;
    private LocalDate startDate;
    private LocalDate endDate;
    private String description;
}
