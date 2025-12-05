package com.zoedatalab.empleos.persistence.jpa.companies.mapper;

import com.zoedatalab.empleos.companies.domain.Company;
import com.zoedatalab.empleos.persistence.jpa.companies.entity.CompanyEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CompanyJpaMapper {
    CompanyEntity toEntity(Company d);

    Company toDomain(CompanyEntity e);
}
