'use client';

import { useEffect, useRef, useState } from 'react';
import { cn } from '@/lib/cn';

type Tone = 'success' | 'error' | 'warn' | 'info';

type Props = {
  message: string | null;
  tone: Tone;
  autoDismissMs?: number;
  animateMs?: number;
  dismissOnUserAction?: boolean;
  onClear: () => void;
};

export default function FlashBanner({
  message,
  tone,
  autoDismissMs = 3500,
  animateMs = 250,
  onClear,
}: Props) {
  const [visible, setVisible] = useState(false);
  const hideTimerRef = useRef<number | null>(null);
  const cleanupTimerRef = useRef<number | null>(null);

  useEffect(() => {
    if (hideTimerRef.current) window.clearTimeout(hideTimerRef.current);
    if (cleanupTimerRef.current) window.clearTimeout(cleanupTimerRef.current);

    if (!message) {
      setVisible(false);
      return;
    }

    setVisible(true);

    hideTimerRef.current = window.setTimeout(() => {
      setVisible(false);
      cleanupTimerRef.current = window.setTimeout(() => {
        onClear();
      }, animateMs);
    }, autoDismissMs);

    return () => {
      if (hideTimerRef.current) window.clearTimeout(hideTimerRef.current);
      if (cleanupTimerRef.current) window.clearTimeout(cleanupTimerRef.current);
    };
  }, [message, autoDismissMs, animateMs, onClear]);

  if (!message) return null;

  const toneCls =
    tone === 'success'
      ? 'border-emerald-200 bg-emerald-50 text-emerald-900'
      : tone === 'error'
        ? 'border-red-200 bg-red-50 text-red-900'
        : tone === 'warn'
          ? 'border-amber-200 bg-amber-50 text-amber-900'
          : 'border-slate-200 bg-slate-50 text-slate-900';

  return (
    <div
      aria-live="polite"
      className={cn(
        'mb-4 overflow-hidden rounded-2xl border transition-all ease-out',
        toneCls,
        visible ? 'opacity-100 translate-y-0' : 'opacity-0 -translate-y-1 pointer-events-none'
      )}
      style={{ transitionDuration: `${animateMs}ms` }}
    >
      <div className="p-4 flex items-start justify-between gap-3">
        <p className="text-sm font-semibold">{message}</p>

        <button
          type="button"
          onClick={() => {
            setVisible(false);
            cleanupTimerRef.current = window.setTimeout(() => onClear(), animateMs);
          }}
          className="rounded-xl px-2 py-1 text-xs font-semibold hover:bg-black/5 transition"
          aria-label="Cerrar mensaje"
        >
          Cerrar
        </button>
      </div>
    </div>
  );
}
