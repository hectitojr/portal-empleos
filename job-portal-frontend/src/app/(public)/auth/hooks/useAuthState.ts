'use client';

import { useRouter, useSearchParams } from 'next/navigation';
import { useState } from 'react';
import { registerReq, loginReq } from '../lib/authClient';
import { humanize } from '@/lib/errors';

type Mode = 'login' | 'register' | 'select-role';
type UserType = 'APPLICANT' | 'COMPANY' | null;

export function useAuthState() {
  const router = useRouter();
  const search = useSearchParams();
  const next = search.get('next') || '/me';

  const [authMode, setAuthMode] = useState<Mode>('login');
  const [userType, setUserType] = useState<UserType>(null);

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
    setFormData((prev) => ({ ...prev, [name]: type === 'checkbox' ? checked : value }));
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
      if (!formData.acceptTerms) e.acceptTerms = 'Debes aceptar los términos y condiciones';
      if (!formData.acceptDataPolicy)
        e.acceptDataPolicy = 'Debes autorizar el tratamiento de tus datos personales';
    }

    setErrors(e);
    return Object.keys(e).length === 0;
  };

  async function submit() {
    if (!validate()) return;

    setLoading(true);
    setApiError(null);

    try {
      if (authMode === 'login') {
        const { ok, data } = await loginReq(formData.email, formData.password);
        if (!ok) {
          setApiError(humanize((data?.code as string) || undefined));
          return;
        }
        setSuccess(true);
        setTimeout(() => router.push(next), 600);
        return;
      }

      // === REGISTRO REAL === (sin nombre/empresa; eso va en el onboarding)
      const payload = {
        email: formData.email,
        password: formData.password,
        role: userType!, // validado en validate()
      };

      const { ok, data } = await registerReq(payload);
      if (!ok) {
        setApiError(humanize((data?.code as string) || undefined));
        return;
      }

      // Redirige al onboarding por rol
      router.push(
        userType === 'APPLICANT'
          ? '/me/applicant/profile/setup'
          : '/me/company/profile/setup'
      );
    } finally {
      setLoading(false);
    }
  }

  return {
    authMode, setAuthMode,
    userType, setUserType,
    formData, setFormData, handleInputChange,
    errors, loading, success, apiError,
    submit,
  };
}
