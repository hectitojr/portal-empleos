package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.companies.application.ports.out.CompanyRepositoryPort;
import com.zoedatalab.empleos.companies.domain.Company;
import com.zoedatalab.empleos.persistence.jpa.mapper.CompanyJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.repository.JpaCompanyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class CompanyRepositoryAdapter implements CompanyRepositoryPort {
    private final JpaCompanyRepository repo;
    private final CompanyJpaMapper mapper;

    @Override
    public Optional<Company> findByUserId(UUID userId) {
        return repo.findByUserId(userId).map(mapper::toDomain);
    }

    @Override
    public boolean existsByTaxIdIgnoreCaseAndUserIdNot(String taxId, UUID userId) {
        return repo.existsByTaxIdIgnoreCaseAndUserIdNot(taxId, userId);
    }

    @Override
    public Company save(Company company) {
        return mapper.toDomain(repo.save(mapper.toEntity(company)));
    }
}
