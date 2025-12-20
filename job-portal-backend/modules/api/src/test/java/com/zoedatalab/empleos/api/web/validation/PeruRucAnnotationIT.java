package com.zoedatalab.empleos.api.web.validation;

import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import jakarta.validation.constraints.NotBlank;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class PeruRucAnnotationIT {

    @Test
    void shouldFailWhenRucInvalid() {
        try (ValidatorFactory factory = Validation.buildDefaultValidatorFactory()) {
            Validator validator = factory.getValidator();

            var violations = validator.validate(new Dummy("20214529205")); // checksum malo
            assertFalse(violations.isEmpty());
        }
    }

    @Test
    void shouldPassWhenRucValid() {
        try (ValidatorFactory factory = Validation.buildDefaultValidatorFactory()) {
            Validator validator = factory.getValidator();

            var violations = validator.validate(new Dummy("20214529204"));
            assertTrue(violations.isEmpty());
        }
    }

    record Dummy(
            @NotBlank
            @PeruRuc
            String taxId
    ) {
    }
}
