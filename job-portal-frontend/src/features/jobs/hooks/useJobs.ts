'use client';

import { useEffect, useMemo } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import type { Job } from '@/features/home/lib/types';
import {
  listPublicJobs,
  listApplicantJobs,
  getPublicJobDetail,
  getApplicantJobDetail,
  applyToJob,
  type PublicJobDetailResponse,
  type ApplicantJobDetailResponse,
  type ApplyResponse,
  type PublicJobSummaryResponse,
  type ApplicantJobSummaryResponse,
} from '@/features/jobs/api/jobsClient';
import type { ApiErrorCode } from '@/lib/errors';
import { useJobCatalogs } from '@/features/catalogs/hooks/useCatalogs';

type ApiError = {
  status: number;
  error: {
    code?: ApiErrorCode | string;
    message?: string;
    [key: string]: unknown;
  };
};

// -----------------------
// Mapeo DTO → Job (UI)
// -----------------------

function mapSummaryToJob(
  summary: PublicJobSummaryResponse | ApplicantJobSummaryResponse,
  catalogs: ReturnType<typeof useJobCatalogs>,
): Job {
  const district = summary.districtId
    ? catalogs.districtsById[summary.districtId]
    : undefined;

  const employmentType = summary.employmentTypeId
    ? catalogs.employmentTypesById[summary.employmentTypeId]
    : undefined;

  const workMode = summary.workModeId
    ? catalogs.workModesById[summary.workModeId]
    : undefined;

  return {
    id: summary.id,
    title: summary.title,
    company: summary.companyName,

    location: district?.name ?? '',
    salary: summary.salaryText ?? '',

    employmentType: employmentType?.name ?? '',
    workMode: workMode?.name ?? '',

    viewed: summary.viewed,
    quickApply: summary.quickApplyText,
    isActive: summary.active,
    isApplied: summary.applied,
    postedAt: summary.publishedAt,
  };
}

// -----------------------
// Listados
// -----------------------

export function usePublicJobs(params?: {
  page?: number;
  size?: number;
  areaId?: string;
  sectorId?: string;
  districtId?: string;
  disabilityFriendly?: boolean;
  fromDate?: string;
}) {
  const catalogs = useJobCatalogs();

  const query = useQuery<PublicJobSummaryResponse[], ApiError>({
    queryKey: ['jobs', 'public', params] as const,
    queryFn: async (): Promise<PublicJobSummaryResponse[]> => {
      const res = await listPublicJobs(params);
      if (!res.ok) {
        throw { status: res.status, error: res.error } satisfies ApiError;
      }
      return res.data;
    },
    staleTime: 60_000,
  });

  const jobs: Job[] = useMemo(() => {
    if (!query.data) return [];
    return query.data.map((summary) => mapSummaryToJob(summary, catalogs));
  }, [query.data, catalogs]);

  return {
    ...query,
    data: jobs,
  };
}

export function useApplicantJobs(params?: {
  page?: number;
  size?: number;
  areaId?: string;
  sectorId?: string;
  districtId?: string;
  disabilityFriendly?: boolean;
  fromDate?: string;
}) {
  const catalogs = useJobCatalogs();

  const query = useQuery<ApplicantJobSummaryResponse[], ApiError>({
    queryKey: ['jobs', 'applicant', params] as const,
    queryFn: async (): Promise<ApplicantJobSummaryResponse[]> => {
      const res = await listApplicantJobs(params);
      if (!res.ok) {
        throw { status: res.status, error: res.error } satisfies ApiError;
      }
      return res.data;
    },
    staleTime: 30_000,
  });

  const jobs: Job[] = useMemo(() => {
    if (!query.data) return [];
    return query.data.map((summary) => mapSummaryToJob(summary, catalogs));
  }, [query.data, catalogs]);

  return {
    ...query,
    data: jobs,
  };
}

// -----------------------
// Detalle (public/applicant)
// -----------------------

export function usePublicJobDetail(jobId: string | null) {
  return useQuery<PublicJobDetailResponse, ApiError>({
    queryKey: ['jobs', 'public', 'detail', jobId] as const,
    enabled: !!jobId,
    queryFn: async (): Promise<PublicJobDetailResponse> => {
      if (!jobId) {
        throw new Error('jobId is required to fetch public job detail');
      }

      const res = await getPublicJobDetail(jobId);
      if (!res.ok) {
        throw { status: res.status, error: res.error } satisfies ApiError;
      }
      return res.data;
    },
    staleTime: 60_000,
  });
}

export function useApplicantJobDetail(jobId: string | null) {
  const queryClient = useQueryClient();

  const queryResult = useQuery<ApplicantJobDetailResponse, ApiError>({
    queryKey: ['jobs', 'applicant', 'detail', jobId] as const,
    enabled: !!jobId,
    queryFn: async (): Promise<ApplicantJobDetailResponse> => {
      if (!jobId) {
        throw new Error('jobId is required to fetch applicant job detail');
      }

      const res = await getApplicantJobDetail(jobId);
      if (!res.ok) {
        throw { status: res.status, error: res.error } satisfies ApiError;
      }
      return res.data;
    },
    staleTime: 30_000,
  });

  useEffect(() => {
    if (!jobId) return;
    if (queryResult.status !== 'success') return;

    queryClient.invalidateQueries({ queryKey: ['jobs', 'applicant'] });
  }, [jobId, queryResult.status, queryClient]);

  return queryResult;
}

// -----------------------
// Postular a una oferta
// -----------------------

type ApplyToJobVariables = {
  jobId: string;
  notes?: string;
};

export function useApplyToJob() {
  const queryClient = useQueryClient();

  return useMutation<ApplyResponse, ApiError, ApplyToJobVariables>({
    mutationFn: async ({ jobId, notes }) => {
      const res = await applyToJob(jobId, notes);
      if (!res.ok) {
        throw { status: res.status, error: res.error } satisfies ApiError;
      }
      return res.data;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['jobs', 'applicant'] });
      queryClient.invalidateQueries({
        queryKey: ['jobs', 'applicant', 'detail', variables.jobId],
      });
    },
  });
}
