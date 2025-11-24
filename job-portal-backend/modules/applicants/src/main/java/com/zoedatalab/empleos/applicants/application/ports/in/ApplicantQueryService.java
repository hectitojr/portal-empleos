package com.zoedatalab.empleos.applicants.application.ports.in;

import com.zoedatalab.empleos.applicants.application.dto.ApplicantView;

import java.util.UUID;

public interface ApplicantQueryService {
    ApplicantView getMyProfile(UUID currentUserId);
}
