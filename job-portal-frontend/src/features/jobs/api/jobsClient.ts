import type { ApiResult, ApiErrorResponse } from '@/lib/api/types';
import { bffFetchResult } from '@/lib/api/bffClient';

export type PublicJobSummaryResponse = {
  id: string;
  title: string;
  companyName: string;
  sectorId: string | null;
  districtId: string | null;
  disabilityFriendly: boolean;
  employmentTypeId: string | null;
  workModeId: string | null;
  salaryText: string | null;
  departmentName: string | null;
  provinceName: string | null;
  districtName: string | null;
  active: boolean;
  applied: boolean;
  viewed: boolean;
  quickApplyText: string;
  status: string;
  publishedAt: string;
};

export type PublicJobDetailResponse = {
  id: string;
  companyId: string;
  title: string;
  description: string;
  areaId: string | null;
  sectorId: string | null;
  districtId: string | null;
  departmentName: string | null;
  provinceName: string | null;
  districtName: string | null;
  disabilityFriendly: boolean;
  employmentTypeId: string | null;
  workModeId: string | null;
  salaryText: string | null;
  status: string;
  publishedAt: string;
};

export type ApplicantJobSummaryResponse = {
  id: string;
  title: string;
  companyName: string;
  sectorId: string | null;
  districtId: string | null;
  departmentName: string | null;
  provinceName: string | null;
  districtName: string | null;
  disabilityFriendly: boolean;
  employmentTypeId: string | null;
  workModeId: string | null;
  salaryText: string | null;
  active: boolean;
  applied: boolean;
  viewed: boolean;
  quickApplyText: string;
  status: string;
  publishedAt: string;
};

export type ApplicantJobDetailResponse = {
  id: string;
  companyId: string;
  title: string;
  description: string;
  areaId: string | null;
  sectorId: string | null;
  districtId: string | null;
  departmentName: string | null;
  provinceName: string | null;
  districtName: string | null;
  disabilityFriendly: boolean;
  employmentTypeId: string | null;
  workModeId: string | null;
  salaryText: string | null;
  active: boolean;
  applied: boolean;
  viewed: boolean;
  quickApplyText: string;
  status: string;
  publishedAt: string;
  suspended: boolean;
};

export type ApplyResponse = {
  id: string;
  jobId: string;
  applicantId: string;
  status: string;
  notes: string | null;
  appliedAt: string;
};

export type CompanyJobDetailResponse = {
  id: string;
  companyId: string;
  title: string;
  description: string;
  areaId: string | null;
  sectorId: string | null;
  districtId: string | null;
  departmentName: string | null;
  provinceName: string | null;
  districtName: string | null;
  disabilityFriendly: boolean;
  employmentTypeId: string | null;
  workModeId: string | null;
  salaryText: string | null;
  status: string;
  publishedAt: string;
};

export type CompanyCreateJobRequest = {
  title: string;
  description: string;
  areaId?: string | null;
  sectorId?: string | null;
  districtId?: string | null;
  disabilityFriendly: boolean;
  employmentTypeId?: string | null;
  workModeId?: string | null;
  salaryMin?: number | null;
  salaryMax?: number | null;
};

export type CompanyUpdateJobRequest = CompanyCreateJobRequest;

export type CompanyJobSummaryResponse = {
  id: string;
  title: string;
  companyName: string;
  sectorId: string | null;
  districtId: string | null;
  disabilityFriendly: boolean;
  employmentTypeId: string | null;
  workModeId: string | null;
  salaryText: string | null;
  provinceName: string | null;
  districtName: string | null;
  active: boolean;
  applied: boolean;
  viewed: boolean;
  quickApplyText: string;
  status: string;
  publishedAt: string;
};

export type { ApiErrorResponse };

function safeNumber(n: unknown): number | null | undefined {
  if (n == null) return n as null | undefined;
  if (typeof n !== 'number') return null;
  return Number.isFinite(n) ? n : null;
}

// -----------------------
// API pública (BFF)
// -----------------------

export async function listPublicJobs(params?: {
  page?: number;
  size?: number;
  areaId?: string;
  sectorId?: string;
  departmentId?: string;
  provinceId?: string;
  districtId?: string;
  disabilityFriendly?: boolean;
  fromDate?: string;
}): Promise<ApiResult<PublicJobSummaryResponse[]>> {
  const search = new URLSearchParams();
  if (params?.page != null) search.set('page', String(params.page));
  if (params?.size != null) search.set('size', String(params.size));
  if (params?.areaId) search.set('areaId', params.areaId);
  if (params?.sectorId) search.set('sectorId', params.sectorId);
  if (params?.departmentId) search.set('departmentId', params.departmentId);
  if (params?.provinceId) search.set('provinceId', params.provinceId);
  if (params?.districtId) search.set('districtId', params.districtId);
  if (params?.disabilityFriendly != null)
    search.set('disabilityFriendly', String(params.disabilityFriendly));
  if (params?.fromDate) search.set('fromDate', params.fromDate);

  const qs = search.toString();
  return bffFetchResult<PublicJobSummaryResponse[]>(`/api/jobs${qs ? `?${qs}` : ''}`, {
    method: 'GET',
  });
}

