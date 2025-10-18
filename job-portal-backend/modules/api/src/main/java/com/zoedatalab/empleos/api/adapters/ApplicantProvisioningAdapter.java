package com.zoedatalab.empleos.api.adapters;

import com.zoedatalab.empleos.applicants.application.dto.UpsertMyApplicantCommand;
import com.zoedatalab.empleos.applicants.application.ports.in.ApplicantCommandService;
import com.zoedatalab.empleos.common.provisioning.ApplicantProvisioningPort;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class ApplicantProvisioningAdapter implements ApplicantProvisioningPort {

    private final ApplicantCommandService applicants;

    @Override
    public void provision(UUID userId) {
        var cmd = new UpsertMyApplicantCommand(
                "",        // fullName (NOT NULL)
                "",        // contactEmail (NOT NULL)
                null,      // contactPhone
                null,      // districtId
                null,      // profileSummary
                List.of(), // experiences
                List.of(), // educations
                List.of(), // skills
                Set.of()   // disabilityIds
        );
        applicants.upsertMyProfile(userId, cmd);
    }
}
