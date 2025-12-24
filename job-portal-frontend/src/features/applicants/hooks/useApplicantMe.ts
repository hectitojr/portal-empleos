'use client';

import { useQuery } from '@tanstack/react-query';
import { getMyApplicant } from '@/features/applicants/api/applicantsClient';

export function useApplicantMe() {
  return useQuery({
    queryKey: ['applicant', 'me'],
    queryFn: getMyApplicant,
    staleTime: 30_000,
  });
}
