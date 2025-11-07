'use client';

import { useRouter } from 'next/navigation';
import { useState } from 'react';

export function useLandingState() {
  const router = useRouter();
  const [searchQuery, setSearchQuery] = useState('');
  const [location, setLocation] = useState('');

  function submit() {
    const params = new URLSearchParams();
    if (searchQuery.trim()) params.set('q', searchQuery.trim());
    if (location.trim()) params.set('loc', location.trim());
    const qs = params.toString();
    router.push(qs ? `/jobs?${qs}` : '/jobs');
  }

  function goAllJobs() {
    router.push('/jobs');
  }

  return {
    searchQuery,
    setSearchQuery,
    location,
    setLocation,
    submit,
    goAllJobs,
  };
}
