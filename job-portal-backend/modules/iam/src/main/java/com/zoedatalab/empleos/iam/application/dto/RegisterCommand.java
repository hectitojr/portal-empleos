package com.zoedatalab.empleos.iam.application.dto;

import com.zoedatalab.empleos.iam.domain.Role;
import lombok.*;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterCommand {
    private String email;
    private String password;
    private Role role;
    private Boolean acceptTerms;
    private Boolean acceptDataPolicy;
}
