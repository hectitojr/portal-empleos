package com.zoedatalab.empleos.api.web.controller;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/me")
public class MeController {
    @GetMapping
    public Map<String, String> me(Authentication auth) {
        // auth.getPrincipal() lo seteamos en JwtAuthFilter (userId como String)
        return Map.of("userId", String.valueOf(auth.getPrincipal()));
    }
}
