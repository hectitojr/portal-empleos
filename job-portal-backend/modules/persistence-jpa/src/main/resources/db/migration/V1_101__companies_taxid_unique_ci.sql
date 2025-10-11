-- Purpose: Company profiles
-- Author: ZOEDATA_LAB | Date: 2025-10-11

-- Unicidad case-insensitive de tax_id, permitiendo múltiples NULLs
CREATE UNIQUE INDEX IF NOT EXISTS ux_companies_taxid_ci
ON companies (lower(tax_id))
WHERE tax_id IS NOT NULL;