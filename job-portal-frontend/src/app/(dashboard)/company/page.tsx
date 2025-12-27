'use client';

import Link from 'next/link';
import { Info } from 'lucide-react';
import { routes } from '@/lib/routes';
import { useCompanyMe } from '@/features/companies/hooks/useCompanyMe';
import { computeCompanyProfileProgress } from '@/features/companies/lib/profileProgress';

export default function CompanyHomePage() {
  const meQuery = useCompanyMe();
  const me = meQuery.data;

  const progressState = me
    ? computeCompanyProfileProgress({
        legalName: me.legalName,
        taxId: me.taxId,
        contactEmail: me.contactEmail,
        districtId: me.districtId,
      })
    : null;

  const progress = progressState?.progress ?? 0;
  const missing = progressState?.missing ?? [];

  return (
    <section
      role="region"
      aria-label="Panel de la empresa"
      className="flex flex-col flex-1 min-h-0"
    >
      <section className="py-8 shrink-0">
        <div className="max-w-6xl mx-auto px-4 sm:px-6">
          <div className="mb-2">
            <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">Panel de empresa</h1>
            <p className="mt-1 text-slate-600">
              Publica ofertas, revisa postulaciones y administra tu perfil.
            </p>
          </div>

          <div className="mt-5 flex flex-col sm:flex-row gap-3">
            <Link
              href={'/company/jobs/new' as any}
              className="inline-flex items-center justify-center rounded-2xl bg-blue-700 px-5 py-3 text-white font-semibold hover:bg-blue-800 transition"
            >
              Publicar oferta
            </Link>

            <Link
              href={routes.dashboard.company.jobs as any}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-5 py-3 text-slate-900 font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              Ver mis ofertas
            </Link>

            <Link
              href={'/company/applications' as any}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-5 py-3 text-slate-900 font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              Ver postulaciones
            </Link>

            <Link
              href={'/me/company/profile/setup' as any}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-5 py-3 text-slate-900 font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              Editar perfil
            </Link>
          </div>
        </div>
      </section>

      {/* Contenido principal */}
      <section className="flex-1 min-h-0">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 pb-10 space-y-6">
          {/* Estado / Progreso perfil */}
          <section className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6">
            <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
              <div>
                <h2 className="text-lg font-semibold text-slate-900">Estado de tu empresa</h2>
                <p className="text-sm text-slate-600 mt-1">
                  Completa los datos de tu empresa para publicar ofertas laborales.
                </p>

                {!meQuery.isLoading && !meQuery.error && me && (
                  <div className="mt-3 flex flex-wrap items-center gap-2">
                    <StatusPill
                      label={me.profileComplete ? 'Perfil completo' : 'Perfil incompleto'}
                      tone={me.profileComplete ? 'ok' : 'warn'}
                      help={
                        me.profileComplete
                          ? 'Tu perfil tiene los datos mínimos para publicar sin inconvenientes.'
                          : 'Te faltan datos requeridos para habilitar la publicación de ofertas.'
                      }
                    />
                    <StatusPill
                      label={me.active ? 'Activa' : 'Inactiva'}
                      tone={me.active ? 'ok' : 'neutral'}
                      help={
                        me.active
                          ? 'Tu empresa está habilitada para usar el portal y publicar ofertas.'
                          : 'Tu empresa está deshabilitada; contacta soporte si no reconoces este estado.'
                      }
                    />
                    <StatusPill
                      label={me.suspended ? 'Suspendida' : 'Sin suspensión'}
                      tone={me.suspended ? 'danger' : 'ok'}
                      help={
                        me.suspended
                          ? 'Tu empresa tiene un bloqueo por moderación o revisión.'
                          : 'Tu empresa no tiene bloqueos por moderación.'
                      }
                    />
                  </div>
                )}
              </div>

              <Link
                href={'/me/company/profile/setup' as any}
                className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white font-semibold hover:bg-slate-800 transition"
              >
                {progress === 100 ? 'Ver perfil' : 'Completar perfil'}
              </Link>
            </div>

            {meQuery.isLoading ? (
              <div className="mt-5 text-sm text-slate-600">Cargando estado…</div>
            ) : meQuery.error ? (
              <div className="mt-5 text-sm text-red-700 font-semibold">
                No se pudo cargar el estado del perfil.
              </div>
            ) : (
              <div className="mt-5">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-slate-700 font-medium">Perfil completado</span>
                  <span className="text-slate-600">{progress}%</span>
                </div>

                <div className="mt-2 h-2 rounded-full bg-slate-100 overflow-hidden">
                  <div
                    className="h-full bg-blue-700 rounded-full"
                    style={{ width: `${progress}%` }}
                  />
                </div>

                {missing.length > 0 && (
                  <ul className="mt-4 text-sm text-slate-600 list-disc pl-5 space-y-1">
                    {missing.map((m) => (
                      <li key={m}>{m}</li>
                    ))}
                  </ul>
                )}
              </div>
            )}
          </section>

          <section className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            <MetricCard title="Ofertas activas" value="—" hint="Publicadas y abiertas" />
            <MetricCard title="Postulaciones (7 días)" value="—" hint="Entrantes recientes" />
            <MetricCard title="Nuevas hoy" value="—" hint="Revisar bandeja" />
            <MetricCard title="Ofertas en borrador" value="—" hint="Listas para publicar" />
          </section>

          <section className="grid gap-6 lg:grid-cols-3">
            <aside className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6">
              <h3 className="text-sm font-semibold text-slate-900">Actividad reciente</h3>
              <div className="mt-4 space-y-3 text-sm text-slate-600">
                <p>— Aquí mostraremos eventos como nuevas postulaciones o cambios de estado.</p>
                <p>— “postulaciones recientes”.</p>
              </div>
            </aside>

            <section className="lg:col-span-2 bg-white rounded-2xl shadow-sm border border-slate-100 p-6">
              <div className="flex items-center justify-between gap-3">
                <div>
                  <h3 className="text-lg font-semibold text-slate-900">Mis ofertas</h3>
                  <p className="text-sm text-slate-600 mt-1">
                    Control rápido del estado y postulaciones por oferta.
                  </p>
                </div>

                <Link
                  href={routes.dashboard.company.jobs as any}
                  className="text-blue-700 hover:text-blue-800 font-semibold text-sm"
                >
                  Ver todas
                </Link>
              </div>

              <div className="mt-4 overflow-x-auto">
                <table className="w-full text-sm">
                  <thead className="text-left text-slate-600">
                    <tr className="border-b border-slate-100">
                      <th className="py-3 pr-3 font-semibold">Título</th>
                      <th className="py-3 pr-3 font-semibold">Estado</th>
                      <th className="py-3 pr-3 font-semibold">Postulaciones</th>
                      <th className="py-3 pr-3 font-semibold">Acciones</th>
                    </tr>
                  </thead>
                  <tbody className="text-slate-700">
                    <tr className="border-b border-slate-50">
                      <td className="py-3 pr-3">—</td>
                      <td className="py-3 pr-3">—</td>
                      <td className="py-3 pr-3">—</td>
                      <td className="py-3 pr-3">
                        <span className="text-slate-500">Conecta backend</span>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </section>
          </section>
        </div>
      </section>
    </section>
  );
}

