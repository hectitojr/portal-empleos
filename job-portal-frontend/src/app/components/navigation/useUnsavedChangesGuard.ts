'use client';

import { useEffect } from 'react';
import { useNavigationGuard } from './NavigationGuardProvider';

export function useUnsavedChangesGuard(args: {
  enabled: boolean;
  message: string;
  onOpenConfirm: () => void;   
  onConfirmLeave: () => void;  
  onCancelLeave: () => void;  
}) {
  const guard = useNavigationGuard();
  const { enabled, message, onOpenConfirm, onConfirmLeave, onCancelLeave } = args;

  useEffect(() => {
    if (!enabled) {
      guard.clearGuard();
      return;
    }

    guard.setGuard({
      enabled: true,
      message,
      onOpenConfirm,
      onConfirmLeave,
      onCancelLeave,
    });

    return () => {
      guard.clearGuard();
    };
  }, [enabled, message, onOpenConfirm, onConfirmLeave, onCancelLeave, guard]);
}
