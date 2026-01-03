'use client';

import Link from 'next/link';
import { useMemo, useState } from 'react';
import { routes } from '@/lib/routes';
import { useCompanyJobs } from '@/features/jobs/hooks/useCompanyJobs';

function fmtDate(iso: string) {
  try {
    return new Date(iso).toLocaleDateString('es-PE', {
      year: 'numeric',
      month: 'short',
      day: '2-digit',
    });
  } catch {
    return iso;
  }
}

type EmptyStateCta =
  | { kind: 'clear'; label: string }
  | { kind: 'link'; label: string; href: string };

type EmptyStateModel = {
  title: string;
  description: string;
  primaryCta: EmptyStateCta;
  secondaryCta: { label: string; href: string };
};

export default function CompanyJobsPage() {
  const [q, setQ] = useState('');
  const [status, setStatus] = useState<'OPEN' | 'CLOSED' | ''>('');
  const [page, setPage] = useState(0);

  const qTrimmed = q.trim();

  const jobsQuery = useCompanyJobs({
    page,
    size: 20,
    q: qTrimmed ? qTrimmed : undefined,
    status: status ? status : undefined,
  });

  const jobs = jobsQuery.data;

  function clearFilters() {
    setQ('');
    setStatus('');
    setPage(0);
  }

  const emptyState: EmptyStateModel = useMemo(() => {
    const hasQuery = qTrimmed.length > 0;
    const hasStatus = status === 'OPEN' || status === 'CLOSED';
    const hasFilters = hasQuery || hasStatus;

    if (!hasFilters) {
      return {
        title: 'Lista de ofertas',
        description:
          'Aún no tienes ofertas publicadas. Crea tu primera oferta para empezar a recibir postulaciones.',
        primaryCta: {
          kind: 'link',
          label: 'Publicar mi primera oferta',
          href: routes.dashboard.company.jobNew,
        },
        secondaryCta: {
          label: 'Revisar perfil de empresa',
          href: routes.dashboard.company.profileSetup,
        },
      };
    }

    const statusLabel = status === 'OPEN' ? 'abiertas' : status === 'CLOSED' ? 'cerradas' : null;

    if (hasQuery && statusLabel) {
      return {
        title: 'Sin resultados',
        description: `No se encontraron ofertas ${statusLabel} que coincidan con “${qTrimmed}”.`,
        primaryCta: { kind: 'clear', label: 'Quitar filtros' },
        secondaryCta: { label: 'Publicar oferta', href: routes.dashboard.company.jobNew },
      };
    }

    if (hasQuery) {
      return {
        title: 'Sin resultados',
        description: `No se encontraron ofertas que coincidan con “${qTrimmed}”.`,
        primaryCta: { kind: 'clear', label: 'Quitar filtros' },
        secondaryCta: { label: 'Publicar oferta', href: routes.dashboard.company.jobNew },
      };
    }

    if (statusLabel) {
      return {
        title: 'Sin ofertas',
        description: `No tienes ofertas ${statusLabel} por el momento.`,
        primaryCta: { kind: 'clear', label: 'Ver todas' },
        secondaryCta: { label: 'Publicar oferta', href: routes.dashboard.company.jobNew },
      };
    }

    return {
      title: 'Sin resultados',
      description: 'No hay ofertas para los filtros seleccionados.',
      primaryCta: { kind: 'clear', label: 'Quitar filtros' },
      secondaryCta: { label: 'Publicar oferta', href: routes.dashboard.company.jobNew },
    };
  }, [qTrimmed, status]);

  return (
    <section className="flex flex-col flex-1 min-h-0">
      <div className="max-w-6xl mx-auto w-full px-4 sm:px-6 py-8 space-y-6">
        <header className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-3">
          <div>
            <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">Mis ofertas</h1>
            <p className="mt-1 text-slate-600">Crea y gestiona tus ofertas de empleo.</p>
          </div>

          <Link
            href={routes.dashboard.company.jobNew as any}
            className="inline-flex items-center justify-center rounded-2xl bg-blue-700 px-5 py-3 text-white font-semibold hover:bg-blue-800 transition"
          >
            Publicar oferta
          </Link>
        </header>

        <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-4">
          <div className="grid gap-3 sm:grid-cols-3">
            <input
              className="w-full rounded-2xl border border-slate-200 px-3 py-2.5 text-sm outline-none focus:border-blue-400 focus:ring-4 focus:ring-blue-100"
              placeholder="Buscar por título…"
              value={q}
              onChange={(e) => {
                setQ(e.target.value);
                setPage(0);
              }}
            />

            <select
              className="w-full rounded-2xl border border-slate-200 px-3 py-2.5 text-sm bg-white"
              value={status}
              onChange={(e) => {
                setStatus(e.target.value as any);
                setPage(0);
              }}
            >
              <option value="">Todos los estados</option>
              <option value="OPEN">Abiertas</option>
              <option value="CLOSED">Cerradas</option>
            </select>

            <select
              className="w-full rounded-2xl border border-slate-200 px-3 py-2.5 text-sm bg-slate-50 text-slate-500"
              disabled
            >
              <option>Fecha (pendiente)</option>
            </select>
          </div>
        </section>

        {jobsQuery.isLoading && (
          <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
            <p className="text-sm text-slate-600">Cargando ofertas…</p>
          </section>
        )}

        {jobsQuery.error &&
          !jobsQuery.isLoading &&
          (() => {
            const e = jobsQuery.error;

            if (e.status === 401) {
              return (
                <section className="bg-white rounded-2xl border border-amber-200 shadow-sm p-6">
                  <p className="text-sm text-amber-800 font-semibold">Tu sesión expiró.</p>
                  <p className="mt-1 text-sm text-slate-600">
                    Vuelve a intentarlo. Si el problema persiste, inicia sesión nuevamente.
                  </p>

                  <div className="mt-4 flex flex-col sm:flex-row gap-3">
                    <button
                      type="button"
                      onClick={() => jobsQuery.refetch()}
                      className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white text-sm font-semibold hover:bg-slate-800 transition"
                    >
                      Reintentar
                    </button>
                  </div>
                </section>
              );
            }

            if (e.status === 403) {
              return (
                <section className="bg-white rounded-2xl border border-amber-200 shadow-sm p-6">
                  <p className="text-sm text-amber-800 font-semibold">
                    No tienes permisos para ver esta sección.
                  </p>
                  <p className="mt-1 text-sm text-slate-600">
                    Verifica que iniciaste sesión como empresa y que tu cuenta esté habilitada. Si
                    estás configurando tu empresa por primera vez, completa tu perfil.
                  </p>

                  <div className="mt-4 flex flex-col sm:flex-row gap-3">
                    <Link
                      href={routes.dashboard.company.profileSetup as any}
                      className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white font-semibold hover:bg-slate-800 transition"
                    >
                      Revisar perfil de empresa
                    </Link>

                    <button
                      type="button"
                      onClick={() => jobsQuery.refetch()}
                      className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 font-semibold border border-slate-200 hover:bg-slate-50 transition"
                    >
                      Reintentar
                    </button>
                  </div>
                </section>
              );
            }

            return (
              <section className="bg-white rounded-2xl border border-red-200 shadow-sm p-6">
                <p className="text-sm text-red-700 font-semibold">
                  No se pudieron cargar tus ofertas.
                </p>
                <p className="mt-1 text-sm text-slate-600">
                  Intenta nuevamente. Si persiste, revisa tu sesión o el backend.
                </p>

                <div className="mt-4">
                  <button
                    type="button"
                    onClick={() => jobsQuery.refetch()}
                    className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white text-sm font-semibold hover:bg-slate-800 transition"
                  >
                    Reintentar
                  </button>
                </div>
              </section>
            );
          })()}

        {!jobsQuery.isLoading && !jobsQuery.error && jobs.length === 0 && (
          <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
            <h2 className="text-lg font-semibold text-slate-900">{emptyState.title}</h2>
            <p className="mt-2 text-sm text-slate-600">{emptyState.description}</p>

            <div className="mt-6 flex flex-col sm:flex-row gap-3">
              {emptyState.primaryCta.kind === 'clear' ? (
                <button
                  type="button"
                  onClick={clearFilters}
                  className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white font-semibold hover:bg-slate-800 transition"
                >
                  {emptyState.primaryCta.label}
                </button>
              ) : (
                <Link
                  href={emptyState.primaryCta.href as any}
                  className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white font-semibold hover:bg-slate-800 transition"
                >
                  {emptyState.primaryCta.label}
                </Link>
              )}

              <Link
                href={emptyState.secondaryCta.href as any}
                className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 font-semibold border border-slate-200 hover:bg-slate-50 transition"
              >
                {emptyState.secondaryCta.label}
              </Link>
            </div>
          </section>
        )}

        {!jobsQuery.isLoading && !jobsQuery.error && jobs.length > 0 && (
          <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
            <div className="flex items-center justify-between gap-3">
              <h2 className="text-lg font-semibold text-slate-900">Lista de ofertas</h2>
              <div className="text-sm text-slate-600">{jobs.length} resultado(s)</div>
            </div>

            <div className="mt-4 overflow-x-auto">
              <table className="min-w-full text-sm">
                <thead>
                  <tr className="text-left text-slate-600">
                    <th className="py-3 pr-4">Título</th>
                    <th className="py-3 pr-4">Ubicación</th>
                    <th className="py-3 pr-4">Estado</th>
                    <th className="py-3 pr-4">Publicado</th>
                    <th className="py-3">Acciones</th>
                  </tr>
                </thead>

                <tbody className="divide-y divide-slate-100">
                  {jobs.map((j) => (
                    <tr key={j.id} className="align-top">
                      <td className="py-3 pr-4">
                        <div className="font-semibold text-slate-900">{j.title}</div>
                        {j.quickApplyText ? (
                          <div className="mt-1 text-xs text-slate-600">{j.quickApplyText}</div>
                        ) : null}
                      </td>

                      <td className="py-3 pr-4 text-slate-700">
                        {[j.provinceName, j.districtName].filter(Boolean).join(', ') || '—'}
                      </td>

                      <td className="py-3 pr-4">
                        <span
                          className={`inline-flex items-center rounded-full border px-2.5 py-1 text-xs font-semibold ${
                            j.status === 'OPEN'
                              ? 'border-emerald-200 bg-emerald-50 text-emerald-800'
                              : 'border-slate-200 bg-slate-50 text-slate-700'
                          }`}
                        >
                          {j.status === 'OPEN' ? 'Abierta' : 'Cerrada'}
                        </span>
                      </td>

                      <td className="py-3 pr-4 text-slate-700">{fmtDate(j.publishedAt)}</td>

                      <td className="py-3">
                        <div className="flex flex-wrap gap-2">
                          <Link
                            href={`${routes.dashboard.company.jobs}/${j.id}` as any}
                            className="inline-flex items-center justify-center rounded-2xl bg-white px-3 py-2 text-slate-900 text-xs font-semibold border border-slate-200 hover:bg-slate-50 transition"
                          >
                            Ver
                          </Link>

                          <Link
                            href={`${routes.dashboard.company.jobs}/${j.id}/edit` as any}
                            className="inline-flex items-center justify-center rounded-2xl bg-white px-3 py-2 text-slate-900 text-xs font-semibold border border-slate-200 hover:bg-slate-50 transition"
                          >
                            Editar
                          </Link>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            <p className="mt-4 text-xs text-slate-500">
              Nota: filtro por fecha pendiente (desde cuándo, rango, etc.).
            </p>
          </section>
        )}
      </div>
    </section>
  );
}
