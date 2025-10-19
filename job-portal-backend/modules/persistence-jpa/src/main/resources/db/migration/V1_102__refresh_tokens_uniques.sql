-- Purpose: Company profiles
-- Author: ZOEDATA_LAB | Date: 2025-10-19

-- Unicidad del refresh token para prevenir duplicados
CREATE UNIQUE INDEX IF NOT EXISTS ux_refresh_tokens_token ON refresh_tokens (token);
