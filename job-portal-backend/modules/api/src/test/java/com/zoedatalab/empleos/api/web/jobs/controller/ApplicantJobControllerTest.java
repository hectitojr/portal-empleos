package com.zoedatalab.empleos.api.web.jobs.controller;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.jobs.application.dto.ApplicantJobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.ApplicantJobSummaryView;
import com.zoedatalab.empleos.jobs.application.ports.in.JobQueryService;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.isNull;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = ApplicantJobController.class)
@AutoConfigureMockMvc(addFilters = false)
class ApplicantJobControllerTest {

    @Autowired
    MockMvc mvc;

    @MockitoBean
    JobQueryService queries;

    @Test
    void searchForApplicant_ok_mapsParamsAndResponse() throws Exception {
        UUID userId = UUID.randomUUID();

        UUID areaId = UUID.randomUUID();
        UUID sectorId = UUID.randomUUID();
        UUID departmentId = UUID.randomUUID();
        UUID provinceId = UUID.randomUUID();
        UUID districtId = UUID.randomUUID();

        boolean disabilityFriendly = true;
        Instant fromDate = Instant.parse("2025-12-01T00:00:00Z");
        int page = 2;
        int size = 10;

        var v1 = new ApplicantJobSummaryView(
                UUID.randomUUID(),
                "Backend Sr",
                "ACME",
                UUID.randomUUID(), // sectorId
                UUID.randomUUID(), // districtId
                "Lima",
                "Lima",
                "Miraflores",
                UUID.randomUUID(), // employmentTypeId
                UUID.randomUUID(), // workModeId
                "S/ 6000",
                true,
                "OPEN",
                Instant.parse("2025-12-10T12:00:00Z"),
                true,   // viewed
                false,  // applied
                "Postúlate a la oferta rápidamente",
                true    // active
        );

        var v2 = new ApplicantJobSummaryView(
                UUID.randomUUID(),
                "QA Jr",
                "ZOE",
                UUID.randomUUID(),
                UUID.randomUUID(),
                "Cusco",
                "Cusco",
                "Wanchaq",
                UUID.randomUUID(),
                UUID.randomUUID(),
                "S/ 2500",
                false,
                "OPEN",
                Instant.parse("2025-12-11T12:00:00Z"),
                false,
                true,
                "Ya te postulaste a esta oferta",
                true
        );

        when(queries.searchForApplicant(
                eq(userId),
                eq(areaId),
                eq(sectorId),
                eq(departmentId),
                eq(provinceId),
                eq(districtId),
                eq(disabilityFriendly),
                eq(fromDate),
                eq(page),
                eq(size)
        )).thenReturn(List.of(v1, v2));

        try (MockedStatic<CurrentUser> mocked = Mockito.mockStatic(CurrentUser.class)) {
            mocked.when(CurrentUser::idOrThrow).thenReturn(userId);

            mvc.perform(get("/api/v1/me/applicant/jobs")
                            .param("areaId", areaId.toString())
                            .param("sectorId", sectorId.toString())
                            .param("departmentId", departmentId.toString())
                            .param("provinceId", provinceId.toString())
                            .param("districtId", districtId.toString())
                            .param("disabilityFriendly", String.valueOf(disabilityFriendly))
                            .param("fromDate", fromDate.toString())
                            .param("page", String.valueOf(page))
                            .param("size", String.valueOf(size))
                            .accept(MediaType.APPLICATION_JSON)
                    )
                    .andExpect(status().isOk())
                    .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                    .andExpect(jsonPath("$.length()").value(2))
                    .andExpect(jsonPath("$[0].title").value("Backend Sr"))
                    .andExpect(jsonPath("$[0].companyName").value("ACME"))
                    .andExpect(jsonPath("$[0].active").value(true))
                    .andExpect(jsonPath("$[0].viewed").value(true))
                    .andExpect(jsonPath("$[0].applied").value(false))
                    .andExpect(jsonPath("$[1].title").value("QA Jr"))
                    .andExpect(jsonPath("$[1].companyName").value("ZOE"))
                    .andExpect(jsonPath("$[1].applied").value(true));
        }

        // verificación de forwarding
        verify(queries).searchForApplicant(
                eq(userId),
                eq(areaId),
                eq(sectorId),
                eq(departmentId),
                eq(provinceId),
                eq(districtId),
                eq(disabilityFriendly),
                eq(fromDate),
                eq(page),
                eq(size)
        );
    }

