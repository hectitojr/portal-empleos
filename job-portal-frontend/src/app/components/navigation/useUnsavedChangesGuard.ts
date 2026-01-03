'use client';

import { useEffect, useRef } from 'react';
import { useNavigationGuard } from './NavigationGuardProvider';

type Args = {
  enabled: boolean;
  message: string;
  onOpenConfirm: () => void;
  onConfirmLeave: () => void | Promise<void>;
  onCancelLeave: () => void | Promise<void>;
};

export function useUnsavedChangesGuard(args: Args) {
  const guard = useNavigationGuard();

  // Mantén siempre la última versión de args sin disparar efectos por identidad de funciones
  const latestRef = useRef<Args>(args);
  latestRef.current = args;

  useEffect(() => {
    // Registramos SIEMPRE el guard (handlers estables via ref)
    guard.setGuard({
      enabled: latestRef.current.enabled,
      message: latestRef.current.message,

      onOpenConfirm: () => {
        latestRef.current.onOpenConfirm();
      },

      onConfirmLeave: async () => {
        await latestRef.current.onConfirmLeave();
      },

      onCancelLeave: async () => {
        await latestRef.current.onCancelLeave();
      },
    });

    // Si ya no hay cambios, apaga el guard y limpia navegación pendiente
    // (importante: NO usar clearGuard porque también borra handlers y puede
    // romper el flujo en medio de un confirm)
    if (!latestRef.current.enabled) {
      guard.setGuard({
        enabled: false,
        message: latestRef.current.message || 'Tienes cambios sin guardar.',
        onOpenConfirm: () => {},
        onConfirmLeave: () => {},
        onCancelLeave: () => {},
      });
      guard.clearPendingNavigate();
    }

    return () => {
      // Al desmontar: solo desactiva y limpia pending; no llames clearGuard()
      guard.setGuard({
        enabled: false,
        message: 'Tienes cambios sin guardar.',
        onOpenConfirm: () => {},
        onConfirmLeave: () => {},
        onCancelLeave: () => {},
      });
      guard.clearPendingNavigate();
    };
    // Solo depende de enabled/message para actualizar flags y texto.
  }, [guard, args.enabled, args.message]);
}
