'use client';

import { useEffect, useRef } from 'react';

export function useDismissOnDirty(args: {
  isDirty: boolean;
  active: boolean;     
  animateMs?: number;
  onHide: () => void;  
  onClear: () => void; 
}) {
  const { isDirty, active, animateMs = 250, onHide, onClear } = args;
  const cleanupRef = useRef<number | null>(null);

  useEffect(() => {
    if (!active) return;
    if (!isDirty) return;

    onHide();
    if (cleanupRef.current) window.clearTimeout(cleanupRef.current);
    cleanupRef.current = window.setTimeout(() => onClear(), animateMs);

    return () => {
      if (cleanupRef.current) window.clearTimeout(cleanupRef.current);
    };
  }, [active, isDirty, animateMs, onHide, onClear]);
}
