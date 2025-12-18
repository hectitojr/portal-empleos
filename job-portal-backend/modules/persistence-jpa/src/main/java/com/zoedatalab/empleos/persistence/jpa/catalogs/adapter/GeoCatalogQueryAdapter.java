package com.zoedatalab.empleos.persistence.jpa.catalogs.adapter;

import com.zoedatalab.empleos.catalogs.application.ports.out.GeoCatalogQueryPort;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class GeoCatalogQueryAdapter implements GeoCatalogQueryPort {

    private final NamedParameterJdbcTemplate jdbc;

    @Override
    @Transactional(readOnly = true)
    public List<GeoItem> findActiveDepartments() {
        final String sql = """
                select id, name
                from catalog_department
                where active = true
                order by name asc
                """;
        return jdbc.query(sql, (rs, i) ->
                new GeoItem(rs.getObject("id", UUID.class), rs.getString("name"))
        );
    }

    @Override
    @Transactional(readOnly = true)
    public List<GeoItem> findActiveProvincesByDepartment(UUID departmentId) {
        final String sql = """
                select id, name
                from catalog_province
                where active = true
                  and department_id = :departmentId
                order by name asc
                """;
        return jdbc.query(sql, Map.of("departmentId", departmentId), (rs, i) ->
                new GeoItem(rs.getObject("id", UUID.class), rs.getString("name"))
        );
    }

    @Override
    @Transactional(readOnly = true)
    public List<GeoItem> findActiveDistrictsByProvince(UUID provinceId) {
        final String sql = """
                select id, name
                from catalog_district
                where active = true
                  and province_id = :provinceId
                order by name asc
                """;
        return jdbc.query(sql, Map.of("provinceId", provinceId), (rs, i) ->
                new GeoItem(rs.getObject("id", UUID.class), rs.getString("name"))
        );
    }
}
