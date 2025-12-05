package com.zoedatalab.empleos.persistence.jpa.applicants.adapter;

import com.zoedatalab.empleos.jobs.application.ports.out.ApplicantLookupPort;
import com.zoedatalab.empleos.jobs.domain.exception.ApplicantNotFoundException;
import com.zoedatalab.empleos.persistence.jpa.applicants.repository.JpaApplicantRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class ApplicantLookupAdapter implements ApplicantLookupPort {

    private final JpaApplicantRepository repo;

    @Override
    public UUID getApplicantIdByUserId(UUID applicantUserId) {
        return repo.findByUserId(applicantUserId)
                .orElseThrow(ApplicantNotFoundException::new)
                .getId();
    }
}
