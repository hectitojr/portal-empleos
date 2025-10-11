package com.zoedatalab.empleos.persistence.jpa.mapper;

import com.zoedatalab.empleos.companies.domain.Company;
import com.zoedatalab.empleos.persistence.jpa.entity.CompanyEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CompanyJpaMapper {
    CompanyEntity toEntity(Company d);
    Company toDomain(CompanyEntity e);
}
