package com.zoedatalab.empleos.api.web.controller.applications;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.dto.applications.ApplyRequest;
import com.zoedatalab.empleos.api.web.dto.applications.UpdateStatusRequest;
import com.zoedatalab.empleos.api.web.exception.GlobalExceptionHandler;
import com.zoedatalab.empleos.applications.application.dto.ApplicationView;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationCommandService;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationQueryService;
import com.zoedatalab.empleos.applications.domain.Application;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Slice WebMvcTest: controller + GlobalExceptionHandler.
 * Servicios mockeados y filtros de seguridad deshabilitados para evitar JWT/CSRF.
 */
@WebMvcTest(controllers = ApplicationController.class)
@AutoConfigureMockMvc(addFilters = false)
@Import({ GlobalExceptionHandler.class, ApplicationControllerTest.MethodSecurityTestConfig.class })
class ApplicationControllerTest {

    @TestConfiguration
    @EnableMethodSecurity
    static class MethodSecurityTestConfig {
    }

    @Autowired MockMvc mvc;
    @Autowired ObjectMapper om;

    @MockitoBean ApplicationCommandService cmd;
    @MockitoBean ApplicationQueryService qry;

    @Test
    @WithMockUser(roles = "APPLICANT")
    void post_apply_ok() throws Exception {
        UUID userId = UUID.randomUUID();
        UUID jobId = UUID.randomUUID();

        try (MockedStatic<CurrentUser> mocked = mockStatic(CurrentUser.class)) {
            mocked.when(CurrentUser::idOrThrow).thenReturn(userId);

            var view = new ApplicationView(
                    UUID.randomUUID(), jobId, UUID.randomUUID(),
                    Application.Status.APPLIED, "n", Instant.now()
            );
            when(cmd.apply(eq(userId), eq(jobId), any())).thenReturn(view);

            var body = new ApplyRequest("n");

            mvc.perform(post("/api/v1/jobs/{jobId}/applications", jobId)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(om.writeValueAsString(body)))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("APPLIED"))
                    .andExpect(jsonPath("$.jobId").value(jobId.toString()));
        }
    }

    @Test
    @WithMockUser(roles = "APPLICANT")
    void get_me_ok() throws Exception {
        UUID userId = UUID.randomUUID();

        try (MockedStatic<CurrentUser> mocked = mockStatic(CurrentUser.class)) {
            mocked.when(CurrentUser::idOrThrow).thenReturn(userId);

            var v = new ApplicationView(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID(),
                    Application.Status.APPLIED, null, Instant.now());
            when(qry.myApplications(eq(userId), anyInt(), anyInt())).thenReturn(List.of(v));

            mvc.perform(get("/api/v1/applications/me"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$[0].status").value("APPLIED"));
        }
    }

    @Test
    @WithMockUser(roles = "COMPANY")
    void get_job_applications_ok() throws Exception {
        UUID userId = UUID.randomUUID();
        UUID jobId = UUID.randomUUID();

        try (MockedStatic<CurrentUser> mocked = mockStatic(CurrentUser.class)) {
            mocked.when(CurrentUser::idOrThrow).thenReturn(userId);

            var v = new ApplicationView(UUID.randomUUID(), jobId, UUID.randomUUID(),
                    Application.Status.APPLIED, null, Instant.now());
            when(qry.listForJob(eq(userId), eq(jobId), anyInt(), anyInt())).thenReturn(List.of(v));

            mvc.perform(get("/api/v1/jobs/{jobId}/applications", jobId))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$[0].jobId").value(jobId.toString()));
        }
    }

    @Test
    @WithMockUser(roles = "COMPANY")
    void patch_update_status_ok() throws Exception {
        UUID userId = UUID.randomUUID();
        UUID id = UUID.randomUUID();

        try (MockedStatic<CurrentUser> mocked = mockStatic(CurrentUser.class)) {
            mocked.when(CurrentUser::idOrThrow).thenReturn(userId);

            var view = new ApplicationView(id, UUID.randomUUID(), UUID.randomUUID(),
                    Application.Status.IN_REVIEW, null, Instant.now());
            when(cmd.updateStatus(eq(userId), eq(id), any())).thenReturn(view);

            var req = new UpdateStatusRequest(Application.Status.IN_REVIEW);

            mvc.perform(patch("/api/v1/applications/{id}/status", id)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(om.writeValueAsString(req)))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.status").value("IN_REVIEW"))
                    .andExpect(jsonPath("$.id").value(id.toString()));
        }
    }

    // 403: autenticado pero con rol incorrecto
    @Test
    @WithMockUser(roles = "COMPANY") // NO APPLICANT
    void apply_requires_role_applicant() throws Exception {
        UUID jobId = UUID.randomUUID();
        mvc.perform(post("/api/v1/jobs/{jobId}/applications", jobId))
                .andExpect(status().isForbidden()); // 403
    }

    @Test
    @WithMockUser(roles = "APPLICANT") // NO COMPANY
    void list_requires_role_company() throws Exception {
        UUID jobId = UUID.randomUUID();
        mvc.perform(get("/api/v1/jobs/{jobId}/applications", jobId))
                .andExpect(status().isForbidden()); // 403
    }

    // 401: sin autenticación
    @Test
    void apply_unauthenticated_returns_401() throws Exception {
        UUID jobId = UUID.randomUUID();
        mvc.perform(post("/api/v1/jobs/{jobId}/applications", jobId))
                .andExpect(status().isUnauthorized()); // 401
    }

    @Test
    void list_unauthenticated_returns_401() throws Exception {
        UUID jobId = UUID.randomUUID();
        mvc.perform(get("/api/v1/jobs/{jobId}/applications", jobId))
                .andExpect(status().isUnauthorized()); // 401
    }

}
