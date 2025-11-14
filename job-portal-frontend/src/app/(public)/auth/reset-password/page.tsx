'use client';

import { useState } from 'react';
import { useSearchParams } from 'next/navigation';
import AuthHeader from '../../../../features/iam/components/AuthHeader';
import BackButton from '../../../../features/iam/components/BackButton';
import PasswordField from '../../../../features/iam/components/PasswordField';

export default function ResetPasswordPage() {
  const params = useSearchParams();
  const token = params.get('token') || ''; // /auth/reset?token=...

  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);

  function validate(): boolean {
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
        body: JSON.stringify({ token, password }),
      });
      if (!res.ok) throw new Error('No se pudo restablecer la contraseña.');
      setMsg('Tu contraseña fue restablecida. Ya puedes iniciar sesión.');
    } catch (e: any) {
      setErr(e.message || 'Ocurrió un error.');
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
        <AuthHeader title="Restablecer contraseña" subtitle="Define una nueva contraseña segura" />

        <form onSubmit={onSubmit} className="bg-white rounded-2xl shadow-xl p-6 sm:p-8 space-y-5" noValidate>
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
            {err && <p className="text-sm text-red-600" role="alert" aria-live="assertive">{err}</p>}
            {msg && <p className="text-sm text-green-700" role="status">{msg}</p>}
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
      </div>
    </section>
  );
}
