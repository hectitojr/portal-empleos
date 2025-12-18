package com.zoedatalab.empleos.api.config.catalogs;

import com.zoedatalab.empleos.catalogs.application.ports.in.CatalogQueryService;
import com.zoedatalab.empleos.catalogs.application.ports.in.GeoCatalogQueryService;
import com.zoedatalab.empleos.catalogs.application.ports.out.CatalogQueryPort;
import com.zoedatalab.empleos.catalogs.application.ports.out.GeoCatalogQueryPort;
import com.zoedatalab.empleos.catalogs.application.service.CatalogQueryServiceImpl;
import com.zoedatalab.empleos.catalogs.application.service.GeoCatalogQueryServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class CatalogBeansConfig {

    @Bean(name = "catalogQueryServiceCore")
    CatalogQueryServiceImpl catalogQueryServiceCore(CatalogQueryPort port) {
        return new CatalogQueryServiceImpl(port);
    }

    @Bean
    @Primary
    CatalogQueryService catalogQueryService(CatalogQueryServiceImpl core) {
        return new TransactionalCatalogQueryService(core);
    }

    @Bean(name = "geoCatalogQueryServiceCore")
    GeoCatalogQueryServiceImpl geoCatalogQueryServiceCore(GeoCatalogQueryPort port) {
        return new GeoCatalogQueryServiceImpl(port);
    }

    @Bean
    @Primary
    GeoCatalogQueryService geoCatalogQueryService(GeoCatalogQueryServiceImpl core) {
        return new TransactionalGeoCatalogQueryService(core);
    }
}