export async function getPublicJobDetail(
  jobId: string
): Promise<ApiResult<PublicJobDetailResponse>> {
  return bffFetchResult<PublicJobDetailResponse>(`/api/jobs/${jobId}`, { method: 'GET' });
}

// -----------------------
// API applicant (BFF)
// -----------------------

export async function listApplicantJobs(params?: {
  page?: number;
  size?: number;
  areaId?: string;
  sectorId?: string;
  departmentId?: string;
  provinceId?: string;
  districtId?: string;
  disabilityFriendly?: boolean;
  fromDate?: string;
}): Promise<ApiResult<ApplicantJobSummaryResponse[]>> {
  const search = new URLSearchParams();
  if (params?.page != null) search.set('page', String(params.page));
  if (params?.size != null) search.set('size', String(params.size));
  if (params?.areaId) search.set('areaId', params.areaId);
  if (params?.sectorId) search.set('sectorId', params.sectorId);
  if (params?.departmentId) search.set('departmentId', params.departmentId);
  if (params?.provinceId) search.set('provinceId', params.provinceId);
  if (params?.districtId) search.set('districtId', params.districtId);
  if (params?.disabilityFriendly != null)
    search.set('disabilityFriendly', String(params.disabilityFriendly));
  if (params?.fromDate) search.set('fromDate', params.fromDate);

  const qs = search.toString();
  return bffFetchResult<ApplicantJobSummaryResponse[]>(
    `/api/me/applicant/jobs${qs ? `?${qs}` : ''}`,
    { method: 'GET' }
  );
}

export async function getApplicantJobDetail(
  jobId: string
): Promise<ApiResult<ApplicantJobDetailResponse>> {
  return bffFetchResult<ApplicantJobDetailResponse>(`/api/me/applicant/jobs/${jobId}`, {
    method: 'GET',
  });
}

export async function applyToJob(jobId: string, notes?: string): Promise<ApiResult<ApplyResponse>> {
  return bffFetchResult<ApplyResponse>(`/api/jobs/${jobId}/apply`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: notes ? JSON.stringify({ notes }) : null,
  });
}

// -----------------------
// API company (BFF)
// -----------------------

export async function createCompanyJob(
  payload: CompanyCreateJobRequest
): Promise<ApiResult<CompanyJobDetailResponse>> {
  const safePayload: CompanyCreateJobRequest = {
    ...payload,
    salaryMin: safeNumber(payload.salaryMin),
    salaryMax: safeNumber(payload.salaryMax),
  };

  return bffFetchResult<CompanyJobDetailResponse>('/api/company/jobs', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(safePayload),
  });
}

export async function updateCompanyJob(
  jobId: string,
  payload: CompanyUpdateJobRequest
): Promise<ApiResult<CompanyJobDetailResponse>> {
  const safePayload: CompanyUpdateJobRequest = {
    ...payload,
    salaryMin: safeNumber(payload.salaryMin),
    salaryMax: safeNumber(payload.salaryMax),
  };

  return bffFetchResult<CompanyJobDetailResponse>(`/api/company/jobs/${jobId}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(safePayload),
  });
}

export async function closeCompanyJob(jobId: string): Promise<ApiResult<CompanyJobDetailResponse>> {
  return bffFetchResult<CompanyJobDetailResponse>(`/api/company/jobs/${jobId}/close`, {
    method: 'POST',
  });
}

export async function listCompanyJobs(params?: {
  page?: number;
  size?: number;
  q?: string;
  status?: string;
  fromDate?: string;
}): Promise<ApiResult<CompanyJobSummaryResponse[]>> {
  const search = new URLSearchParams();
  if (params?.page != null) search.set('page', String(params.page));
  if (params?.size != null) search.set('size', String(params.size));
  if (params?.q) search.set('q', params.q);
  if (params?.status) search.set('status', params.status);
  if (params?.fromDate) search.set('fromDate', params.fromDate);

  const qs = search.toString();
  return bffFetchResult<CompanyJobSummaryResponse[]>(`/api/company/jobs${qs ? `?${qs}` : ''}`, {
    method: 'GET',
  });
}
