package com.zoedatalab.empleos.api.web.validation;


import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class PeruRucValidatorTest {

    private PeruRucValidator validator;

    @BeforeEach
    void setUp() {
        validator = new PeruRucValidator();
    }

    @Test
    @DisplayName("Debe aceptar null y blank (el requerido lo maneja @NotBlank)")
    void shouldAcceptNullAndBlank() {
        assertTrue(validator.isValid(null, null));
        assertTrue(validator.isValid("", null));
        assertTrue(validator.isValid("   ", null));
    }

    @ParameterizedTest(name = "RUC válido: {0}")
    @ValueSource(strings = {
            "10553393669",
            "20214529204",
            "15904365812",
            "16369398320",
            "17085747266"
    })
    void shouldAcceptValidRucs(String ruc) {
        assertTrue(validator.isValid(ruc, null), "Debe ser válido: " + ruc);
    }

    @ParameterizedTest(name = "Debe rechazar por longitud/formato: {0}")
    @ValueSource(strings = {
            "2012345678",
            "201234567890",
            "20A14529204",
            "20-214529204",
            "2021452920 "
    })
    void shouldRejectInvalidFormatOrLength(String ruc) {
        assertFalse(validator.isValid(ruc, null), "Debe ser inválido: " + ruc);
    }

    @ParameterizedTest(name = "Debe rechazar por prefijo no permitido: {0}")
    @ValueSource(strings = {
            "11214529204", //
            "30214529204", //
            "00214529204"  //
    })
    void shouldRejectInvalidPrefix(String ruc) {
        assertFalse(validator.isValid(ruc, null), "Debe ser inválido: " + ruc);
    }

    @Test
    @DisplayName("Debe rechazar si el checksum es incorrecto (último dígito alterado)")
    void shouldRejectWrongChecksum() {

        assertFalse(validator.isValid("20214529205", null));

        assertFalse(validator.isValid("10553393668", null));
    }

    @Test
    @DisplayName("Debe ser tolerante a espacios (trim) pero seguir validando")
    void shouldTrimAndValidate() {
        assertTrue(validator.isValid(" 20214529204 ", null));
        assertFalse(validator.isValid(" 20214529205 ", null)); // checksum malo
    }
}