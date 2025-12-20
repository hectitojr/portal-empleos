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

async function fetchJson<T>(input: RequestInfo, init?: RequestInit): Promise<T> {
  const res = await fetch(input, init);
  if (!res.ok) {
    const text = await res.text().catch(() => '');
    const err: any = new Error('Request failed');
    err.status = res.status;
    err.body = text;
    throw err;
  }
  return res.json();
}

export function getMyCompany(): Promise<CompanyMeResponse> {
  return fetchJson<CompanyMeResponse>(COMPANY_ME_ENDPOINT, { method: 'GET' });
}

export function updateMyCompany(payload: CompanyUpdateRequest): Promise<CompanyMeResponse> {
  return fetchJson<CompanyMeResponse>(COMPANY_ME_ENDPOINT, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
  });
}
