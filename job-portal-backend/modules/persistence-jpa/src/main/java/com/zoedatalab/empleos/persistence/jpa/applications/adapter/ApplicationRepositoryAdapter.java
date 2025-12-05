package com.zoedatalab.empleos.persistence.jpa.applications.adapter;

import com.zoedatalab.empleos.applications.application.ports.out.ApplicationRepositoryPort;
import com.zoedatalab.empleos.applications.domain.Application;
import com.zoedatalab.empleos.persistence.jpa.applications.mapper.ApplicationJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.applications.repository.JpaApplicationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class ApplicationRepositoryAdapter implements ApplicationRepositoryPort {

    private final JpaApplicationRepository repo;
    private final ApplicationJpaMapper mapper;

    @Override
    public Application save(Application a) {
        var saved = repo.save(mapper.toEntity(a));
        return mapper.toDomain(saved);
    }

    @Override
    public Optional<Application> findById(UUID id) {
        return repo.findById(id).map(mapper::toDomain);
    }

    @Override
    public boolean existsByJobAndApplicant(UUID jobId, UUID applicantId) {
        return repo.existsByJobIdAndApplicantId(jobId, applicantId);
    }

    @Override
    public List<Application> findByApplicant(UUID applicantId, int page, int size) {
        var pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "appliedAt"));
        return repo.findByApplicantId(applicantId, pageable).map(mapper::toDomain).getContent();
    }

    @Override
    public List<Application> findByJob(UUID jobId, int page, int size) {
        var pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "appliedAt"));
        return repo.findByJobId(jobId, pageable).map(mapper::toDomain).getContent();
    }
}
