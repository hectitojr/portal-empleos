package com.zoedatalab.empleos.applicants.domain;

import lombok.*;
import java.util.UUID;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Skill {
    private UUID id;
    private String name;
    private String level; // opcional (Beginner/Intermediate/Advanced)
}
