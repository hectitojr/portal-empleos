package com.zoedatalab.empleos.iam.application.dto;

import lombok.*;

@Getter @Builder @AllArgsConstructor @NoArgsConstructor
public class LoginCommand {
    private String email;
    private String password;
}
