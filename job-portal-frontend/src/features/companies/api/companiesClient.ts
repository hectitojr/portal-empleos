import { bffFetchOrThrow } from '@/lib/api/bffClient';

export type UUID = string;

export type CompanyMeResponse = {
  id: UUID;
  legalName: string | null;
  taxId: string | null;
  contactEmail: string | null;
  contactPhone: string | null;
  districtId: UUID | null;
  profileComplete: boolean;
  active: boolean;
  suspended: boolean;
};

export type CompanyUpdateRequest = {
  legalName: string | null;
  taxId: string | null;
  contactEmail: string | null;
  contactPhone: string | null;
  districtId: UUID | null;
};

const COMPANY_ME_ENDPOINT = '/api/companies/me';

export function getMyCompany(): Promise<CompanyMeResponse> {
  return bffFetchOrThrow<CompanyMeResponse>(COMPANY_ME_ENDPOINT, { method: 'GET' });
}

export function updateMyCompany(payload: CompanyUpdateRequest): Promise<CompanyMeResponse> {
  return bffFetchOrThrow<CompanyMeResponse>(COMPANY_ME_ENDPOINT, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
  });
}
