import Link from 'next/link';
import type { Metadata } from 'next';
import { routes } from '@/lib/routes';

export const metadata: Metadata = {
  title: 'Editar oferta | EmpleosPeru',
};

export default async function CompanyJobEditPage({
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
              href={`${routes.dashboard.company.jobs}/${jobId}` as any}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              ← Volver al detalle
            </Link>

            <h1 className="mt-4 text-2xl sm:text-3xl font-bold text-slate-900">Editar oferta</h1>
            <p className="mt-1 text-sm text-slate-600">
              Pantalla temporal. La edición completa estará disponible próximamente.
            </p>
          </div>

          <div className="flex gap-2">
            <Link
              href={routes.dashboard.company.jobs as any}
              className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white text-sm font-semibold hover:bg-slate-800 transition"
            >
              Mis ofertas
            </Link>
          </div>
        </header>

        <section className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
            <div>
              <p className="text-sm font-semibold text-slate-900">Edición</p>
              <p className="text-sm text-slate-600">
                Oferta ID: <span className="font-mono text-slate-800">{jobId}</span>
              </p>
            </div>

            <span className="inline-flex items-center rounded-full border border-amber-200 bg-amber-50 px-3 py-1 text-xs font-semibold text-amber-900">
              En construcción
            </span>
          </div>

          <div className="mt-6 rounded-2xl border border-slate-100 bg-slate-50 p-4">
            <p className="text-sm font-semibold text-slate-900">Qué incluirá el editor</p>

            <div className="mt-3 grid gap-3 sm:grid-cols-2">
              <div className="rounded-2xl bg-white border border-slate-100 p-4">
                <p className="text-sm font-semibold text-slate-900">Contenido</p>
                <p className="mt-1 text-sm text-slate-600">
                  Título, descripción, requisitos, beneficios, tags y texto de postulación rápida.
                </p>
              </div>

              <div className="rounded-2xl bg-white border border-slate-100 p-4">
                <p className="text-sm font-semibold text-slate-900">Configuración</p>
                <p className="mt-1 text-sm text-slate-600">
                  Ubicación, modalidad, tipo de empleo, seniority, salario (opcional) y estado.
                </p>
              </div>

              <div className="rounded-2xl bg-white border border-slate-100 p-4">
                <p className="text-sm font-semibold text-slate-900">Validaciones</p>
                <p className="mt-1 text-sm text-slate-600">
                  Reglas de negocio en backend + validación UX en frontend para evitar errores.
                </p>
              </div>

              <div className="rounded-2xl bg-white border border-slate-100 p-4">
                <p className="text-sm font-semibold text-slate-900">Publicación</p>
                <p className="mt-1 text-sm text-slate-600">
                  Guardado incremental, vista previa y control de apertura/cierre de la oferta.
                </p>
              </div>
            </div>
          </div>

          <div className="mt-6 flex flex-col sm:flex-row gap-3">
            <Link
              href={`${routes.dashboard.company.jobs}/${jobId}` as any}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              Ver detalle temporal
            </Link>

            <Link
              href={routes.dashboard.company.jobs as any}
              className="inline-flex items-center justify-center rounded-2xl bg-blue-700 px-4 py-2.5 text-white text-sm font-semibold hover:bg-blue-800 transition"
            >
              Volver a Mis ofertas
            </Link>
          </div>

          <p className="mt-6 text-xs text-slate-500">
            Nota: esta vista evita enlaces rotos y mantiene el flujo del dashboard mientras el editor
            se implementa.
          </p>
        </section>
      </div>
    </section>
  );
}
