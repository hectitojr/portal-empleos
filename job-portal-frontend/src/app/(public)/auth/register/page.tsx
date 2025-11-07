'use client';

import { useState } from 'react';
import { registerSchema, type RegisterSchema } from '../lib/schema';
import { registerReq } from '../lib/authClient';
import { humanize } from '@/lib/errors';
import BackButton from '../components/BackButton';
import AuthHeader from '../components/AuthHeader';

export default function RegisterPage() {
  const [form, setForm] = useState<RegisterSchema>({
    email: '',
    password: '',
    role: 'APPLICANT',
  });

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [ok, setOk] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    const v = registerSchema.pick({ email: true, password: true, role: true }).safeParse(form);
    if (!v.success) {
      setError('Revisa los campos.');
      return;
    }

    setLoading(true);
    setError(null);

    const { ok, data } = await registerReq(form);
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
              onChange={(e) => setForm({ ...form, role: e.target.value as any })}
            >
              <option value="APPLICANT">Postulante</option>
              <option value="COMPANY">Empresa</option>
            </select>
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
