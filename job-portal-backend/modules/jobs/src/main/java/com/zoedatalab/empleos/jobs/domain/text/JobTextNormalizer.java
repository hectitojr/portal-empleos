package com.zoedatalab.empleos.jobs.domain.text;

import java.util.Locale;
import java.util.Set;
import java.util.regex.Pattern;

public final class JobTextNormalizer {

    public static final int TITLE_MAX = 120;
    public static final int DESCRIPTION_MAX = 8000;

    private static final Locale LOCALE_ES = Locale.forLanguageTag("es-PE");

    private static final Set<String> LOWERCASE_CONNECTORS = Set.of(
            "a", "al", "con", "de", "del", "desde",
            "e", "el", "en", "entre",
            "la", "las", "lo", "los",
            "o", "para", "por", "sin", "su",
            "u", "un", "una", "unos", "unas",
            "y"
    );

    private static final Set<String> KNOWN_ACRONYMS = Set.of(
            "api", "aws", "b2b", "b2c", "ci", "cd",
            "css", "ddd", "devops", "dns", "etl",
            "git", "grpc", "http", "https", "iam",
            "id", "ip", "it", "jdbc", "jwt",
            "kpi", "ml", "mvc", "nosql", "oauth",
            "oop", "orm", "pos", "qa", "ram",
            "rest", "rpc", "seo", "sla", "sso",
            "sql", "soap", "tcp", "tdd", "tls",
            "ui", "ux", "uuid", "xml", "json"
    );

    /**
     * Abreviaturas conocidas que se normalizan en descripción.
     * Se aplican SOLO a coincidencias exactas, sin heurísticas.
     */
    private static final Set<String> KNOWN_ABBREVIATIONS = Set.of(
            // Títulos profesionales
            "ing.", "lic.", "bach.", "tec.",

            // Salud
            "dr.", "dra.", "enf.",

            // Tratamientos
            "sr.", "sra.", "srta.",

            // Educación / cargos
            "prof.", "dir.", "coord."
    );

    private JobTextNormalizer() {
    }

    // -------------------------
    // TÍTULO
    // -------------------------
    public static String normalizeTitle(String raw) {
        String s = normalizeBase(raw, TITLE_MAX, true);

        String[] words = splitWords(s);
        if (words.length == 0) return s;

        return toConditionalTitleCase(words);
    }

    private static String toConditionalTitleCase(String[] words) {
        StringBuilder out = new StringBuilder();

        for (int i = 0; i < words.length; i++) {
            String w = words[i];
            String lower = w.toLowerCase(LOCALE_ES);

            String mapped;
            if (i > 0 && LOWERCASE_CONNECTORS.contains(lower)) {
                mapped = lower;
            } else {
                mapped = capitalizeTokenPreservingAcronyms(w);
            }

            if (i > 0) out.append(' ');
            out.append(mapped);
        }

        return out.toString();
    }

    private static String capitalizeTokenPreservingAcronyms(String token) {
        String[] slashParts = token.split("/", -1);
        for (int i = 0; i < slashParts.length; i++) {
            slashParts[i] = capitalizeHyphenated(slashParts[i]);
        }
        return String.join("/", slashParts);
    }

    private static String capitalizeHyphenated(String token) {
        String[] parts = token.split("-", -1);
        for (int i = 0; i < parts.length; i++) {
            parts[i] = capitalizeWordPreservingAcronyms(parts[i]);
        }
        return String.join("-", parts);
    }

    private static String capitalizeWordPreservingAcronyms(String word) {
        if (word.isBlank()) return word;

        String lower = word.toLowerCase(LOCALE_ES);

        if (KNOWN_ACRONYMS.contains(lower)) {
            return lower.toUpperCase(LOCALE_ES);
        }

        if (looksLikeShortAcronym(word)) {
            return word.toUpperCase(LOCALE_ES);
        }

        int firstCodePoint = lower.codePointAt(0);
        int firstLen = Character.charCount(firstCodePoint);

        String first = new String(Character.toChars(Character.toUpperCase(firstCodePoint)));
        return first + lower.substring(firstLen);
    }

