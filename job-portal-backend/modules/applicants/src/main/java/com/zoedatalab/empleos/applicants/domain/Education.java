package com.zoedatalab.empleos.applicants.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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
