'use client';

import { useState } from 'react';
import AuthHeader from '@/features/iam/components/AuthHeader';
import BackButton from '@/features/iam/components/BackButton';

type MessageResponse = {
  code?: string;
  message?: string;
  traceId?: string;
  timestamp?: string;
};

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('');
  const [sending, setSending] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setSending(true);
    setErr(null);
    setMsg(null);

    try {
      const res = await fetch('/api/auth/forgot', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'same-origin',
        body: JSON.stringify({ email }),
      });

      const data: MessageResponse = await res.json().catch(() => ({}));

      if (!res.ok) {
        throw new Error(
          data.message || 'No se pudo enviar el enlace de recuperación.'
        );
      }

      setMsg(
        data.message ||
          'Te enviamos un enlace para restablecer tu contraseña si el correo existe en el sistema.'
      );
    } catch (e: any) {
      setErr(e.message || 'Ocurrió un error.');
    } finally {
      setSending(false);
    }
  }

  return (
    <section
      role="region"
      aria-label="Recuperar contraseña"
      className="min-h-[calc(100vh-4rem)] flex items-center justify-center p-4 sm:p-6 lg:p-8"
    >
      <div className="w-full max-w-md mx-auto">
        <AuthHeader
          title="Recuperar contraseña"
          subtitle="Ingresa tu correo y te enviaremos un enlace"
        />

        <form
          onSubmit={onSubmit}
          className="bg-white rounded-2xl shadow-xl p-6 sm:p-8 space-y-4"
          noValidate
        >
          <div className="space-y-1">
            <label
              htmlFor="forgot-email"
              className="text-sm font-medium text-slate-700"
            >
              Correo
            </label>
            <input
              id="forgot-email"
              name="email"
              type="email"
              autoComplete="email"
              className="w-full rounded-xl border border-slate-300 p-3 focus-visible:ring-2 focus-visible:ring-blue-500 outline-none"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>

          <div aria-live="polite">
            {err && (
              <p
                className="text-sm text-red-600"
                role="alert"
                aria-live="assertive"
              >
                {err}
              </p>
            )}
            {msg && (
              <p className="text-sm text-green-700" role="status">
                {msg}
              </p>
            )}
          </div>

          <button
            type="submit"
            disabled={sending}
            className="w-full rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 transition disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500"
          >
            {sending ? 'Enviando…' : 'Enviar enlace'}
          </button>

          <div className="pt-2 text-center">
            <BackButton />
          </div>
        </form>
      </div>
    </section>
  );
}
