'use client';

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useRef,
  useState,
} from 'react';

type GuardState = {
  enabled: boolean;
  message: string;

  onConfirmLeave: () => void;
  onCancelLeave: () => void;
  onOpenConfirm: () => void;
};

type NavigationGuardApi = {
  setGuard: (next: GuardState) => void;
  clearGuard: () => void;
  pingOpenConfirm: () => void;
  consumePendingNavigate: () => void;
  clearPendingNavigate: () => void;
  setPendingNavigate: (fn: () => void) => void;
  isDirty: () => boolean;
  getMessage: () => string;
  confirmLeave: () => void;
  cancelLeave: () => void;
};

const NavigationGuardContext = createContext<NavigationGuardApi | null>(null);

export function useNavigationGuard() {
  const ctx = useContext(NavigationGuardContext);
  if (!ctx) throw new Error('useNavigationGuard must be used within NavigationGuardProvider');
  return ctx;
}

export default function NavigationGuardProvider({ children }: { children: React.ReactNode }) {
  const guardRef = useRef<GuardState>({
    enabled: false,
    message: 'Tienes cambios sin guardar.',
    onConfirmLeave: () => {},
    onCancelLeave: () => {},
    onOpenConfirm: () => {},
  });

  const pendingNavigateRef = useRef<null | (() => void)>(null);
  const [dirtyPing, setDirtyPing] = useState(0);

  const setGuard = useCallback((next: GuardState) => {
    guardRef.current = next;
  }, []);

  const clearGuard = useCallback(() => {
    guardRef.current = {
      enabled: false,
      message: 'Tienes cambios sin guardar.',
      onConfirmLeave: () => {},
      onCancelLeave: () => {},
      onOpenConfirm: () => {},
    };
    pendingNavigateRef.current = null;
  }, []);

  const isDirty = useCallback(() => guardRef.current.enabled, []);
  const getMessage = useCallback(() => guardRef.current.message, []);

  const setPendingNavigate = useCallback((fn: () => void) => {
    pendingNavigateRef.current = fn;
  }, []);

  const clearPendingNavigate = useCallback(() => {
    pendingNavigateRef.current = null;
  }, []);

  const consumePendingNavigate = useCallback(() => {
    const fn = pendingNavigateRef.current;
    pendingNavigateRef.current = null;
    fn?.();
  }, []);

  const pingOpenConfirm = useCallback(() => {
    setDirtyPing((x) => x + 1);
    guardRef.current.onOpenConfirm();
  }, []);

  const confirmLeave = useCallback(() => {
    guardRef.current.onConfirmLeave();
    consumePendingNavigate();
  }, [consumePendingNavigate]);

  const cancelLeave = useCallback(() => {
    guardRef.current.onCancelLeave();
    clearPendingNavigate();
  }, [clearPendingNavigate]);

  useEffect(() => {
    const onBeforeUnload = (e: BeforeUnloadEvent) => {
      if (!guardRef.current.enabled) return;

      e.preventDefault();
      // @ts-ignore - returnValue está deprecado pero aún es necesario para compatibilidad entre navegadores
      e.returnValue = guardRef.current.message;
      return guardRef.current.message;
    };

    window.addEventListener('beforeunload', onBeforeUnload);
    return () => window.removeEventListener('beforeunload', onBeforeUnload);
  }, []);

  useEffect(() => {
    try {
      window.history.replaceState({ __jp_guard: true }, '', window.location.href);
    } catch {}

    const onPopState = () => {
      if (!guardRef.current.enabled) return;

      try {
        window.history.pushState({ __jp_guard: true }, '', window.location.href);
      } catch {}

      setPendingNavigate(() => window.history.back());
      pingOpenConfirm();
    };

    window.addEventListener('popstate', onPopState);
    return () => window.removeEventListener('popstate', onPopState);
  }, [pingOpenConfirm, setPendingNavigate]);

  useEffect(() => {
    const onDocumentClickCapture = (e: MouseEvent) => {
      if (!guardRef.current.enabled) return;
      if (e.defaultPrevented) return;
      if (e.button !== 0) return;
      if (e.metaKey || e.ctrlKey || e.shiftKey || e.altKey) return;

      const target = e.target as HTMLElement | null;
      if (!target) return;

      const anchor = target.closest('a');
      if (!anchor) return;

      const href = anchor.getAttribute('href');
      if (!href) return;

      if (href.startsWith('#') || href.startsWith('mailto:') || href.startsWith('tel:')) return;
      if (anchor.getAttribute('target') === '_blank') return;

      const isAbsolute = /^https?:\/\//i.test(href);
      if (isAbsolute) return;

      e.preventDefault();
      e.stopPropagation();

      setPendingNavigate(() => window.location.assign(href));
      pingOpenConfirm();
    };

    document.addEventListener('click', onDocumentClickCapture, true);
    return () => document.removeEventListener('click', onDocumentClickCapture, true);
  }, [pingOpenConfirm, setPendingNavigate]);

  const api = useMemo<NavigationGuardApi>(() => {
    return {
      setGuard,
      clearGuard,
      pingOpenConfirm,
      setPendingNavigate,
      consumePendingNavigate,
      clearPendingNavigate,
      isDirty,
      getMessage,
      confirmLeave,
      cancelLeave,
    };
  }, [
    setGuard,
    clearGuard,
    pingOpenConfirm,
    setPendingNavigate,
    consumePendingNavigate,
    clearPendingNavigate,
    isDirty,
    getMessage,
    confirmLeave,
    cancelLeave,
  ]);

  void dirtyPing;

  return <NavigationGuardContext.Provider value={api}>{children}</NavigationGuardContext.Provider>;
}
