-- File: V1_95__user_consents.sql
-- Title: User consents
-- Purpose: Trazabilidad de aceptación de términos y tratamiento de datos personales.
-- Author: ZOEDATA_LAB | Date: 2025-11-16

ALTER TABLE users
  ADD COLUMN terms_accepted_at   TIMESTAMPTZ NULL,
  ADD COLUMN privacy_accepted_at TIMESTAMPTZ NULL;

COMMENT ON COLUMN users.terms_accepted_at IS
  'Fecha/hora en que el usuario aceptó Términos y Condiciones y la Política de Privacidad.';

COMMENT ON COLUMN users.privacy_accepted_at IS
  'Fecha/hora en que el usuario autorizó el tratamiento de sus datos personales.';
