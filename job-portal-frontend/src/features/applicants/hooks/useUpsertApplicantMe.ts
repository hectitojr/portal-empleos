'use client';

import { useMutation, useQueryClient } from '@tanstack/react-query';
import { upsertMyApplicant, type ApplicantUpsertRequest } from '@/features/applicants/api/applicantsClient';

export function useUpsertApplicantMe() {
  const qc = useQueryClient();

  return useMutation({
    mutationFn: (payload: ApplicantUpsertRequest) => upsertMyApplicant(payload),
    onSuccess: async () => {
      await qc.invalidateQueries({ queryKey: ['applicant', 'me'] });
    },
  });
}
