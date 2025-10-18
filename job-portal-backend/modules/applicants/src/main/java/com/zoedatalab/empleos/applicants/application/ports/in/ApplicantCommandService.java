package com.zoedatalab.empleos.applicants.application.ports.in;

import com.zoedatalab.empleos.applicants.application.dto.ApplicantView;
import com.zoedatalab.empleos.applicants.application.dto.UpsertMyApplicantCommand;
import java.util.UUID;

public interface ApplicantCommandService {
    ApplicantView upsertMyProfile(UUID currentUserId, UpsertMyApplicantCommand cmd);
}
