'use client';

import { useEffect, useState } from 'react';
import { useSearchParams } from 'next/navigation';
import AuthHeader from '@/features/iam/components/AuthHeader';
import BackButton from '@/features/iam/components/BackButton';
import PasswordField from '@/features/iam/components/PasswordField';

type MessageResponse = {
  code?: string;
  message?: string;
  traceId?: string;
  timestamp?: string;
};

export default function ResetPasswordClient() {
  const params = useSearchParams();

  const selector = params.get('selector') || '';
  const token = params.get('token') || '';

  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);
  const [linkError, setLinkError] = useState<string | null>(null);

  useEffect(() => {
    if (!selector || !token) {
      setLinkError(
        'El enlace de recuperación no es válido o está incompleto. Solicita un nuevo enlace.'
      );
    } else {
      setLinkError(null);
    }
  }, [selector, token]);

  function validate(): boolean {
    if (linkError) return false;

    if (!password || password.length < 8) {
      setErr('La contraseña debe tener al menos 8 caracteres.');
      return false;
    }
    if (password !== confirm) {
      setErr('Las contraseñas no coinciden.');
      return false;
    }
    return true;
  }

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setErr(null);
    setMsg(null);

    if (!validate()) return;

    setSaving(true);
    try {
      const res = await fetch('/api/auth/reset', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'same-origin',
        body: JSON.stringify({
          selector,
          token,
          newPassword: password,
        }),
      });

      const data: MessageResponse = await res.json().catch(() => ({}));

      if (!res.ok) {
        throw new Error(data.message || 'No se pudo restablecer la contraseña.');
      }

      setMsg(
        data.message ||
          'Tu contraseña fue restablecida. Ya puedes iniciar sesión.'
      );
    } catch (e: any) {
      setErr(e?.message || 'Ocurrió un error.');
    } finally {
      setSaving(false);
    }
  }

  return (
    <section
      role="region"
      aria-label="Restablecer contraseña"
      className="min-h-[calc(100vh-4rem)] flex items-center justify-center p-4 sm:p-6 lg:p-8"
    >
      <div className="w-full max-w-md mx-auto">
        <AuthHeader
          title="Restablecer contraseña"
          subtitle="Define una nueva contraseña segura"
        />

        {linkError ? (
          <div className="bg-white rounded-2xl shadow-xl p-6 sm:p-8 space-y-4">
            <p className="text-sm text-red-600" role="alert">
              {linkError}
            </p>
            <div className="pt-2 text-center">
              <BackButton />
            </div>
          </div>
        ) : (
          <form
            onSubmit={onSubmit}
            className="bg-white rounded-2xl shadow-xl p-6 sm:p-8 space-y-5"
            noValidate
          >
            <PasswordField
              name="password"
              label="Nueva contraseña"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Mínimo 8 caracteres"
              error={undefined}
            />

            <PasswordField
              name="confirmPassword"
              label="Confirmar nueva contraseña"
              value={confirm}
              onChange={(e) => setConfirm(e.target.value)}
              placeholder="Repite tu contraseña"
              error={undefined}
            />

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
              disabled={saving}
              className="w-full rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 transition disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500"
            >
              {saving ? 'Guardando…' : 'Guardar nueva contraseña'}
            </button>

            <div className="pt-2 text-center">
              <BackButton />
            </div>
          </form>
        )}
      </div>
    </section>
  );
}