    @Test
    void searchForApplicant_ok_usesDefaultPaging_whenOmitted() throws Exception {
        UUID userId = UUID.randomUUID();

        when(queries.searchForApplicant(
                eq(userId),
                isNull(), // areaId
                isNull(), // sectorId
                isNull(), // departmentId
                isNull(), // provinceId
                isNull(), // districtId
                isNull(), // disabilityFriendly
                isNull(), // fromDate
                eq(0),    // default page
                eq(20)    // default size
        )).thenReturn(List.of());

        try (MockedStatic<CurrentUser> mocked = Mockito.mockStatic(CurrentUser.class)) {
            mocked.when(CurrentUser::idOrThrow).thenReturn(userId);

            mvc.perform(get("/api/v1/me/applicant/jobs")
                            .accept(MediaType.APPLICATION_JSON)
                    )
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.length()").value(0));
        }

        verify(queries).searchForApplicant(
                eq(userId),
                isNull(), isNull(), isNull(), isNull(), isNull(),
                isNull(), isNull(),
                eq(0), eq(20)
        );
    }

    @Test
    void detailForApplicant_ok_mapsPathVariableAndResponse() throws Exception {
        UUID userId = UUID.randomUUID();
        UUID jobId = UUID.randomUUID();

        var v = new ApplicantJobDetailView(
                jobId,
                UUID.randomUUID(), // companyId
                "Backend Sr",
                "Desc",
                UUID.randomUUID(), // areaId
                UUID.randomUUID(), // sectorId
                UUID.randomUUID(), // districtId
                "Lima",
                "Lima",
                "Miraflores",
                UUID.randomUUID(), // employmentTypeId
                UUID.randomUUID(), // workModeId
                "S/ 6000",
                true,              // disabilityFriendly
                "OPEN",
                Instant.parse("2025-12-10T12:00:00Z"),
                false,             // suspended
                true,              // viewed
                false,             // applied
                "Postúlate a la oferta rápidamente",
                true               // active
        );

        when(queries.getByIdForApplicant(userId, jobId)).thenReturn(v);

        try (MockedStatic<CurrentUser> mocked = Mockito.mockStatic(CurrentUser.class)) {
            mocked.when(CurrentUser::idOrThrow).thenReturn(userId);

            mvc.perform(get("/api/v1/me/applicant/jobs/{jobId}", jobId)
                            .accept(MediaType.APPLICATION_JSON)
                    )
                    .andExpect(status().isOk())
                    .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                    .andExpect(jsonPath("$.id").value(jobId.toString()))
                    .andExpect(jsonPath("$.title").value("Backend Sr"))
                    .andExpect(jsonPath("$.active").value(true))
                    .andExpect(jsonPath("$.viewed").value(true))
                    .andExpect(jsonPath("$.applied").value(false))
                    .andExpect(jsonPath("$.status").value("OPEN"));
        }

        verify(queries).getByIdForApplicant(userId, jobId);
    }

    @Test
    void searchForApplicant_forwardsExactArguments_captorStyle() throws Exception {
        UUID userId = UUID.randomUUID();
        UUID departmentId = UUID.randomUUID();

        when(queries.searchForApplicant(any(), any(), any(), any(), any(), any(), any(), any(), anyInt(), anyInt()))
                .thenReturn(List.of());

        try (MockedStatic<CurrentUser> mocked = Mockito.mockStatic(CurrentUser.class)) {
            mocked.when(CurrentUser::idOrThrow).thenReturn(userId);

            mvc.perform(get("/api/v1/me/applicant/jobs")
                            .param("departmentId", departmentId.toString())
                            .param("page", "1")
                            .param("size", "5")
                            .accept(MediaType.APPLICATION_JSON)
                    )
                    .andExpect(status().isOk());
        }

        ArgumentCaptor<UUID> userCap = ArgumentCaptor.forClass(UUID.class);
        ArgumentCaptor<UUID> depCap = ArgumentCaptor.forClass(UUID.class);
        ArgumentCaptor<Integer> pageCap = ArgumentCaptor.forClass(Integer.class);
        ArgumentCaptor<Integer> sizeCap = ArgumentCaptor.forClass(Integer.class);

        verify(queries).searchForApplicant(
                userCap.capture(),
                isNull(), // areaId
                isNull(), // sectorId
                depCap.capture(),
                isNull(), // provinceId
                isNull(), // districtId
                isNull(), // disabilityFriendly
                isNull(), // fromDate
                pageCap.capture(),
                sizeCap.capture()
        );

        assertEquals(userId, userCap.getValue());
        assertEquals(departmentId, depCap.getValue());
        assertEquals(1, pageCap.getValue());
        assertEquals(5, sizeCap.getValue());
    }
}
