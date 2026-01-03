-- File: V1_90__password_reset_tokens.sql
-- Title: Password Reset Tokens (selector + verifier hash)
-- Purpose: Recuperación y restablecimiento de contraseñas.
-- Author: ZOEDATA_LAB

SET search_path TO job_portal, public;

CREATE TABLE password_reset_tokens (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  selector      TEXT NOT NULL UNIQUE,
  verifier_hash TEXT NOT NULL,
  expires_at    TIMESTAMPTZ NOT NULL,
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