    private static boolean looksLikeShortAcronym(String word) {
        int len = word.length();
        if (len < 2 || len > 5) return false;

        boolean hasLower = false;
        for (int i = 0; i < len; i++) {
            char c = word.charAt(i);
            if (Character.isLowerCase(c)) hasLower = true;
            if (!(Character.isLetterOrDigit(c))) return false;
        }
        return !hasLower;
    }

    // -------------------------
    // DESCRIPCIÓN
    // -------------------------
    public static String normalizeDescription(String raw) {
        String s = normalizeBase(raw, DESCRIPTION_MAX, false);

        s = normalizeNewlines(s);

        String[] lines = s.split("\n", -1);
        for (int i = 0; i < lines.length; i++) {
            lines[i] = collapseInnerSpaces(lines[i]).trim();
        }
        s = String.join("\n", lines);

        s = s.replaceAll("\n{3,}", "\n\n").trim();

        s = removeSpacesBeforePunctuation(s);

        s = capitalizeSentences(s);

        s = normalizeKnownAbbreviations(s);

        if (!s.isEmpty() && !endsWithSentencePunctuation(s)) {
            s = s + ".";
        }

        if (s.length() > DESCRIPTION_MAX) {
            s = s.substring(0, DESCRIPTION_MAX).trim();
        }

        return s;
    }

    private static String removeSpacesBeforePunctuation(String s) {
        return s.replaceAll("\\s+([\\.,;:!?])", "$1");
    }

    private static String normalizeKnownAbbreviations(String s) {
        for (String abbr : KNOWN_ABBREVIATIONS) {
            String cap = Character.toUpperCase(abbr.charAt(0)) + abbr.substring(1);
            s = s.replaceAll("(?i)\\b" + Pattern.quote(abbr), cap);
        }
        return s;
    }

    private static String capitalizeSentences(String text) {
        StringBuilder result = new StringBuilder(text.length());
        boolean capitalizeNext = true;

        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);

            if (capitalizeNext && Character.isLetter(c)) {
                result.append(Character.toUpperCase(c));
                capitalizeNext = false;
            } else {
                result.append(c);
            }

            if (c == '.' || c == '!' || c == '?') {
                capitalizeNext = true;
            }
            if (c == '\n') {
                capitalizeNext = true;
            }
        }

        return result.toString();
    }

    private static boolean endsWithSentencePunctuation(String s) {
        char last = s.charAt(s.length() - 1);
        return last == '.' || last == '!' || last == '?';
    }

    // -------------------------
    // Base normalization shared
    // -------------------------
    private static String normalizeBase(String raw, int maxLen, boolean collapseAllWhitespace) {
        if (raw == null) return "";

        String s = raw;

        s = s
                .replace('\u00A0', ' ')
                .replace('\u2007', ' ')
                .replace('\u202F', ' ');

        s = s.replaceAll("[\\u200B\\u200C\\u200D\\uFEFF]", " ");

        s = normalizeNewlines(s);

        if (collapseAllWhitespace) {
            s = s.replace('\n', ' ');
            s = collapseInnerSpaces(s).trim();
        } else {
            s = s.trim();
        }

        if (s.length() > maxLen) {
            s = s.substring(0, maxLen).trim();
        }

        return s;
    }

    private static String normalizeNewlines(String s) {
        return s.replace("\r\n", "\n").replace('\r', '\n');
    }

    private static String collapseInnerSpaces(String s) {
        return s.replaceAll("[\\t\\x0B\\f ]{2,}", " ");
    }

    private static String[] splitWords(String s) {
        if (s.isBlank()) return new String[0];
        return s.trim().split("\\s+");
    }
}
