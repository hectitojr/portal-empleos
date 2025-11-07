'use client';

import { useRouter, useSearchParams } from 'next/navigation';
import { useState } from 'react';
import { registerSchema } from '../lib/schema';
import { loginReq } from '../lib/authClient';
import { humanize } from '@/lib/errors';

type Mode = 'login' | 'register' | 'select-role';
type UserType = 'APPLICANT' | 'COMPANY' | null;

export function useAuthState() {
  const router = useRouter();
  const search = useSearchParams();
  const next = search.get('next') || '/me';

  const [authMode, setAuthMode] = useState<Mode>('login');
  const [userType, setUserType] = useState<UserType>(null);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  const [formData, setFormData] = useState({
    email: '',
    password: '',
    confirmPassword: '',
    fullName: '',
    companyName: '',
    acceptTerms: false,
    acceptDataPolicy: false,
  });

  const [errors, setErrors] = useState<Record<string, string>>({});
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [apiError, setApiError] = useState<string | null>(null);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({ ...prev, [name]: type === 'checkbox' ? checked : value }));
    if (errors[name]) setErrors(prev => ({ ...prev, [name]: '' }));
    if (apiError) setApiError(null);
  };

  const validate = () => {
    const e: Record<string,string> = {};
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!formData.email) e.email = 'El email es requerido';
    else if (!emailRegex.test(formData.email)) e.email = 'Email inválido';

    if (!formData.password) e.password = 'La contraseña es requerida';
    else if (formData.password.length < 8) e.password = 'Mínimo 8 caracteres';

    if (authMode === 'register') {
      if (userType === 'APPLICANT' && !formData.fullName) e.fullName = 'El nombre completo es requerido';
      if (userType === 'COMPANY' && !formData.companyName) e.companyName = 'El nombre de la empresa es requerido';
      if (formData.password !== formData.confirmPassword) e.confirmPassword = 'Las contraseñas no coinciden';
      if (!formData.acceptTerms) e.acceptTerms = 'Debes aceptar los términos y condiciones';
      if (!formData.acceptDataPolicy) e.acceptDataPolicy = 'Debes autorizar el tratamiento de tus datos personales';
    }

    setErrors(e);
    return Object.keys(e).length === 0;
  };

  async function submit() {
    if (!validate()) return;
    setLoading(true);
    setApiError(null);

    if (authMode === 'login') {
      const { ok, data } = await loginReq(formData.email, formData.password);
      if (!ok) {
        setApiError(humanize((data?.code as string) || undefined));
        setLoading(false);
        return;
      }
      setSuccess(true);
      setTimeout(() => router.push(next), 600);
      return;
    }

    // fake flow de registro (lista para integrar con backend)
    setTimeout(() => {
      setSuccess(true);
      setLoading(false);
      setTimeout(() => {
        setSuccess(false);
        setAuthMode('login');
        setUserType(null);
        setFormData({
          email: '', password: '', confirmPassword: '',
          fullName: '', companyName: '',
          acceptTerms: false, acceptDataPolicy: false,
        });
      }, 1000);
    }, 600);
  }

  return {
    authMode, setAuthMode,
    userType, setUserType,
    formData, setFormData, handleInputChange,
    showPassword, setShowPassword,
    showConfirmPassword, setShowConfirmPassword,
    errors, loading, success, apiError,
    submit,
  };
}
