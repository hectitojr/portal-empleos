'use client';

import { useMemo } from 'react';
import { useQuery } from '@tanstack/react-query';
import type { ApiErrorResponse, CompanyJobSummaryResponse } from '@/features/jobs/api/jobsClient';
import { listCompanyJobs } from '@/features/jobs/api/jobsClient';

type ApiError = {
  status: number;
  error: ApiErrorResponse;
};

export function useCompanyJobs(params?: {
  page?: number;
  size?: number;
  q?: string;
  status?: 'OPEN' | 'CLOSED';
  fromDate?: string;
}) {
  const query = useQuery<CompanyJobSummaryResponse[], ApiError>({
    queryKey: ['jobs', 'company', params] as const,
    queryFn: async () => {
      const res = await listCompanyJobs(params);
      if (!res.ok) throw { status: res.status, error: res.error } satisfies ApiError;
      return res.data;
    },
    staleTime: 30_000,
  });

  const data = useMemo(() => query.data ?? [], [query.data]);

  return {
    ...query,
    data,
  };
}
