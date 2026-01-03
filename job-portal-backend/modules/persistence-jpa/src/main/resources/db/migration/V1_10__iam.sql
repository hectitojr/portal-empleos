-- File: V1_10__iam.sql
-- Title: IAM core (users, refresh_tokens)
-- Purpose: Usuarios y tokens de sesión.
-- Author: ZOEDATA_LAB

SET search_path TO job_portal, public;

CREATE TABLE users (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email               public.citext NOT NULL UNIQUE,
  password_hash       TEXT NOT NULL,
  role                TEXT NOT NULL CHECK (role IN ('APPLICANT','COMPANY','ADMIN')),
  active              BOOLEAN NOT NULL DEFAULT TRUE,
  suspended           BOOLEAN NOT NULL DEFAULT FALSE,
  document_type       TEXT NULL,
  document_number     TEXT NULL,
  terms_accepted_at   TIMESTAMPTZ NULL,
  privacy_accepted_at TIMESTAMPTZ NULL,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by          UUID NULL,
  updated_by          UUID NULL,

  CONSTRAINT chk_users__document_type
    CHECK (document_type IS NULL OR document_type IN ('DNI','CE','PASSPORT')),

  CONSTRAINT chk_users__document_pair
    CHECK (
      (document_type IS NULL AND document_number IS NULL)
      OR
      (
        document_type IS NOT NULL
        AND document_number IS NOT NULL
        AND btrim(document_number) <> ''
      )
    ),

  CONSTRAINT chk_users__document_normalized_not_empty
    CHECK (
      (document_type IS NULL AND document_number IS NULL)
      OR
      (
        document_type IN ('DNI','CE')
        AND length(regexp_replace(upper(btrim(document_number)), E'\\D+', '', 'g')) > 0
      )
      OR
      (
        document_type = 'PASSPORT'
        AND length(regexp_replace(upper(btrim(document_number)), E'\\s+', '', 'g')) > 0
      )
    )
);

CREATE INDEX ix_users__role      ON users(role);
CREATE INDEX ix_users__active    ON users(active);
CREATE INDEX ix_users__suspended ON users(suspended);

CREATE INDEX ix_users__document_type
  ON users (document_type)
  WHERE document_type IS NOT NULL;

CREATE UNIQUE INDEX ux_users__document_key_ci
  ON users (
    (
      lower(document_type) || ':' ||
      CASE
        WHEN document_type IN ('DNI','CE')
          THEN regexp_replace(upper(btrim(document_number)), E'\\D+', '', 'g')
        ELSE regexp_replace(upper(btrim(document_number)), E'\\s+', '', 'g')
      END
    )
  )
  WHERE document_type IS NOT NULL AND document_number IS NOT NULL;

CREATE TRIGGER trg_users__updated_at
  BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMENT ON TABLE users IS 'Cuentas del sistema (no perfiles).';
COMMENT ON COLUMN users.email IS 'CITEXT único; login principal.';
COMMENT ON COLUMN users.document_type IS 'Tipo de documento (DNI, CE, PASSPORT). Identidad transversal opcional.';
COMMENT ON COLUMN users.document_number IS 'Número de documento. Requiere document_type cuando existe.';
COMMENT ON COLUMN users.terms_accepted_at IS
  'Fecha/hora en que el usuario aceptó Términos y Condiciones y la Política de Privacidad.';
COMMENT ON COLUMN users.privacy_accepted_at IS
  'Fecha/hora en que el usuario autorizó el tratamiento de sus datos personales.';

CREATE TABLE refresh_tokens (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token      TEXT NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  revoked    BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX ix_refresh_tokens__user    ON refresh_tokens(user_id);
CREATE INDEX ix_refresh_tokens__expires ON refresh_tokens(expires_at);
CREATE UNIQUE INDEX ux_refresh_tokens__token ON refresh_tokens(token);

COMMENT ON TABLE refresh_tokens IS 'Tokens de refresco para sesiones persistentes.';