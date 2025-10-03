-- Purpose: Enable CITEXT extension (case-insensitive text) used for emails/usernames
-- Author: ZOEDATA_LAB | Date: 2025-09-29

-- Instalamos la extensión en el esquema PUBLIC y de forma idempotente
CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;

-- Nota: en tus DDL usa el tipo calificado para evitar depender del search_path:
--   public.citext