function MetricCard({ title, value, hint }: { title: string; value: string; hint: string }) {
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <p className="text-xs font-semibold text-slate-600">{title}</p>
      <p className="mt-2 text-2xl font-bold text-slate-900">{value}</p>
      <p className="mt-1 text-sm text-slate-600">{hint}</p>
    </div>
  );
}

function StatusPill({
  label,
  tone,
  help,
}: {
  label: string;
  tone: 'ok' | 'warn' | 'danger' | 'neutral';
  help: string;
}) {
  const cls =
    tone === 'ok'
      ? 'border-emerald-200 bg-emerald-50 text-emerald-800'
      : tone === 'warn'
        ? 'border-amber-200 bg-amber-50 text-amber-900'
        : tone === 'danger'
          ? 'border-red-200 bg-red-50 text-red-700'
          : 'border-slate-200 bg-white text-slate-700';

  return (
    <span
      className={`group relative inline-flex items-center rounded-full border px-3 py-1 text-xs font-semibold ${cls}`}
    >
      <span className="inline-flex items-center gap-2">
        {label}
        <Info className="w-3.5 h-3.5 opacity-70" aria-hidden="true" />
      </span>

      <span
        role="tooltip"
        className="
          pointer-events-none absolute top-full left-1/2 -translate-x-1/2 mt-2 z-50
          whitespace-nowrap
          opacity-0 translate-y-1
          group-hover:opacity-100 group-hover:translate-y-0
          transition
        "
      >
        <span className="block rounded-xl bg-slate-900 text-white px-3 py-2 text-xs font-medium shadow-lg">
          {help}
        </span>
      </span>
    </span>
  );
}
