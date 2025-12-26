'use client';

import Link from 'next/link';
import {
  AnimatePresence,
  motion,
  useReducedMotion,
  type Variants,
  easeIn,
  easeOut,
} from 'framer-motion';
import { Mail, AlertCircle } from 'lucide-react';
import AuthHeader from '@/features/iam/components/AuthHeader';
import RoleSelect from '@/features/iam/components/RoleSelect';
import TextField from '@/features/iam/components/TextField';
import PasswordField from '@/features/iam/components/PasswordField';
import TermsCheckboxes from '@/features/iam/components/TermsCheckboxes';
import ToggleAuthLink from '@/features/iam/components/ToggleAuthLink';
import BackButton from '@/features/iam/components/BackButton';
import { useAuthState } from '@/features/iam/hooks/useAuthState';

export default function LoginClient() {
  const s = useAuthState();
  const reduce = useReducedMotion();

  const slideVariants: Variants = reduce
    ? { initial: { opacity: 0 }, animate: { opacity: 1 }, exit: { opacity: 0 } }
    : {
        initial: { opacity: 0, x: 24 },
        animate: {
          opacity: 1,
          x: 0,
          transition: { type: 'tween', duration: 0.28, ease: easeOut },
        },
        exit: {
          opacity: 0,
          x: -24,
          transition: { type: 'tween', duration: 0.18, ease: easeIn },
        },
      };

  const containerClass = 'w-full max-w-5xl mx-auto';

  const title =
    s.authMode === 'login'
      ? 'Bienvenido de nuevo'
      : s.authMode === 'select-role'
        ? '¿Cómo quieres registrarte?'
        : 'Crear cuenta';

  const subtitle =
    s.authMode === 'login'
      ? 'Ingresa tus credenciales para continuar'
      : s.authMode === 'select-role'
        ? 'Selecciona el tipo de cuenta que necesitas'
        : `Regístrate como ${s.userType === 'APPLICANT' ? 'Candidato' : 'Empresa'}`;

  function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    s.submit();
  }

  return (
    <section
      role="region"
      aria-label="Autenticación"
      className="flex-1 flex items-center justify-center p-4 sm:p-6 lg:p-8"
    >
      <div className={containerClass}>
        <AuthHeader title={title} subtitle={subtitle} />

        {/* Alerts */}
        <div aria-live="polite">
          {s.success && (
            <div
              className="mb-6 p-4 bg-green-50 border border-green-200 rounded-xl text-sm"
              role="status"
            >
              ¡Operación exitosa!
            </div>
          )}
          {s.apiError && (
            <div
              className="mb-6 p-3 bg-red-50 border border-red-200 rounded-lg text-sm text-red-700 flex items-center gap-2"
              role="alert"
              aria-live="assertive"
            >
              <AlertCircle className="w-4 h-4" aria-hidden="true" />
              {s.apiError}
            </div>
          )}
        </div>

        <div className="relative">
          <AnimatePresence mode="wait">
            {s.authMode === 'select-role' ? (
              <motion.div
                key="select-role"
                variants={slideVariants}
                initial="initial"
                animate="animate"
                exit="exit"
                layout
              >
                <RoleSelect
                  onPick={(r) => {
                    s.setUserType(r);
                    requestAnimationFrame(() => s.setAuthMode('register'));
                  }}
                />
              </motion.div>
            ) : (
              <div className="mx-auto max-w-md">
                <motion.div
                  key={s.authMode}
                  variants={slideVariants}
                  initial="initial"
                  animate="animate"
                  exit="exit"
                  layout
                  className="bg-white rounded-2xl shadow-xl p-6 sm:p-8 min-h-[420px]"
                >
                  <form className="space-y-5" onSubmit={onSubmit} noValidate>
                    <TextField
                      label="Correo Electrónico"
                      name="email"
                      value={s.formData.email}
                      onChange={s.handleInputChange}
                      placeholder="tu@email.com"
                      icon={
                        <Mail
                          className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400"
                          aria-hidden="true"
                        />
                      }
                      error={s.errors.email}
                      type="email"
                      autoComplete="email"
                      inputMode="email"
                    />

                    <PasswordField
                      name="password"
                      label="Contraseña"
                      value={s.formData.password}
                      onChange={s.handleInputChange}
                      placeholder="Mínimo 8 caracteres"
                      error={s.errors.password}
                    />

                    {s.authMode === 'register' && (
                      <PasswordField
                        name="confirmPassword"
                        label="Confirmar Contraseña"
                        value={s.formData.confirmPassword}
                        onChange={s.handleInputChange}
                        placeholder="Repite tu contraseña"
                        error={s.errors.confirmPassword}
                      />
                    )}

                    {s.authMode === 'login' && (
                      <div className="flex items-center justify-between text-sm">
                        <label className="flex items-center">
                          <input
                            type="checkbox"
                            className="w-4 h-4 text-blue-600 rounded border-slate-300 focus-visible:ring-blue-500"
                          />
                          <span className="ml-2 text-slate-600">Recordarme</span>
                        </label>
                        <Link
                          href="/auth/forgot-password"
                          className="text-blue-600 hover:text-blue-700 font-medium"
                        >
                          ¿Olvidaste tu contraseña?
                        </Link>
                      </div>
                    )}

                    {s.authMode === 'register' && (
                      <TermsCheckboxes
                        acceptTerms={s.formData.acceptTerms}
                        acceptDataPolicy={s.formData.acceptDataPolicy}
                        onChange={s.handleInputChange}
                        errors={s.errors}
                      />
                    )}

                    <button
                      type="submit"
                      disabled={s.loading}
                      className={`w-full py-3 rounded-xl font-semibold transition-all shadow-lg hover:shadow-xl focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 ${
                        s.loading
                          ? 'bg-slate-400 cursor-not-allowed text-white'
                          : 'bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white'
                      }`}
                    >
                      {s.loading
                        ? 'Procesando...'
                        : s.authMode === 'login'
                          ? 'Iniciar Sesión'
                          : 'Crear Cuenta'}
                    </button>

                    <ToggleAuthLink
                      isLogin={s.authMode === 'login'}
                      onToggle={() => {
                        if (s.authMode === 'login') s.setAuthMode('select-role');
                        else {
                          s.setAuthMode('login');
                          s.setUserType(null);
                        }
                      }}
                    />
                  </form>
                </motion.div>
              </div>
            )}
          </AnimatePresence>
        </div>

        <div className="mt-6 text-center">
          <BackButton />
        </div>
      </div>
    </section>
  );
}
