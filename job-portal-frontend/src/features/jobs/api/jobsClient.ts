import type { Job } from '@/features/home/lib/types';
import type { ApiErrorCode } from '@/lib/errors';

type ApiErrorResponse = {
  code?: ApiErrorCode | string;
  message?: string;
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
// Mapeos a tipo Job (UI)
// -----------------------

function mapSummaryToJob(summary: PublicJobSummaryResponse | ApplicantJobSummaryResponse): Job {
  return {
    id: summary.id,
    title: summary.title,
    company: summary.companyName,
    location: undefined,
    salary: summary.salaryText,
    employmentType: undefined,
    workMode: undefined,
    viewed: summary.viewed,
    quickApply: summary.quickApplyText,
    isActive: summary.active,
    isApplied: summary.applied,
    postedAt: summary.publishedAt,
  };
}

// -----------------------
// API pública (anónima)
// -----------------------

export async function listPublicJobs(params?: {
  page?: number;
  size?: number;
  areaId?: string;
  sectorId?: string;
  districtId?: string;
  disabilityFriendly?: boolean;
  fromDate?: string;
}): Promise<ApiResult<Job[]>> {
  const search = new URLSearchParams();
  if (params?.page != null) search.set('page', String(params.page));
  if (params?.size != null) search.set('size', String(params.size));
  if (params?.areaId) search.set('areaId', params.areaId);
  if (params?.sectorId) search.set('sectorId', params.sectorId);
  if (params?.districtId) search.set('districtId', params.districtId);
  if (params?.disabilityFriendly != null)
    search.set('disabilityFriendly', String(params.disabilityFriendly));
  if (params?.fromDate) search.set('fromDate', params.fromDate);

  const qs = search.toString();
  const res = await fetch(`/api/jobs${qs ? `?${qs}` : ''}`, {
    method: 'GET',
    cache: 'no-store',
  });

  const result = await handleJson<PublicJobSummaryResponse[]>(res);
  if (!result.ok) return result;

  return {
    ok: true,
    data: result.data.map(mapSummaryToJob),
  };
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
// API applicant logueado
// -----------------------

export async function listApplicantJobs(params?: {
  page?: number;
  size?: number;
  areaId?: string;
  sectorId?: string;
  districtId?: string;
  disabilityFriendly?: boolean;
  fromDate?: string;
}): Promise<ApiResult<Job[]>> {
  const search = new URLSearchParams();
  if (params?.page != null) search.set('page', String(params.page));
  if (params?.size != null) search.set('size', String(params.size));
  if (params?.areaId) search.set('areaId', params.areaId);
  if (params?.sectorId) search.set('sectorId', params.sectorId);
  if (params?.districtId) search.set('districtId', params.districtId);
  if (params?.disabilityFriendly != null)
    search.set('disabilityFriendly', String(params.disabilityFriendly));
  if (params?.fromDate) search.set('fromDate', params.fromDate);

  const qs = search.toString();
  const res = await fetch(`/api/me/applicant/jobs${qs ? `?${qs}` : ''}`, {
    method: 'GET',
    cache: 'no-store',
  });

  const result = await handleJson<ApplicantJobSummaryResponse[]>(res);
  if (!result.ok) return result;

  return {
    ok: true,
    data: result.data.map(mapSummaryToJob),
  };
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
