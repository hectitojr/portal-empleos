'use client';

import { useMutation, useQueryClient } from '@tanstack/react-query';
import { updateMyIdentity, type UpdateMyIdentityRequest } from '@/features/iam/api/iamClient';

export function useUpdateMyIdentity() {
  const qc = useQueryClient();

  return useMutation({
    mutationFn: (payload: UpdateMyIdentityRequest) => updateMyIdentity(payload),
    onSuccess: async () => {
      await qc.invalidateQueries({ queryKey: ['auth', 'me'] });
    },
  });
}
