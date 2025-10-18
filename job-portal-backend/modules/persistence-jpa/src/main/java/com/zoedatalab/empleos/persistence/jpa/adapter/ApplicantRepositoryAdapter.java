package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.applicants.domain.Applicant;
import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.persistence.jpa.mapper.ApplicantJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.repository.JpaApplicantRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class ApplicantRepositoryAdapter implements ApplicantRepositoryPort {

    private final JpaApplicantRepository repo;
    private final ApplicantJpaMapper mapper;

    @Override
    public Optional<Applicant> findByUserId(UUID userId) {
        return repo.findByUserId(userId).map(mapper::toDomain);
    }

    @Override
    public Applicant save(Applicant applicant) {
        var entity = mapper.toEntity(applicant);
        var saved  = repo.save(entity);
        return mapper.toDomain(saved);
    }
}
