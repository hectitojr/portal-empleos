-- File: V1_10__iam.sql
-- Title: IAM core (users, refresh_tokens)
-- Purpose: Usuarios y tokens de sesión.
-- Author: ZOEDATA_LAB | Date: 2025-10-19

CREATE TABLE users (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email        public.citext NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  role         TEXT NOT NULL CHECK (role IN ('APPLICANT','COMPANY','ADMIN')),
  active       BOOLEAN NOT NULL DEFAULT TRUE,
  suspended    BOOLEAN NOT NULL DEFAULT FALSE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by   UUID NULL,
  updated_by   UUID NULL
);
CREATE INDEX ix_users__role      ON users(role);
CREATE INDEX ix_users__active    ON users(active);
CREATE INDEX ix_users__suspended ON users(suspended);
CREATE TRIGGER trg_users__updated_at
  BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMENT ON TABLE users IS 'Cuentas del sistema (no perfiles).';
COMMENT ON COLUMN users.email IS 'CITEXT único; *login principal*.';

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
-- Unicidad de token para prevenir duplicados (consolidado aquí)
CREATE UNIQUE INDEX ux_refresh_tokens__token ON refresh_tokens(token);

COMMENT ON TABLE refresh_tokens IS 'Tokens de refresco para sesiones persistentes.';
