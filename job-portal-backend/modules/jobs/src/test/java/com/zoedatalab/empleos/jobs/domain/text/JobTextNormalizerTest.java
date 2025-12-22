package com.zoedatalab.empleos.jobs.domain.text;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class JobTextNormalizerTest {

    // -------------------------
    // TÍTULO
    // -------------------------

    @Test
    void normalizeTitle_null_returnsEmpty() {
        assertEquals("", JobTextNormalizer.normalizeTitle(null));
    }

    @Test
    void normalizeTitle_trims_andCollapsesSpaces() {
        assertEquals("Backend Java", JobTextNormalizer.normalizeTitle("   backend   java   "));
    }

    @Test
    void normalizeTitle_removesInvisibleCharacters_zeroWidth_andNbspVariants() {
        String input = "\u200Bbackend\u00A0java\u202Fen\u200Dmicroservicios\uFEFF";
        assertEquals("Backend Java en Microservicios", JobTextNormalizer.normalizeTitle(input));
    }

    @Test
    void normalizeTitle_appliesTitleCaseAlways() {
        assertEquals("Backend Java en Microservicios",
                JobTextNormalizer.normalizeTitle("backend java en microservicios"));
    }

    @Test
    void normalizeTitle_connectorsLowercase_exceptFirstWord() {
        assertEquals("Backend Java en Microservicios",
                JobTextNormalizer.normalizeTitle("backend java EN microservicios"));
    }

    @Test
    void normalizeTitle_firstWordConnector_isCapitalized() {
        assertEquals("En Backend Java",
                JobTextNormalizer.normalizeTitle("en backend java"));
    }

    @Test
    void normalizeTitle_preservesShortAcronyms() {
        assertEquals("Backend Java con SQL y AWS",
                JobTextNormalizer.normalizeTitle("backend java con sql y aws"));
    }

    @Test
    void normalizeTitle_handlesHyphenatedWords() {
        assertEquals("Full-Stack Java Developer",
                JobTextNormalizer.normalizeTitle("full-stack java developer"));
    }

    @Test
    void normalizeTitle_handlesSlashSeparatedTokens_andAcronyms() {
        assertEquals("QA/SQL Engineer",
                JobTextNormalizer.normalizeTitle("qa/sql engineer"));
    }

    @Test
    void normalizeTitle_normalizesNewlines_toSpaces() {
        assertEquals("Backend Java en Microservicios",
                JobTextNormalizer.normalizeTitle("backend java\r\nen microservicios"));
    }

    @Test
    void normalizeTitle_enforcesMaxLength() {
        String input = "a".repeat(JobTextNormalizer.TITLE_MAX + 50);
        String out = JobTextNormalizer.normalizeTitle(input);
        assertEquals(JobTextNormalizer.TITLE_MAX, out.length());
    }

    // -------------------------
    // DESCRIPCIÓN
    // -------------------------

    @Test
    void normalizeDescription_null_returnsEmpty() {
        assertEquals("", JobTextNormalizer.normalizeDescription(null));
    }

    @Test
    void normalizeDescription_trims_andCleansPerLine_preservingNewlines() {
        String input = "   linea   uno   \n   linea   dos   ";
        String expected = "Linea uno\nLinea dos.";
        assertEquals(expected, JobTextNormalizer.normalizeDescription(input));
    }

    @Test
    void normalizeDescription_collapsesExcessiveBlankLines_toMaxOneEmptyLine() {
        String input = "linea 1\n\n\n\nlinea 2";
        String expected = "Linea 1\n\nLinea 2.";
        assertEquals(expected, JobTextNormalizer.normalizeDescription(input));
    }

    @Test
    void normalizeDescription_normalizesWindowsAndOldMacNewlines() {
        String input = "linea 1\r\nlinea 2\rlinea 3";
        String expected = "Linea 1\nLinea 2\nLinea 3.";
        assertEquals(expected, JobTextNormalizer.normalizeDescription(input));
    }

    @Test
    void normalizeDescription_capitalizesFirstLetter_andAddsFinalPeriod() {
        String input = "se busca experto desarrollador java backend";
        String expected = "Se busca experto desarrollador java backend.";
        assertEquals(expected, JobTextNormalizer.normalizeDescription(input));
    }

    @Test
    void normalizeDescription_capitalizesAfterPeriod_followingSpace() {
        String input = "se busca experto. desarrollador java backend.";
        String expected = "Se busca experto. Desarrollador java backend.";
        assertEquals(expected, JobTextNormalizer.normalizeDescription(input));
    }

    @Test
    void normalizeDescription_capitalizesAfterPeriod_followingNewLine() {
        String input = "se busca experto.\ndesarrollador java backend.";
        String expected = "Se busca experto.\nDesarrollador java backend.";
        assertEquals(expected, JobTextNormalizer.normalizeDescription(input));
    }

    @Test
    void normalizeDescription_capitalizesAfterQuestionAndExclamation() {
        String input = "buscas trabajo? aplica ya! buen sueldo";
        String expected = "Buscas trabajo? Aplica ya! Buen sueldo.";
        assertEquals(expected, JobTextNormalizer.normalizeDescription(input));
    }

    @Test
    void normalizeDescription_doesNotAddExtraPeriod_ifAlreadyEndsWithPunctuation() {
        assertEquals("Hola mundo!", JobTextNormalizer.normalizeDescription("hola mundo!"));
        assertEquals("Hola mundo?", JobTextNormalizer.normalizeDescription("hola mundo?"));
        assertEquals("Hola mundo.", JobTextNormalizer.normalizeDescription("hola mundo."));
    }

    @Test
    void normalizeDescription_removesInvisibleCharacters_andCleansSpaces() {
        String input = "\u200Bse\u00A0busca\u202Fexperto\u200D.\n\uFEFFdesarrollador   java";
        String expected = "Se busca experto.\nDesarrollador java.";
        assertEquals(expected, JobTextNormalizer.normalizeDescription(input));
    }

    @Test
    void normalizeDescription_enforcesMaxLength_afterAllProcessing() {
        String input = "a".repeat(JobTextNormalizer.DESCRIPTION_MAX + 200);
        String out = JobTextNormalizer.normalizeDescription(input);
        assertEquals(JobTextNormalizer.DESCRIPTION_MAX, out.length());
    }
    
    @Test
    void normalizeDescription_emptyAfterTrim_remainsEmpty_noPeriodAdded() {
        assertEquals("", JobTextNormalizer.normalizeDescription("   \n  \n  "));
    }

    @Test
    void normalizeTitle_emptyAfterTrim_remainsEmpty() {
        assertEquals("", JobTextNormalizer.normalizeTitle("   \n  "));
    }
}
