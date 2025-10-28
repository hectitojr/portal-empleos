package com.zoedatalab.empleos.applications.domain;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ApplicationTest {

    @Test
    void moveTo_allowsTransition_whenNotFinal() {
        var a = Application.builder()
                .status(Application.Status.APPLIED)
                .build();

        a.moveTo(Application.Status.IN_REVIEW);
        assertEquals(Application.Status.IN_REVIEW, a.getStatus());

        a.moveTo(Application.Status.SHORTLISTED);
        assertEquals(Application.Status.SHORTLISTED, a.getStatus());
    }

    @Test
    void moveTo_throws_whenAlreadyHired() {
        var a = Application.builder()
                .status(Application.Status.HIRED)
                .build();

        var ex = assertThrows(IllegalStateException.class,
                () -> a.moveTo(Application.Status.REJECTED));
        assertEquals("APPLICATION_FINALIZED", ex.getMessage());
    }

    @Test
    void moveTo_throws_whenAlreadyRejected() {
        var a = Application.builder()
                .status(Application.Status.REJECTED)
                .build();

        var ex = assertThrows(IllegalStateException.class,
                () -> a.moveTo(Application.Status.IN_REVIEW));
        assertEquals("APPLICATION_FINALIZED", ex.getMessage());
    }
}