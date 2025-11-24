package com.zoedatalab.empleos.iam.application.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter @Builder @AllArgsConstructor @NoArgsConstructor
public class LoginCommand {
    private String email;
    private String password;
}
