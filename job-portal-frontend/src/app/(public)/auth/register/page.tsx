'use client';

import { useState } from 'react';
import { registerSchema, type RegisterSchema } from '@/features/iam/schemas/auth.schema';
import { registerReq } from '@/features/iam/api/authClient';
import { humanize } from '@/lib/errors';
import BackButton from '@/features/iam/components/BackButton';
import AuthHeader from '@/features/iam/components/AuthHeader';

type Role = 'APPLICANT' | 'COMPANY';

export default function RegisterPage() {
  const [form, setForm] = useState<RegisterSchema>({
    email: '',
    password: '',
    role: 'APPLICANT',
    acceptTerms: false,
    acceptDataPolicy: false,
  });

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [ok, setOk] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    setOk(false);

    const parsed = registerSchema.safeParse(form);
    if (!parsed.success) {
      setError('Revisa los campos (email, contraseña, tipo de cuenta) y acepta los términos y la política.');
      return;
    }

    setLoading(true);

    const payload = {
      email: form.email,
      password: form.password,
      role: form.role,
    };

    const { ok, data } = await registerReq(payload);
    if (!ok) setError(humanize((data?.code as string) || undefined));
    else setOk(true);

    setLoading(false);
  }

  return (
    <section
      role="region"
      aria-label="Registro"
      className="min-h-[calc(100vh-4rem)] flex items-center justify-center p-4 sm:p-6 lg:p-8"
    >
      <div className="w-full max-w-md mx-auto">
        <AuthHeader title="Crear cuenta" subtitle="Completa tus datos para registrarte" />

        <form onSubmit={onSubmit} className="bg-white rounded-2xl shadow-xl p-6 sm:p-8 space-y-4" noValidate>
          {/* Email */}
          <div className="space-y-1">
            <label htmlFor="reg-email" className="text-sm font-medium text-slate-700">Correo</label>
            <input
              id="reg-email"
              name="email"
              type="email"
              autoComplete="email"
              className="w-full rounded-xl border border-slate-300 p-3 focus-visible:ring-2 focus-visible:ring-blue-500 outline-none"
              value={form.email}
              onChange={(e) => setForm({ ...form, email: e.target.value })}
              aria-invalid={!!error || undefined}
            />
          </div>

          {/* Password */}
          <div className="space-y-1">
            <label htmlFor="reg-pass" className="text-sm font-medium text-slate-700">Contraseña</label>
            <input
              id="reg-pass"
              name="password"
              type="password"
              autoComplete="new-password"
              className="w-full rounded-xl border border-slate-300 p-3 focus-visible:ring-2 focus-visible:ring-blue-500 outline-none"
              value={form.password}
              onChange={(e) => setForm({ ...form, password: e.target.value })}
              aria-invalid={!!error || undefined}
            />
            <p className="text-xs text-slate-500">Mínimo 8 caracteres.</p>
          </div>

          {/* Role */}
          <div className="space-y-1">
            <label htmlFor="reg-role" className="text-sm font-medium text-slate-700">Tipo de cuenta</label>
            <select
              id="reg-role"
              name="role"
              className="w-full rounded-xl border border-slate-300 p-3 focus-visible:ring-2 focus-visible:ring-blue-500 outline-none"
              value={form.role}
              onChange={(e) => setForm({ ...form, role: e.target.value as Role })}
            >
              <option value="APPLICANT">Postulante</option>
              <option value="COMPANY">Empresa</option>
            </select>
          </div>

          {/* Legales */}
          <div className="space-y-3 pt-2">
            <label className="flex items-start">
              <input
                type="checkbox"
                className="w-4 h-4 text-blue-600 rounded border-slate-300 focus-visible:ring-blue-500 mt-1"
                checked={form.acceptTerms}
                onChange={(e) => setForm({ ...form, acceptTerms: e.target.checked })}
              />
              <span className="ml-2 text-sm text-slate-600">
                Acepto los <a href="/terminos" className="text-blue-600 hover:text-blue-700 underline">términos y condiciones</a> y la{' '}
                <a href="/privacidad" className="text-blue-600 hover:text-blue-700 underline">política de privacidad</a>.
              </span>
            </label>

            <label className="flex items-start">
              <input
                type="checkbox"
                className="w-4 h-4 text-blue-600 rounded border-slate-300 focus-visible:ring-blue-500 mt-1"
                checked={form.acceptDataPolicy}
                onChange={(e) => setForm({ ...form, acceptDataPolicy: e.target.checked })}
              />
              <span className="ml-2 text-sm text-slate-600">
                Autorizo el tratamiento de mis datos personales conforme a la{' '}
                <a href="/privacidad" className="text-blue-600 hover:text-blue-700 underline">Política de Privacidad</a>.
              </span>
            </label>
          </div>

          {/* Alerts */}
          <div aria-live="polite">
            {error && <p className="text-sm text-red-600" role="alert" aria-live="assertive">{error}</p>}
            {ok && <p className="text-sm text-green-700" role="status">Cuenta creada. Ahora puedes iniciar sesión.</p>}
          </div>

          {/* Submit */}
          <button
            type="submit"
            disabled={loading}
            className="w-full rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 transition disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500"
          >
            {loading ? '...' : 'Registrarme'}
          </button>

          <div className="pt-2 text-center">
            <BackButton />
          </div>
        </form>
      </div>
    </section>
  );
}
