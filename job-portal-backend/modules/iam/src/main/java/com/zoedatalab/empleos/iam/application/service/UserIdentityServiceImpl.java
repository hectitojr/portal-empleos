package com.zoedatalab.empleos.iam.application.service;

import com.zoedatalab.empleos.iam.application.dto.UpdateMyIdentityCommand;
import com.zoedatalab.empleos.iam.application.ports.in.UserIdentityService;
import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import com.zoedatalab.empleos.iam.domain.IdentityDocument;
import com.zoedatalab.empleos.iam.domain.User;
import com.zoedatalab.empleos.iam.domain.exception.IdentityDocumentAlreadyExistsException;
import com.zoedatalab.empleos.iam.domain.exception.UserNotFoundException;
import lombok.RequiredArgsConstructor;

import java.util.UUID;

@RequiredArgsConstructor
public class UserIdentityServiceImpl implements UserIdentityService {

    private final UserRepositoryPort users;

    @Override
    public void updateMyIdentity(UUID userId, UpdateMyIdentityCommand cmd) {

        User user = users.findById(userId)
                .orElseThrow(UserNotFoundException::new);

        var doc = IdentityDocument.of(cmd.documentType(), cmd.documentNumber());

        if (users.existsByDocumentTypeAndNumberForOtherUser(doc.type(), doc.number(), userId)) {
            throw new IdentityDocumentAlreadyExistsException();
        }

        User updated = user.withIdentity(doc.type(), doc.number());
        users.save(updated);
    }
}
