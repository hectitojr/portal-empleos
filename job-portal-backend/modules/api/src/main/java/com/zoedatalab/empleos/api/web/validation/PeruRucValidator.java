package com.zoedatalab.empleos.api.web.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.util.Set;

public class PeruRucValidator implements ConstraintValidator<PeruRuc, String> {

    private static final Set<String> ALLOWED_PREFIXES = Set.of("10", "15", "16", "17", "20");

    @Override
    public boolean isValid(String value, ConstraintValidatorContext ctx) {
        if (value == null) return true;

        String ruc = value.trim();
        if (ruc.isEmpty()) return true;

        if (!ruc.matches("^\\d{11}$")) return false;

        String prefix = ruc.substring(0, 2);
        if (!ALLOWED_PREFIXES.contains(prefix)) return false;

        return isValidModulo11(ruc);
    }

    private boolean isValidModulo11(String ruc) {
        int[] weights = {5, 4, 3, 2, 7, 6, 5, 4, 3, 2};

        int sum = 0;
        for (int i = 0; i < 10; i++) {
            int digit = ruc.charAt(i) - '0';
            sum += digit * weights[i];
        }

        int remainder = sum % 11;
        int check = 11 - remainder;
        if (check == 10) check = 0;
        if (check == 11) check = 1;

        int lastDigit = ruc.charAt(10) - '0';
        return lastDigit == check;
    }
}
