package com.zoedatalab.empleos.iam.domain;

import java.util.Objects;

public final class IdentityDocument {

    private final DocumentType type;
    private final String number;

    private IdentityDocument(DocumentType type, String number) {
        this.type = Objects.requireNonNull(type, "documentType");
        this.number = Objects.requireNonNull(number, "documentNumber");
    }

    public static IdentityDocument of(DocumentType type, String rawNumber) {
        if (rawNumber == null) throw new IllegalArgumentException("DOCUMENT_NUMBER_REQUIRED");

        String normalized = normalize(type, rawNumber);

        if (!isValid(type, normalized)) {
            throw new IllegalArgumentException("DOCUMENT_NUMBER_INVALID");
        }

        return new IdentityDocument(type, normalized);
    }

    private static String normalize(DocumentType type, String raw) {
        String t = raw.trim();
        if (t.isEmpty()) throw new IllegalArgumentException("DOCUMENT_NUMBER_REQUIRED");

        t = t.replaceAll("\\s+", "").toUpperCase();

        if (type == DocumentType.DNI || type == DocumentType.CE) {
            t = t.replaceAll("\\D+", "");
        }

        return t;
    }

    private static boolean isValid(DocumentType type, String normalized) {
        return switch (type) {
            case DNI -> normalized.matches("^\\d{8}$");
            case CE -> normalized.matches("^\\d{9}$");
            case PASSPORT -> normalized.matches("^[A-Z0-9]{6,12}$");
        };
    }

    public DocumentType type() {
        return type;
    }

    public String number() {
        return number;
    }

    public String key() {
        return type.name() + ":" + number;
    }

    @Override
    public String toString() {
        return key();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof IdentityDocument that)) return false;
        return type == that.type && number.equals(that.number);
    }

    @Override
    public int hashCode() {
        return Objects.hash(type, number);
    }
}
