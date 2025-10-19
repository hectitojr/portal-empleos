package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.persistence.jpa.mapper.JobJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.repository.JpaJobOfferRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static com.zoedatalab.empleos.persistence.jpa.spec.JobOfferSpecs.*;

@Component
@RequiredArgsConstructor
public class JobRepositoryAdapter implements JobRepositoryPort {

    private final JpaJobOfferRepository repo;
    private final JobJpaMapper mapper;

    @Override
    public JobOffer save(JobOffer j) {
        return mapper.toDomain(repo.save(mapper.toEntity(j)));
    }

    @Override
    public Optional<JobOffer> findById(UUID id) {
        return repo.findById(id).map(mapper::toDomain);
    }

    @Override
    public List<JobOffer> search(UUID areaId,
                                 UUID sectorId,
                                 UUID districtId,
                                 Boolean disabilityFriendly,
                                 Instant fromDate,
                                 int page,
                                 int size) {

        // Construimos el Specification dinámico (sin :param IS NULL)
        var spec = notSuspended()
                .and(areaEquals(areaId))
                .and(sectorEquals(sectorId))
                .and(districtEquals(districtId))
                .and(disabilityEquals(disabilityFriendly))
                .and(publishedFrom(fromDate));

        // PageRequest con orden por publishedAt DESC
        var pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "publishedAt"));

        // Ejecutamos y mapeamos a dominio
        return repo.findAll(spec, pageable)
                .map(mapper::toDomain)
                .getContent();
    }

    @Override
    public boolean isOwner(UUID jobId, UUID companyId) {
        return repo.existsByIdAndCompanyId(jobId, companyId);
    }
}
