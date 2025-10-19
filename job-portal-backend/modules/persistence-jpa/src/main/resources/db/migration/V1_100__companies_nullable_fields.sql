-- Purpose: Company profiles
-- Author: ZOEDATA_LAB | Date: 2025-10-10

-- Permitir compañías “provisionadas” con perfil incompleto
ALTER TABLE companies
    ALTER COLUMN legal_name DROP NOT NULL,
    ALTER COLUMN contact_email DROP NOT NULL;

