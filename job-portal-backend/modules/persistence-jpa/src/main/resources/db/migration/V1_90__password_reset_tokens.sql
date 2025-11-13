-- File: V1_90__password_reset_tokens.sql
-- Title: Password Reset Tokens (selector + verifier hash)
-- Purpose: Soporte real para recuperación y restablecimiento de contraseñas (forgot/reset).
-- Author: ZOEDATA_LAB | Date: 2025-11-11

CREATE TABLE password_reset_tokens (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  selector      TEXT NOT NULL UNIQUE,        -- Parte pública del enlace (no sensible)
  verifier_hash TEXT NOT NULL,               -- Hash del token de verificación (no se almacena en claro)
  expires_at    TIMESTAMPTZ NOT NULL,        -- Tiempo de expiración del enlace
  used          BOOLEAN NOT NULL DEFAULT FALSE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX ix_password_reset_tokens__user ON password_reset_tokens(user_id);
CREATE UNIQUE INDEX ux_password_reset_tokens__selector ON password_reset_tokens(selector);

CREATE TRIGGER trg_password_reset_tokens__updated_at
  BEFORE UPDATE ON password_reset_tokens
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMENT ON TABLE password_reset_tokens IS 'Tokens de restablecimiento de contraseña (selector/verifier, uso único).';

