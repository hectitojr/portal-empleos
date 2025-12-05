package com.zoedatalab.empleos.api.config.catalogs;

import com.zoedatalab.empleos.catalogs.application.dto.CatalogItemView;
import com.zoedatalab.empleos.catalogs.application.ports.in.CatalogQueryService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public class TransactionalCatalogQueryService implements CatalogQueryService {

    private final CatalogQueryService delegate;

    public TransactionalCatalogQueryService(CatalogQueryService delegate) {
        this.delegate = delegate;
    }

    @Override
    @Transactional(readOnly = true)
    public List<CatalogItemView> getAreas() {
        return delegate.getAreas();
    }

    @Override
    @Transactional(readOnly = true)
    public List<CatalogItemView> getSectors() {
        return delegate.getSectors();
    }

    @Override
    @Transactional(readOnly = true)
    public List<CatalogItemView> getDistricts() {
        return delegate.getDistricts();
    }

    @Override
    @Transactional(readOnly = true)
    public List<CatalogItemView> getEmploymentTypes() {
        return delegate.getEmploymentTypes();
    }

    @Override
    @Transactional(readOnly = true)
    public List<CatalogItemView> getWorkModes() {
        return delegate.getWorkModes();
    }

    @Override
    @Transactional(readOnly = true)
    public List<CatalogItemView> getDisabilityTypes() {
        return delegate.getDisabilityTypes();
    }
}
