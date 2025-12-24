package com.zoedatalab.empleos.api.web.catalogs.controller;

import com.zoedatalab.empleos.catalogs.application.dto.CatalogItemView;
import com.zoedatalab.empleos.catalogs.application.ports.in.CatalogQueryService;
import com.zoedatalab.empleos.catalogs.application.ports.in.GeoCatalogQueryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;
import java.util.UUID;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(CatalogController.class)
class CatalogControllerTest {

    @Autowired
    MockMvc mvc;

    @MockitoBean
    CatalogQueryService catalogs;

    @MockitoBean
    GeoCatalogQueryService geo;

    @Test
    @WithMockUser
    void shouldReturnDisabilityTypes() throws Exception {
        var id = UUID.fromString("7f8a0c0d-58f6-4d7b-9c1e-1f0d8d2f4c01");

        when(catalogs.getDisabilityTypes()).thenReturn(List.of(
                new CatalogItemView(id, "Visual", true)
        ));

        mvc.perform(get("/api/v1/catalogs/disability-types"))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith("application/json"))
                .andExpect(jsonPath("$[0].id").value(id.toString()))
                .andExpect(jsonPath("$[0].name").value("Visual"))
                .andExpect(jsonPath("$[0].active").value(true));
    }
}

