'use client';

import { useMemo, useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useQueryClient } from '@tanstack/react-query';
import type { Route } from 'next';

import { loginReq, registerReq } from '@/features/iam/api/authClient';
import { routes } from '@/lib/routes';
import { getErrorCode, humanize } from '@/lib/errors';

type Mode = 'login' | 'register' | 'select-role';
type UserType = 'APPLICANT' | 'COMPANY' | null;

function normalizeUserType(v: string | null): UserType {
  if (!v) return null;
  const up = v.trim().toUpperCase();
  return up === 'APPLICANT' || up === 'COMPANY' ? up : null;
}

function toSafePublicNext(next: string | null): Route {
  if (!next || !next.startsWith('/')) return routes.public.home;

  const isAllowed =
    next === routes.public.home ||
    next === routes.public.login ||
    next === routes.public.register ||
    next.startsWith('/auth') ||
    next.startsWith('/jobs') ||
    next === routes.public.help ||
    next === routes.public.contact ||
    next === routes.public.about ||
    next === routes.public.accessibility ||
    next === routes.public.terms;

  return (isAllowed ? next : routes.public.home) as Route;
}

function applyBackendFieldErrors(data: any): Record<string, string> {
  const fe = data?.fieldErrors;
  if (!Array.isArray(fe)) return {};

  const mapped: Record<string, string> = {};
  for (const item of fe) {
    const field = item?.field as string | undefined;
    const message = item?.message as string | undefined;
    if (field && message) mapped[field] = message;
  }
  return mapped;
}

export function useAuthState() {
  const router = useRouter();
  const search = useSearchParams();
  const qc = useQueryClient();

  const modeParam = search.get('mode');
  const roleParam = search.get('role');
  const nextParam = search.get('next');

  const initialUserType = normalizeUserType(roleParam);

  const initialAuthMode: Mode =
    modeParam === 'register'
      ? initialUserType
        ? 'register'
        : 'select-role'
      : 'login';

  const safeNext = useMemo(() => toSafePublicNext(nextParam), [nextParam]);

  const [authMode, setAuthMode] = useState<Mode>(initialAuthMode);
  const [userType, setUserType] = useState<UserType>(initialUserType);

  const [formData, setFormData] = useState({
    email: '',
    password: '',
    confirmPassword: '',
    acceptTerms: false,
    acceptDataPolicy: false,
  });

  const [errors, setErrors] = useState<Record<string, string>>({});
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [apiError, setApiError] = useState<string | null>(null);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value, type, checked } = e.target;

    setFormData((prev) => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value,
    }));

    if (errors[name]) setErrors((prev) => ({ ...prev, [name]: '' }));
    if (apiError) setApiError(null);
  };

  const validate = () => {
    const e: Record<string, string> = {};
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!formData.email) e.email = 'El email es requerido';
    else if (!emailRegex.test(formData.email)) e.email = 'Email inválido';

    if (!formData.password) e.password = 'La contraseña es requerida';
    else if (formData.password.length < 8) e.password = 'Mínimo 8 caracteres';

    if (authMode === 'register') {
      if (!userType) e.userType = 'Debes seleccionar un tipo de usuario';
      if (formData.password !== formData.confirmPassword) {
        e.confirmPassword = 'Las contraseñas no coinciden';
      }
      if (!formData.acceptTerms) {
        e.acceptTerms =
          'Debes aceptar los Términos y Condiciones y la Política de Privacidad.';
      }
      if (!formData.acceptDataPolicy) {
        e.acceptDataPolicy =
          'Debes autorizar el tratamiento de tus datos personales.';
      }
    }

    setErrors(e);
    return Object.keys(e).length === 0;
  };

  async function submit() {
    if (!validate()) return;

    setLoading(true);
    setApiError(null);
    setErrors((prev) => prev);

    try {
      if (authMode === 'login') {
        const res = await loginReq(formData.email, formData.password);

        if (!res.ok) {
          const code = getErrorCode(res.error) ?? res.error?.error ?? res.status;
          setApiError(humanize(String(code)));

          const fe = applyBackendFieldErrors(res.error);
          if (Object.keys(fe).length > 0) {
            setErrors((prev) => ({ ...prev, ...fe }));
          }

          if (String(code) === 'BAD_CREDENTIALS') {
            setErrors((prev) => ({
              ...prev,
              email: prev.email || 'Revisa tu correo y contraseña.',
              password: prev.password || 'Revisa tu correo y contraseña.',
            }));
          }
          return;
        }

        setSuccess(true);
        await qc.invalidateQueries({ queryKey: ['auth', 'me'] });
        router.push(safeNext ?? routes.dashboard.me);
        return;
      }

      const payload = {
        email: formData.email,
        password: formData.password,
        role: userType!,
        acceptTerms: formData.acceptTerms,
        acceptDataPolicy: formData.acceptDataPolicy,
      };

      const res = await registerReq(payload);

      if (!res.ok) {
        const code = getErrorCode(res.error) ?? res.error?.error ?? res.status;
        setApiError(humanize(String(code)));

        const fe = applyBackendFieldErrors(res.error);
        if (Object.keys(fe).length > 0) {
          setErrors((prev) => ({ ...prev, ...fe }));
        }

        if (String(code) === 'EMAIL_EXISTS') {
          setErrors((prev) => ({
            ...prev,
            email: prev.email || 'Este correo ya está registrado.',
          }));
        }
        return;
      }

      setSuccess(true);
      await qc.invalidateQueries({ queryKey: ['auth', 'me'] });

      if (
        safeNext &&
        safeNext !== routes.public.home &&
        safeNext !== routes.public.login &&
        safeNext !== routes.public.register
      ) {
        router.push(safeNext);
        return;
      }

      const fallback =
        userType === 'APPLICANT'
          ? routes.dashboard.applicant.home
          : routes.dashboard.company.home;

      router.push(fallback);
    } finally {
      setLoading(false);
    }
  }

  return {
    authMode,
    setAuthMode,
    userType,
    setUserType,
    formData,
    setFormData,
    handleInputChange,
    errors,
    loading,
    success,
    apiError,
    submit,
  };
}
