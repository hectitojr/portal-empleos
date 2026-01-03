'use client';

import { useRouter } from 'next/navigation';
import { routes } from '@/lib/routes';
import { useMe } from '@/features/iam/hooks/useMe';

type Props = {
  children: React.ReactNode;
};

export function CompanyPublishGate({ children }: Props) {
  const router = useRouter();
  const meQuery = useMe();

  const isLoading = meQuery.isLoading;
  const loadError = meQuery.error as any;

  if (isLoading) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6">
        <p className="text-sm text-slate-600">Verificando estado de tu cuenta…</p>
      </div>
    );
  }

  if (loadError) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-red-200 p-6">
        <p className="text-sm text-red-700 font-semibold">No se pudo validar tu sesión.</p>
        <p className="mt-1 text-sm text-slate-600">
          Intenta recargar. Si el problema persiste, vuelve a iniciar sesión.
        </p>

        <div className="mt-4 flex gap-3">
          <button
            type="button"
            onClick={() => meQuery.refetch()}
            className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white text-sm font-semibold hover:bg-slate-800 transition"
          >
            Reintentar
          </button>

          <button
            type="button"
            onClick={() => router.push(routes.public.login)}
            className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
          >
            Ir al login
          </button>
        </div>
      </div>
    );
  }

  const me = meQuery.me;

  if (!me) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6">
        <p className="text-sm text-slate-600">No se encontró información de tu sesión.</p>
      </div>
    );
  }

  if (!meQuery.isEmployer) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-amber-200 p-6">
        <p className="text-sm font-semibold text-slate-900">Acceso no permitido</p>
        <p className="mt-1 text-sm text-slate-600">Esta sección es solo para cuentas de empresa.</p>

        <div className="mt-5">
          <button
            type="button"
            onClick={() => router.push(routes.dashboard.me)}
            className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
          >
            Volver
          </button>
        </div>
      </div>
    );
  }

  if (!meQuery.employerReadyToPublish) {
    const suspended = me.employerSuspended === true;
    const active = me.employerActive === true;
    const identityCompleted = me.identityCompleted === true;
    const profileCompleted = me.employerProfileCompleted === true;

    const title = suspended
      ? 'Tu cuenta de empresa está suspendida'
      : !active
        ? 'Tu cuenta de empresa está inactiva'
        : !identityCompleted
          ? 'Completa tu identidad para publicar'
          : 'Completa el perfil de empleador para publicar';

    const message = suspended
      ? 'Tu cuenta de empresa tiene un bloqueo por moderación o revisión. Si no reconoces este estado, contacta soporte.'
      : !active
        ? 'Tu cuenta de empresa está deshabilitada. Si no reconoces este estado, contacta soporte.'
        : !identityCompleted
          ? 'Para habilitar la publicación de ofertas, primero debemos validar tu identidad (documento).'
          : 'Completa los datos mínimos del perfil de empleador para habilitar la publicación de ofertas.';

    return (
      <div className="bg-white rounded-2xl shadow-sm border border-amber-200 p-6">
        <p className="text-sm font-semibold text-slate-900">{title}</p>
        <p className="mt-1 text-sm text-slate-600">{message}</p>

        {active && !suspended && (!identityCompleted || !profileCompleted) && (
          <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
            <p className="text-sm text-slate-700">
              {identityCompleted ? (
                <>
                  Ve a <span className="font-semibold">Perfil de empresa</span> y completa los datos
                  mínimos.
                </>
              ) : (
                <>
                  Ve a <span className="font-semibold">Identidad</span> y registra tu documento.
                </>
              )}
            </p>
          </div>
        )}

        <div className="mt-5 flex flex-col sm:flex-row gap-3">
          {active && !suspended && (!identityCompleted || !profileCompleted) && (
            <button
              type="button"
              onClick={() => router.push(routes.dashboard.company.profileSetup)}
              className="inline-flex items-center justify-center rounded-2xl bg-blue-700 px-4 py-2.5 text-white text-sm font-semibold hover:bg-blue-800 transition"
            >
              Completar requisitos
            </button>
          )}

          <button
            type="button"
            onClick={() => router.push(routes.dashboard.company.home)}
            className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
          >
            Volver al panel
          </button>
        </div>
      </div>
    );
  }

  return <>{children}</>;
}
