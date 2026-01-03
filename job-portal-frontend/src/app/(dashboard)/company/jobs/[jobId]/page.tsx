import Link from 'next/link';
import type { Metadata } from 'next';
import { routes } from '@/lib/routes';

export const metadata: Metadata = {
  title: 'Ver oferta | EmpleosPeru',
};

export default async function CompanyJobViewPage({
  params,
}: {
  params: Promise<{ jobId: string }>;
}) {
  const { jobId } = await params;

  return (
    <section className="flex flex-col flex-1 min-h-0 bg-slate-50">
      <div className="max-w-4xl mx-auto w-full px-4 sm:px-6 py-8 space-y-6">
        <header className="flex items-start justify-between gap-4">
          <div>
            <Link
              href={routes.dashboard.company.jobs as any}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              ← Volver a Mis ofertas
            </Link>

            <h1 className="mt-4 text-2xl sm:text-3xl font-bold text-slate-900">Detalle de oferta</h1>
            <p className="mt-1 text-sm text-slate-600">
              Vista temporal. Próximamente verás aquí el detalle completo, postulaciones y métricas.
            </p>
          </div>

          <div className="flex gap-2">
            <Link
              href={`${routes.dashboard.company.jobs}/${jobId}/edit` as any}
              className="inline-flex items-center justify-center rounded-2xl bg-blue-700 px-4 py-2.5 text-white text-sm font-semibold hover:bg-blue-800 transition"
            >
              Editar
            </Link>
          </div>
        </header>

        <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
            <div>
              <p className="text-sm font-semibold text-slate-900">Oferta</p>
              <p className="text-sm text-slate-600">
                ID: <span className="font-mono text-slate-800">{jobId}</span>
              </p>
            </div>

            <span className="inline-flex items-center rounded-full border border-amber-200 bg-amber-50 px-3 py-1 text-xs font-semibold text-amber-900">
              En construcción
            </span>
          </div>

          <div className="mt-6 grid gap-4 sm:grid-cols-2">
            <div className="rounded-2xl border border-slate-100 bg-slate-50 p-4">
              <p className="text-sm font-semibold text-slate-900">Qué podrás ver aquí</p>
              <ul className="mt-2 space-y-2 text-sm text-slate-700 list-disc pl-5">
                <li>Detalle completo de la oferta (título, descripción, requisitos, beneficios).</li>
                <li>Ubicación, modalidad, tipo de empleo y rango salarial (si aplica).</li>
                <li>Estado (abierta/cerrada) y fecha de publicación.</li>
                <li>Vista previa tal como la ven los candidatos.</li>
              </ul>
            </div>

            <div className="rounded-2xl border border-slate-100 bg-slate-50 p-4">
              <p className="text-sm font-semibold text-slate-900">Próximas acciones</p>
              <ul className="mt-2 space-y-2 text-sm text-slate-700 list-disc pl-5">
                <li>Gestionar postulaciones (revisar CV, avanzar etapas, descartar).</li>
                <li>Ver métricas (vistas, clics, conversiones).</li>
                <li>Duplicar oferta y pausar/reactivar publicación.</li>
              </ul>

              <div className="mt-4 flex flex-col sm:flex-row gap-3">
                <Link
                  href={`${routes.dashboard.company.jobs}/${jobId}/edit` as any}
                  className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
                >
                  Ir a edición
                </Link>

                <Link
                  href={routes.dashboard.company.jobs as any}
                  className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white text-sm font-semibold hover:bg-slate-800 transition"
                >
                  Volver a Mis ofertas
                </Link>
              </div>
            </div>
          </div>

          <p className="mt-6 text-xs text-slate-500">
            Nota: esta pantalla es temporal y está diseñada para mantener una experiencia consistente
            mientras se implementa el módulo completo de gestión de ofertas.
          </p>
        </section>
      </div>
    </section>
  );
}
