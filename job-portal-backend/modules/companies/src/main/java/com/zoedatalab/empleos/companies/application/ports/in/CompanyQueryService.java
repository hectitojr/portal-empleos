package com.zoedatalab.empleos.companies.application.ports.in;

import com.zoedatalab.empleos.companies.application.dto.CompanyView;

import java.util.UUID;

public interface CompanyQueryService {
    CompanyView getMyCompany(UUID currentUserId);
}
