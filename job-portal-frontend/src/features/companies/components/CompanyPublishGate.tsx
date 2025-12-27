'use client';

import { useRouter } from 'next/navigation';
import { useCompanyMe } from '@/features/companies/hooks/useCompanyMe';
import { routes } from '@/lib/routes';

type Props = {
  children: React.ReactNode;
};

function canPublish(me: { profileComplete: boolean; active: boolean; suspended: boolean }) {
  return me.profileComplete && me.active && !me.suspended;
}

export function CompanyPublishGate({ children }: Props) {
  const router = useRouter();
  const meQuery = useCompanyMe();

  const me = meQuery.data;
  const isLoading = meQuery.isLoading;
  const loadError = meQuery.error as any;

  if (isLoading) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6">
        <p className="text-sm text-slate-600">Verificando estado de tu empresa…</p>
      </div>
    );
  }

  if (loadError) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-red-200 p-6">
        <p className="text-sm text-red-700 font-semibold">No se pudo validar tu empresa.</p>
        <p className="mt-1 text-sm text-slate-600">
          Intenta recargar. Si el problema persiste, revisa tu sesión.
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

  if (!me) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6">
        <p className="text-sm text-slate-600">No se encontró información de tu empresa.</p>
      </div>
    );
  }

  if (!canPublish(me)) {
    const title = me.suspended
      ? 'Tu empresa está suspendida'
      : !me.active
        ? 'Tu empresa está inactiva'
        : 'Tu empresa aún no puede publicar ofertas';

    const message = me.suspended
      ? 'Tu cuenta de empresa tiene un bloqueo por moderación o revisión. Si no reconoces este estado, contacta soporte.'
      : !me.active
        ? 'Tu empresa está deshabilitada. Si no reconoces este estado, contacta soporte.'
        : 'Completa tu perfil de empresa para habilitar la publicación de ofertas. Esto mejora la confianza y la experiencia de postulación.';

    return (
      <div className="bg-white rounded-2xl shadow-sm border border-amber-200 p-6">
        <p className="text-sm font-semibold text-slate-900">{title}</p>
        <p className="mt-1 text-sm text-slate-600">{message}</p>

        {!me.suspended && me.active && !me.profileComplete && (
          <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
            <p className="text-sm text-slate-700">
              Ve a <span className="font-semibold">Perfil de empresa</span> y completa los datos mínimos.
            </p>
          </div>
        )}

        <div className="mt-5 flex flex-col sm:flex-row gap-3">
          {!me.suspended && me.active && !me.profileComplete && (
            <button
              type="button"
              onClick={() => router.push('/me/company/profile/setup')}
              className="inline-flex items-center justify-center rounded-2xl bg-blue-700 px-4 py-2.5 text-white text-sm font-semibold hover:bg-blue-800 transition"
            >
              Completar perfil
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
