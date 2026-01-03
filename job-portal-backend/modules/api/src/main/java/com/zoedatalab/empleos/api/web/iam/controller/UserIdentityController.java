package com.zoedatalab.empleos.api.web.iam.controller;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.common.dto.MessageResponse;
import com.zoedatalab.empleos.api.web.iam.dto.UpdateMyIdentityRequest;
import com.zoedatalab.empleos.iam.application.dto.UpdateMyIdentityCommand;
import com.zoedatalab.empleos.iam.application.ports.in.UserIdentityService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.OffsetDateTime;

@RestController
@RequestMapping("/api/v1/iam/me")
@RequiredArgsConstructor
public class UserIdentityController {

    private final UserIdentityService identity;

    @PutMapping(value = "/identity")
    public ResponseEntity<MessageResponse> updateIdentity(@Valid @RequestBody UpdateMyIdentityRequest r) {
        var userId = CurrentUser.idOrThrow();

        identity.updateMyIdentity(
                userId,
                UpdateMyIdentityCommand.builder()
                        .documentType(r.documentType())
                        .documentNumber(r.documentNumber())
                        .build()
        );

        return ResponseEntity.ok(new MessageResponse(
                "IAM.IDENTITY.UPDATED",
                "Identidad actualizada correctamente.",
                "n/a",
                OffsetDateTime.now()
        ));
    }
}
