'use client';

import { useMemo } from 'react';
import { useQuery } from '@tanstack/react-query';
import type { ApiErrorResponse } from '@/lib/api/types';
import type { CompanyJobSummaryResponse } from '@/features/jobs/api/jobsClient';
import { listCompanyJobs } from '@/features/jobs/api/jobsClient';

export type ApiResultError = {
  status: number;
  error: ApiErrorResponse | null;
  bodyText?: string;
  traceId?: string | null;
};

export function useCompanyJobs(params?: {
  page?: number;
  size?: number;
  q?: string;
  status?: 'OPEN' | 'CLOSED';
  fromDate?: string;
}) {
  const query = useQuery<CompanyJobSummaryResponse[], ApiResultError>({
    queryKey: ['jobs', 'company', params] as const,
    queryFn: async () => {
      const res = await listCompanyJobs(params);
      if (!res.ok) {
        throw {
          status: res.status,
          error: res.error,
          bodyText: res.bodyText,
          traceId: res.traceId,
        } satisfies ApiResultError;
      }
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
