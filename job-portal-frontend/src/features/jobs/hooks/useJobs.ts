'use client';

import { useEffect } from 'react';
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
} from '@/features/jobs/api/jobsClient';
import type { ApiErrorCode } from '@/lib/errors';

type ApiError = {
  status: number;
  error: {
    code?: ApiErrorCode | string;
    message?: string;
    [key: string]: unknown;
  };
};

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
  return useQuery<Job[], ApiError>({
    queryKey: ['jobs', 'public', params] as const,
    queryFn: async (): Promise<Job[]> => {
      const res = await listPublicJobs(params);
      if (!res.ok) {
        throw { status: res.status, error: res.error } satisfies ApiError;
      }
      return res.data;
    },
    staleTime: 60_000,
  });
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
  return useQuery<Job[], ApiError>({
    queryKey: ['jobs', 'applicant', params] as const,
    queryFn: async (): Promise<Job[]> => {
      const res = await listApplicantJobs(params);
      if (!res.ok) {
        throw { status: res.status, error: res.error } satisfies ApiError;
      }
      return res.data;
    },
    staleTime: 30_000,
  });
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
      // Refrescamos listado y detalle del job postulado
      queryClient.invalidateQueries({ queryKey: ['jobs', 'applicant'] });
      queryClient.invalidateQueries({
        queryKey: ['jobs', 'applicant', 'detail', variables.jobId],
      });
    },
  });
}
