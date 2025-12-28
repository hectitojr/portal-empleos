'use client';

import { useRouter, useSearchParams } from 'next/navigation';
import { useState } from 'react';
import { registerReq, loginReq } from '@/features/iam/api/authClient';
import { humanize } from '@/lib/errors';
import type { ApiErrorCode } from '@/lib/errors';
import { routes } from '@/lib/routes';

type Mode = 'login' | 'register' | 'select-role';
type UserType = 'APPLICANT' | 'COMPANY' | null;

function normalizeUserType(v: string | null): UserType {
  if (!v) return null;
  const up = v.trim().toUpperCase();
  if (up === 'APPLICANT' || up === 'COMPANY') return up;
  return null;
}

function isPublicNext(next: string | null): boolean {
  if (!next) return true;

  return (
    next === routes.public.home ||
    next.startsWith('/auth') ||
    next.startsWith('/jobs') ||
    next.startsWith('/ayuda') ||
    next.startsWith('/contacto') ||
    next.startsWith('/acerca') ||
    next.startsWith('/accesibilidad') ||
    next.startsWith('/terminos')
  );
}

export function useAuthState() {
  const router = useRouter();
  const search = useSearchParams();

  const modeParam = search.get('mode');
  const roleParam = search.get('role');
  const nextParam = search.get('next');

  const next: string | null = nextParam && nextParam.startsWith('/') ? nextParam : null;
  const initialUserType = normalizeUserType(roleParam);

  const initialAuthMode: Mode =
    modeParam === 'register' ? (initialUserType ? 'register' : 'select-role') : 'login';

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
      if (formData.password !== formData.confirmPassword)
        e.confirmPassword = 'Las contraseñas no coinciden';

      if (!formData.acceptTerms) {
        e.acceptTerms = 'Debes aceptar los Términos y Condiciones y la Política de Privacidad.';
      }

      if (!formData.acceptDataPolicy) {
        e.acceptDataPolicy = 'Debes autorizar el tratamiento de tus datos personales.';
      }
    }

    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const applyBackendFieldErrors = (data: any) => {
    const fe = data?.fieldErrors;
    if (!Array.isArray(fe)) return;

    const mapped: Record<string, string> = {};
    for (const item of fe) {
      const field = item?.field as string | undefined;
      const message = item?.message as string | undefined;
      if (field && message) mapped[field] = message;
    }

    if (Object.keys(mapped).length > 0) {
      setErrors((prev) => ({ ...prev, ...mapped }));
    }
  };

  async function submit() {
    if (!validate()) return;

    setLoading(true);
    setApiError(null);

    try {
      if (authMode === 'login') {
        const { ok, data } = await loginReq(formData.email, formData.password);

        if (!ok) {
          const apiCode = (data?.error as string) || undefined;
          setApiError(humanize(apiCode));

          applyBackendFieldErrors(data);

          if (apiCode === 'BAD_CREDENTIALS') {
            setErrors((prev) => ({
              ...prev,
              email: prev.email || 'Revisa tu correo y contraseña.',
              password: prev.password || 'Revisa tu correo y contraseña.',
            }));
          }

          return;
        }

        setSuccess(true);

        setTimeout(() => {
          if (!isPublicNext(next)) {
            router.push(next as any);
          } else {
            router.push(routes.dashboard.me);
          }
        }, 600);

        return;
      }

      const payload = {
        email: formData.email,
        password: formData.password,
        role: userType!,
        acceptTerms: formData.acceptTerms,
        acceptDataPolicy: formData.acceptDataPolicy,
      };

      const { ok, data } = await registerReq(payload);
      if (!ok) {
        const apiCode = data?.error as ApiErrorCode | undefined;
        setApiError(humanize(apiCode));

        if (apiCode === 'EMAIL_EXISTS') {
          setErrors((prev) => ({
            ...prev,
            email: prev.email || 'Este correo ya está registrado.',
          }));
        }

        applyBackendFieldErrors(data);
        return;
      }

      if (!isPublicNext(next)) {
        router.push(next as any);
        return;
      }

      const fallback =
        userType === 'APPLICANT' ? routes.dashboard.applicant.home : routes.dashboard.company.home;

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
