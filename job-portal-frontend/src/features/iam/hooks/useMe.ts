'use client';

import { useMemo } from 'react';
import { useQuery } from '@tanstack/react-query';
import { bffFetchOrThrow } from '@/lib/api/bffClient';
import type { MeResponse } from '@/features/iam/api/authClient';

const ME_ENDPOINT = '/api/auth/me';

function isEmployer(me?: MeResponse | null) {
  return me?.role === 'COMPANY';
}

function employerReadyToPublish(me?: MeResponse | null) {
  if (!me || me.role !== 'COMPANY') return false;

  return (
    me.identityCompleted === true &&
    me.employerProfileCompleted === true &&
    me.employerActive === true &&
    me.employerSuspended === false
  );
}

export function useMe() {
  const q = useQuery<MeResponse>({
    queryKey: ['auth', 'me'],
    queryFn: () =>
      bffFetchOrThrow<MeResponse>(ME_ENDPOINT, {
        method: 'GET',
        credentials: 'same-origin',
      }),
    staleTime: 60_000,
    retry: false,
  });

  const me = q.data;

  const derived = useMemo(() => {
    const employer = isEmployer(me);
    const ready = employerReadyToPublish(me);

    return {
      isEmployer: employer,
      employerReadyToPublish: ready,
      needsIdentity: employer && me?.identityCompleted !== true,
      needsEmployerProfile: employer && me?.employerProfileCompleted !== true,
      isEmployerBlocked:
        employer && (me?.employerActive !== true || me?.employerSuspended === true),
    };
  }, [me]);

  return {
    ...q,
    me,
    ...derived,
  };
}
