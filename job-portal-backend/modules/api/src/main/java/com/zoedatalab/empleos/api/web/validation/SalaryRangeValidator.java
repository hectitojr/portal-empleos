package com.zoedatalab.empleos.api.web.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.lang.reflect.Method;
import java.math.BigDecimal;

public class SalaryRangeValidator implements ConstraintValidator<ValidSalaryRange, Object> {

    private static BigDecimal invokeBigDecimalAccessor(Object target, String accessorName) {
        try {
            Method m = target.getClass().getMethod(accessorName);
            Object out = m.invoke(target);
            if (out == null) return null;
            if (out instanceof BigDecimal bd) return bd;
            return null;
        } catch (ReflectiveOperationException e) {
            return null;
        }
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext ctx) {
        if (value == null) return true;

        BigDecimal min = invokeBigDecimalAccessor(value, "salaryMin");
        BigDecimal max = invokeBigDecimalAccessor(value, "salaryMax");

        if (min == null || max == null) return true;

        if (max.compareTo(min) >= 0) return true;

        ctx.disableDefaultConstraintViolation();
        ctx.buildConstraintViolationWithTemplate(
                "El salario máximo debe ser mayor o igual al salario mínimo."
        ).addPropertyNode("salaryMax").addConstraintViolation();

        return false;
    }
}
