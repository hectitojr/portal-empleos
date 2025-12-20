'use client';

import { useMutation } from '@tanstack/react-query';
import {
  closeCompanyJob,
  createCompanyJob,
  updateCompanyJob,
  type CompanyCreateJobRequest,
  type CompanyUpdateJobRequest,
} from '@/features/jobs/api/jobsClient';

type ApiErrorResponse = unknown;

type ApiError = {
  status: number;
  error: ApiErrorResponse;
};

function unwrap<T>(r: { ok: true; data: T } | { ok: false; status: number; error: ApiErrorResponse }): T {
  if (!r.ok) throw { status: r.status, error: r.error } satisfies ApiError;
  return r.data;
}

export function useCreateCompanyJob() {
  return useMutation({
    mutationFn: async (payload: CompanyCreateJobRequest) => {
      const res = await createCompanyJob(payload);
      return unwrap(res);
    },
  });
}

export function useUpdateCompanyJob(jobId: string) {
  return useMutation({
    mutationFn: async (payload: CompanyUpdateJobRequest) => {
      const res = await updateCompanyJob(jobId, payload);
      return unwrap(res);
    },
  });
}

export function useCloseCompanyJob(jobId: string) {
  return useMutation({
    mutationFn: async () => {
      const res = await closeCompanyJob(jobId);
      return unwrap(res);
    },
  });
}
