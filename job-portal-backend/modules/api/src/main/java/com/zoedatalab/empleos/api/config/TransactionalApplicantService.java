package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.applicants.application.dto.ApplicantView;
import com.zoedatalab.empleos.applicants.application.dto.UpsertMyApplicantCommand;
import com.zoedatalab.empleos.applicants.application.ports.in.ApplicantCommandService;
import com.zoedatalab.empleos.applicants.application.ports.in.ApplicantQueryService;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

public class TransactionalApplicantService implements ApplicantCommandService, ApplicantQueryService {

    private final ApplicantQueryService query;
    private final ApplicantCommandService command;

    public TransactionalApplicantService(ApplicantQueryService query, ApplicantCommandService command) {
        this.query = query;
        this.command = command;
    }

    @Override
    @Transactional(readOnly = true)
    public ApplicantView getMyProfile(UUID currentUserId) {
        return query.getMyProfile(currentUserId);
    }

    @Override
    @Transactional
    public ApplicantView upsertMyProfile(UUID currentUserId, UpsertMyApplicantCommand cmd) {
        return command.upsertMyProfile(currentUserId, cmd);
    }
}
