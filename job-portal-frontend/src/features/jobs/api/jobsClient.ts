import type { ApiErrorCode } from '@/lib/errors';

export type ApiErrorResponse = {
  error?: ApiErrorCode | string;
  code?: ApiErrorCode | string;
  message?: string;
  status?: number;
  path?: string;
  timestamp?: string;
  traceId?: string | null;
  fieldErrors?: unknown;
  violations?: unknown;
  [key: string]: unknown;
};

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
  salaryText?: string | null;
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

type ApiResult<T> =
  | { ok: true; data: T }
  | { ok: false; status: number; error: ApiErrorResponse };

async function handleJson<T>(res: Response): Promise<ApiResult<T>> {
  const status = res.status;
  const data = (await res.json().catch(() => ({}))) as any;

  if (!res.ok) {
    return {
      ok: false,
      status,
      error: data as ApiErrorResponse,
    };
  }

  return {
    ok: true,
    data: data as T,
  };
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
  if (params?.disabilityFriendly != null) {
    search.set('disabilityFriendly', String(params.disabilityFriendly));
  }
  if (params?.fromDate) search.set('fromDate', params.fromDate);

  const qs = search.toString();
  const res = await fetch(`/api/jobs${qs ? `?${qs}` : ''}`, {
    method: 'GET',
    cache: 'no-store',
  });

  return handleJson<PublicJobSummaryResponse[]>(res);
}

export async function getPublicJobDetail(
  jobId: string,
): Promise<ApiResult<PublicJobDetailResponse>> {
  const res = await fetch(`/api/jobs/${jobId}`, {
    method: 'GET',
    cache: 'no-store',
  });

  return handleJson<PublicJobDetailResponse>(res);
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
  if (params?.disabilityFriendly != null) {
    search.set('disabilityFriendly', String(params.disabilityFriendly));
  }
  if (params?.fromDate) search.set('fromDate', params.fromDate);

  const qs = search.toString();
  const res = await fetch(`/api/me/applicant/jobs${qs ? `?${qs}` : ''}`, {
    method: 'GET',
    cache: 'no-store',
  });

  return handleJson<ApplicantJobSummaryResponse[]>(res);
}

export async function getApplicantJobDetail(
  jobId: string,
): Promise<ApiResult<ApplicantJobDetailResponse>> {
  const res = await fetch(`/api/me/applicant/jobs/${jobId}`, {
    method: 'GET',
    cache: 'no-store',
  });

  return handleJson<ApplicantJobDetailResponse>(res);
}

export async function applyToJob(
  jobId: string,
  notes?: string,
): Promise<ApiResult<ApplyResponse>> {
  const res = await fetch(`/api/jobs/${jobId}/apply`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    cache: 'no-store',
    body: notes ? JSON.stringify({ notes }) : null,
  });

  return handleJson<ApplyResponse>(res);
}

// -----------------------
// API company (BFF)
// -----------------------

export async function createCompanyJob(
  payload: CompanyCreateJobRequest,
): Promise<ApiResult<CompanyJobDetailResponse>> {
  const res = await fetch('/api/company/jobs', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    cache: 'no-store',
    body: JSON.stringify(payload),
  });

  return handleJson<CompanyJobDetailResponse>(res);
}

export async function updateCompanyJob(
  jobId: string,
  payload: CompanyUpdateJobRequest,
): Promise<ApiResult<CompanyJobDetailResponse>> {
  const res = await fetch(`/api/company/jobs/${jobId}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    cache: 'no-store',
    body: JSON.stringify(payload),
  });

  return handleJson<CompanyJobDetailResponse>(res);
}

export async function closeCompanyJob(
  jobId: string,
): Promise<ApiResult<CompanyJobDetailResponse>> {
  const res = await fetch(`/api/company/jobs/${jobId}/close`, {
    method: 'POST',
    cache: 'no-store',
  });

  return handleJson<CompanyJobDetailResponse>(res);
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
  const res = await fetch(`/api/company/jobs${qs ? `?${qs}` : ''}`, {
    method: 'GET',
    cache: 'no-store',
  });

  return handleJson<CompanyJobSummaryResponse[]>(res);
}
