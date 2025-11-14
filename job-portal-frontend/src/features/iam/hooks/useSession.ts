'use client';
import { useEffect, useState } from 'react';

export function useSession() {
  const [ready, setReady] = useState(false);
  const [authenticated, setAuthenticated] = useState(false);

  useEffect(() => {
    fetch('/api/auth/refresh', { method: 'POST' })
      .then(r => setAuthenticated(r.ok))
      .finally(() => setReady(true));
  }, []);

  return { ready, authenticated };
}
