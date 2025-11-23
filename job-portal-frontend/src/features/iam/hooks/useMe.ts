'use client';

import { useQuery } from '@tanstack/react-query';
import { meReq, type MeResponse } from '@/features/iam/api/authClient';

type MeError = {
  status: number;
  data: any;
};

export function useMe() {
  return useQuery<MeResponse, MeError>({
    queryKey: ['auth', 'me'],
    queryFn: async () => {
      const { ok, status, data } = await meReq();
      if (!ok) throw { status, data };
      return data;
    },
    staleTime: 60_000,
    retry: false,
  });
}
