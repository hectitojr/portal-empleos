'use client';

import Link from 'next/link';
import { useState } from 'react';
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

export default function CompanyJobsPage() {
  const [q, setQ] = useState('');
  const [status, setStatus] = useState<'OPEN' | 'CLOSED' | ''>('');
  const [page] = useState(0);

  const jobsQuery = useCompanyJobs({
    page,
    size: 20,
    q: q.trim() ? q.trim() : undefined,
    status: status ? status : undefined,
  });

  const jobs = jobsQuery.data;

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

        {/* Toolbar */}
        <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-4">
          <div className="grid gap-3 sm:grid-cols-3">
            <input
              className="w-full rounded-2xl border border-slate-200 px-3 py-2.5 text-sm outline-none focus:border-blue-400 focus:ring-4 focus:ring-blue-100"
              placeholder="Buscar por título…"
              value={q}
              onChange={(e) => setQ(e.target.value)}
            />

            <select
              className="w-full rounded-2xl border border-slate-200 px-3 py-2.5 text-sm bg-white"
              value={status}
              onChange={(e) => setStatus(e.target.value as any)}
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

        {/* Loading */}
        {jobsQuery.isLoading && (
          <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
            <p className="text-sm text-slate-600">Cargando ofertas…</p>
          </section>
        )}

        {/* Error */}
        {jobsQuery.error && !jobsQuery.isLoading && (
          <section className="bg-white rounded-2xl border border-red-200 shadow-sm p-6">
            <p className="text-sm text-red-700 font-semibold">No se pudieron cargar tus ofertas.</p>
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
        )}

        {/* Empty */}
        {!jobsQuery.isLoading && !jobsQuery.error && jobs.length === 0 && (
          <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
            <h2 className="text-lg font-semibold text-slate-900">Lista de ofertas</h2>
            <p className="mt-2 text-sm text-slate-600">
              Aún no tienes ofertas publicadas. Crea tu primera oferta para empezar a recibir
              postulaciones.
            </p>

            <div className="mt-6 flex flex-col sm:flex-row gap-3">
              <Link
                href={routes.dashboard.company.jobNew as any}
                className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white font-semibold hover:bg-slate-800 transition"
              >
                Publicar mi primera oferta
              </Link>
              <Link
                href={routes.dashboard.company.profileSetup as any}
                className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 font-semibold border border-slate-200 hover:bg-slate-50 transition"
              >
                Revisar perfil de empresa
              </Link>
            </div>
          </section>
        )}

        {/* Table */}
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
                          {/* Ajusta la ruta real a tu detalle/edición si ya existe */}
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
