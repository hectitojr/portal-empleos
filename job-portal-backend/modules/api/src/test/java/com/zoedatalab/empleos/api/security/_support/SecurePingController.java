package com.zoedatalab.empleos.api.security._support;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/secure")
public class SecurePingController {

    @GetMapping("/ping")
    public String ping() {
        return "ok";
    }

    @GetMapping("/admin")
    @PreAuthorize("hasRole('ADMIN')")
    public String admin() {
        return "admin-ok";
    }
}
