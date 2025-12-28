'use client';

import type { Route } from 'next';
import { useMemo } from 'react';
import { usePathname, useRouter } from 'next/navigation';
import { useQueryClient } from '@tanstack/react-query';

import { logoutReq } from '@/features/iam/api/authClient';
import { routes } from '@/lib/routes';
import { useNavigationGuard } from '@/app/components/navigation/NavigationGuardProvider';

function buildAuthUrl(params: { mode: 'login' | 'register'; next: Route; from: string }) {
  const sp = new URLSearchParams();
  sp.set('mode', params.mode);
  sp.set('role', 'COMPANY');
  sp.set('next', params.next);
  sp.set('from', params.from);
  return `${routes.public.login}?${sp.toString()}` as Route;
}

export default function PublishJobsBridgePage() {
  const router = useRouter();
  const pathname = usePathname() ?? routes.dashboard.applicant.home;
  const qc = useQueryClient();
  const guard = useNavigationGuard();

  const from = useMemo(() => pathname, [pathname]);

  function guardedNavigate(path: Route) {
    if (!guard.isDirty()) {
      router.push(path);
      return;
    }
    guard.setPendingNavigate(() => router.push(path));
    guard.pingOpenConfirm();
  }

  async function continueAsCompany(mode: 'login' | 'register') {
    const target = buildAuthUrl({
      mode,
      next: routes.dashboard.company.jobNew,
      from,
    });

    const go = async () => {
      await logoutReq();
      qc.clear();
      router.replace(target);
      router.refresh();
    };

    if (!guard.isDirty()) {
      await go();
      return;
    }

    guard.setPendingNavigate(() => void go());
    guard.pingOpenConfirm();
  }

  return (
    <section className="flex-1 flex items-center justify-center px-4 sm:px-6">
      <div className="w-full max-w-xl">
        <div className="bg-white border border-slate-200 rounded-2xl shadow-sm p-6 sm:p-8">
          <h1 className="text-xl sm:text-2xl font-bold text-slate-900">
            Para publicar empleos necesitas una cuenta de Empresa
          </h1>

          <p className="mt-2 text-slate-600 leading-relaxed">
            Estás navegando como <span className="font-semibold">Postulante</span>. Para crear y
            administrar ofertas de empleo debes ingresar con una cuenta de{' '}
            <span className="font-semibold">Empresa</span>.
          </p>

          <div className="mt-6 grid gap-3">
            <button
              type="button"
              onClick={() => void continueAsCompany('login')}
              className="w-full inline-flex items-center justify-center rounded-xl px-4 py-3 text-sm font-semibold
                         bg-blue-700 text-white hover:bg-blue-800 transition-colors"
            >
              Continuar como Empresa (iniciar sesión)
            </button>

            <button
              type="button"
              onClick={() => void continueAsCompany('register')}
              className="w-full inline-flex items-center justify-center rounded-xl px-4 py-3 text-sm font-semibold
                         bg-white text-blue-700 border border-blue-200 hover:bg-blue-50 transition-colors"
            >
              Crear cuenta de Empresa
            </button>

            <div className="mt-2 pt-4 border-t border-slate-200">
              <button
                type="button"
                onClick={() => guardedNavigate(routes.dashboard.applicant.home)}
                className="w-full inline-flex items-center justify-center rounded-xl px-4 py-3 text-sm font-semibold
                           text-slate-700 hover:bg-slate-100 transition-colors"
              >
                Seguir como Postulante
              </button>
            </div>
          </div>

          <p className="mt-4 text-xs text-slate-500">
            Nota: si continúas como Empresa, cerraremos tu sesión actual para que puedas iniciar con
            tu cuenta de Empresa.
          </p>
        </div>
      </div>
    </section>
  );
}
