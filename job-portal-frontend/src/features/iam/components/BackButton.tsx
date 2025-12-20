'use client';

import { useCallback, useRef } from 'react';
import { useRouter } from 'next/navigation';
import type { Route } from 'next';
import { ArrowLeft } from 'lucide-react';

type Props = {
  className?: string;
  /** A dónde ir si no hay historial válido */
  fallbackPath?: Route; // default: '/'
  label?: string;       // default: 'Volver'
};

export default function BackButton({
  className = '',
  fallbackPath = '/' as Route,
  label = 'Volver',
}: Props) {
  const router = useRouter();
  const navigating = useRef(false);

  const goBack = useCallback(() => {
    if (navigating.current) return;
    navigating.current = true;

    try {
      const hasHistory = typeof window !== 'undefined' && window.history.length > 1;
      const sameOriginRef =
        typeof document !== 'undefined' &&
        document.referrer &&
        new URL(document.referrer).origin === window.location.origin;

      if (hasHistory || sameOriginRef) {
        router.back();
      } else {
        router.push(fallbackPath);
      }
    } finally {
      setTimeout(() => (navigating.current = false), 400);
    }
  }, [router, fallbackPath]);

  return (
    <button
      type="button"
      onClick={goBack}
      aria-label={label}
      aria-busy={navigating.current || undefined}
      className={`inline-flex items-center gap-2 text-slate-600 hover:text-slate-900 text-sm transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 rounded ${className}`}
    >
      <ArrowLeft className="w-4 h-4" aria-hidden="true" />
      {label}
    </button>
  );
}
