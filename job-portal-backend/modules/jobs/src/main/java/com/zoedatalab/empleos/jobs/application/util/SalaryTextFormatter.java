package com.zoedatalab.empleos.jobs.application.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

public final class SalaryTextFormatter {

    private static final DecimalFormat MONEY;

    static {
        var sym = new DecimalFormatSymbols(Locale.US);
        sym.setGroupingSeparator(',');
        sym.setDecimalSeparator('.');
        MONEY = new DecimalFormat("#,##0.##", sym);
        MONEY.setRoundingMode(RoundingMode.HALF_UP);
    }

    private SalaryTextFormatter() {
    }

    public static String toPenText(BigDecimal min, BigDecimal max) {
        if (min == null && max == null) {
            return null;
        }

        if (min == null) {
            throw new IllegalArgumentException("salaryMin is required when salaryMax is provided");
        }

        if (min.signum() < 0) {
            throw new IllegalArgumentException("salaryMin must be >= 0");
        }

        if (max != null) {
            if (max.signum() < 0) {
                throw new IllegalArgumentException("salaryMax must be >= 0");
            }
            if (max.compareTo(min) < 0) {
                throw new IllegalArgumentException("salaryMax must be >= salaryMin");
            }
        }

        if (max == null || min.compareTo(max) == 0) {
            return "S/ " + MONEY.format(min);
        }

        return "S/ " + MONEY.format(min) + " - S/ " + MONEY.format(max);
    }

}
