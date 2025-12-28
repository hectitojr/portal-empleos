import { Briefcase, Sparkles } from 'lucide-react';

export default function ApplicantJobsPage() {
  return (
    <section
      role="region"
      aria-label="Mis empleos"
      className="flex flex-col flex-1 min-h-0"
    >
      <div className="flex-1 min-h-0">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 py-8 space-y-6">
          {/* Header */}
          <header className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
            <div className="flex items-start gap-4">
              <div className="shrink-0 w-12 h-12 rounded-2xl bg-blue-50 flex items-center justify-center">
                <Briefcase className="w-6 h-6 text-blue-700" aria-hidden="true" />
              </div>

              <div className="min-w-0">
                <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
                  Mis empleos
                </h1>
                <p className="mt-1 text-slate-600">
                  Aquí podrás gestionar tus empleos guardados, postulaciones y procesos activos.
                </p>
              </div>
            </div>
          </header>

          {/* Placeholder */}
          <section className="bg-white rounded-2xl border border-slate-100 shadow-sm overflow-hidden">
            <div className="p-6 sm:p-8">
              <div className="flex items-center gap-2 text-sm font-semibold text-slate-700">
                <Sparkles className="w-4 h-4 text-slate-500" aria-hidden="true" />
                Próximamente
              </div>

              <h2 className="mt-2 text-lg sm:text-xl font-semibold text-slate-900">
                Estamos construyendo tu espacio de seguimiento laboral
              </h2>

              <p className="mt-2 text-slate-600">
                En esta sección podrás revisar y gestionar:
              </p>

              <ul className="mt-4 grid gap-3 sm:grid-cols-2 text-sm text-slate-700">
                <li className="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                  <span className="font-semibold">Empleos guardados</span>
                  <p className="mt-1 text-slate-600">
                    Ofertas que marcaste para revisar luego.
                  </p>
                </li>
                <li className="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                  <span className="font-semibold">Postulaciones</span>
                  <p className="mt-1 text-slate-600">
                    Historial y estado de tus aplicaciones.
                  </p>
                </li>
                <li className="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                  <span className="font-semibold">Entrevistas</span>
                  <p className="mt-1 text-slate-600">
                    Procesos activos y coordinaciones con empresas.
                  </p>
                </li>
                <li className="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                  <span className="font-semibold">Archivo</span>
                  <p className="mt-1 text-slate-600">
                    Empleos cerrados o finalizados.
                  </p>
                </li>
              </ul>
            </div>

            <div className="px-6 sm:px-8 py-4 border-t border-slate-100 bg-white">
              <p className="text-xs sm:text-sm text-slate-500">
                Nota: esta es una vista temporal. El contenido real se implementará en
                una siguiente iteración del producto.
              </p>
            </div>
          </section>
        </div>
      </div>
    </section>
  );
}
