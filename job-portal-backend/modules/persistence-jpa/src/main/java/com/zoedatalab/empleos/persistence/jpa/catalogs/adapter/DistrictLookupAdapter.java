package com.zoedatalab.empleos.persistence.jpa.catalogs.adapter;

import com.zoedatalab.empleos.common.catalogs.DistrictLookupPort;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class DistrictLookupAdapter implements DistrictLookupPort {
    private final NamedParameterJdbcTemplate jdbc;

    @Override
    @Transactional(readOnly = true)
    public boolean existsById(UUID id) {
        if (id == null) return false;
        final String sql = """
                select exists (
                  select 1
                  from catalog_district d
                  where d.id = :id
                )
                """;
        Boolean exists = jdbc.queryForObject(sql, Map.of("id", id), Boolean.class);
        return Boolean.TRUE.equals(exists);
    }
}
