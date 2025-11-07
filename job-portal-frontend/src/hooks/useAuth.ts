'use client';
import { useEffect, useState } from 'react';

export function useAuth() {
  const [ready, setReady] = useState(false);
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  useEffect(() => {
    fetch('/api/auth/refresh', { method: 'POST' })
      .then((r) => setIsAuthenticated(r.ok))
      .finally(() => setReady(true));
  }, []);

  return { ready, isAuthenticated };
}
