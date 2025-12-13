package com.zoedatalab.empleos.persistence.jpa.jobs.adapter;

import com.zoedatalab.empleos.jobs.application.ports.out.JobLocationQueryPort;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class JobLocationQueryAdapter implements JobLocationQueryPort {

    private final NamedParameterJdbcTemplate jdbc;

    @Override
    @Transactional(readOnly = true)
    public List<JobSummaryRow> searchSummaries(UUID areaId, UUID sectorId, UUID districtId,
                                               Boolean disabilityFriendly, Instant fromDate,
                                               int page, int size) {

        int safePage = Math.max(page, 0);
        int safeSize = Math.max(size, 1);

        var sql = new StringBuilder("""
                select
                  jo.id,
                  jo.title,
                  jo.company_id,
                  jo.sector_id,
                  jo.district_id,
                  dep.name as department_name,
                  p.name   as province_name,
                  d.name   as district_name,
                  jo.disability_friendly,
                  jo.employment_type_id,
                  jo.work_mode_id,
                  jo.salary_text,
                  jo.status,
                  jo.published_at,
                  jo.suspended
                from job_offers jo
                left join catalog_district d on d.id = jo.district_id
                left join catalog_province p on p.id = d.province_id
                left join catalog_department dep on dep.id = d.department_id
                where jo.suspended = false
                """);

        var params = new org.springframework.jdbc.core.namedparam.MapSqlParameterSource();

        if (areaId != null) {
            sql.append(" and jo.area_id = :areaId");
            params.addValue("areaId", areaId);
        }
        if (sectorId != null) {
            sql.append(" and jo.sector_id = :sectorId");
            params.addValue("sectorId", sectorId);
        }
        if (districtId != null) {
            sql.append(" and jo.district_id = :districtId");
            params.addValue("districtId", districtId);
        }
        if (disabilityFriendly != null) {
            sql.append(" and jo.disability_friendly = :disabilityFriendly");
            params.addValue("disabilityFriendly", disabilityFriendly);
        }
        if (fromDate != null) {
            sql.append(" and jo.published_at >= :fromDate");
            params.addValue("fromDate", fromDate);
        }

        sql.append("""
                order by jo.published_at desc, jo.id desc
                offset :offset
                limit  :limit
                """);

        params.addValue("offset", safePage * safeSize);
        params.addValue("limit", safeSize);

        return jdbc.query(sql.toString(), params, (rs, rowNum) -> mapSummary(rs));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<JobDetailRow> findDetail(UUID jobId) {
        var sql = """
                select
                  jo.id,
                  jo.company_id,
                  jo.title,
                  jo.description,
                  jo.area_id,
                  jo.sector_id,
                  jo.district_id,
                  dep.name as department_name,
                  p.name   as province_name,
                  d.name   as district_name,
                  jo.disability_friendly,
                  jo.employment_type_id,
                  jo.work_mode_id,
                  jo.salary_text,
                  jo.status,
                  jo.published_at,
                  jo.suspended
                from job_offers jo
                left join catalog_district d on d.id = jo.district_id
                left join catalog_province p on p.id = d.province_id
                left join catalog_department dep on dep.id = d.department_id
                where jo.id = :jobId
                """;

        var rows = jdbc.query(sql, new MapSqlParameterSource("jobId", jobId), (rs, rowNum) -> mapDetail(rs));
        return rows.stream().findFirst();
    }

    private JobSummaryRow mapSummary(ResultSet rs) throws java.sql.SQLException {
        return new JobSummaryRow(
                rs.getObject("id", UUID.class),
                rs.getString("title"),
                rs.getObject("company_id", UUID.class),
                rs.getObject("sector_id", UUID.class),
                rs.getObject("district_id", UUID.class),
                rs.getString("department_name"),
                rs.getString("province_name"),
                rs.getString("district_name"),
                rs.getBoolean("disability_friendly"),
                rs.getObject("employment_type_id", UUID.class),
                rs.getObject("work_mode_id", UUID.class),
                rs.getString("salary_text"),
                rs.getString("status"),
                rs.getTimestamp("published_at").toInstant(),
                rs.getBoolean("suspended")
        );
    }

    private JobDetailRow mapDetail(ResultSet rs) throws java.sql.SQLException {
        return new JobDetailRow(
                rs.getObject("id", UUID.class),
                rs.getObject("company_id", UUID.class),
                rs.getString("title"),
                rs.getString("description"),
                rs.getObject("area_id", UUID.class),
                rs.getObject("sector_id", UUID.class),
                rs.getObject("district_id", UUID.class),
                rs.getString("department_name"),
                rs.getString("province_name"),
                rs.getString("district_name"),
                rs.getBoolean("disability_friendly"),
                rs.getObject("employment_type_id", UUID.class),
                rs.getObject("work_mode_id", UUID.class),
                rs.getString("salary_text"),
                rs.getString("status"),
                rs.getTimestamp("published_at").toInstant(),
                rs.getBoolean("suspended")
        );
    }
}
