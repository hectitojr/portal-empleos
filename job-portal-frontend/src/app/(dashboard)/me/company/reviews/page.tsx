import { Star, Sparkles } from 'lucide-react';

export default function CompanyReviewsPage() {
  return (
    <section role="region" aria-label="Mis evaluaciones" className="flex flex-col flex-1 min-h-0">
      <div className="flex-1 min-h-0">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 py-8 space-y-6">
          <header className="bg-white rounded-2xl border border-slate-100 shadow-sm p-6">
            <div className="flex items-start gap-4">
              <div className="shrink-0 w-12 h-12 rounded-2xl bg-blue-50 flex items-center justify-center">
                <Star className="w-6 h-6 text-blue-700" aria-hidden="true" />
              </div>

              <div className="min-w-0">
                <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">Mis evaluaciones</h1>
                <p className="mt-1 text-slate-600">
                  Aquí verás evaluaciones relacionadas a tu empresa y actividad dentro del portal (formato profesional).
                </p>
              </div>
            </div>
          </header>

          <section className="bg-white rounded-2xl border border-slate-100 shadow-sm overflow-hidden">
            <div className="p-6 sm:p-8">
              <div className="flex items-center gap-2 text-sm font-semibold text-slate-700">
                <Sparkles className="w-4 h-4 text-slate-500" aria-hidden="true" />
                Próximamente
              </div>

              <h2 className="mt-2 text-lg sm:text-xl font-semibold text-slate-900">
                Estamos preparando tu área de evaluaciones
              </h2>

              <p className="mt-2 text-slate-600">
                Esta sección se implementará en una siguiente iteración del MVP. Centralizaremos el historial con foco
                en calidad y trazabilidad.
              </p>

              <div className="mt-6 grid gap-3 sm:grid-cols-2">
                <div className="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                  <p className="text-sm font-semibold text-slate-900">Resumen</p>
                  <p className="mt-1 text-sm text-slate-600">Indicadores y actividad relevante.</p>
                </div>
                <div className="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                  <p className="text-sm font-semibold text-slate-900">Detalle</p>
                  <p className="mt-1 text-sm text-slate-600">Explorar evaluaciones por contexto.</p>
                </div>
              </div>
            </div>

            <div className="px-6 sm:px-8 py-4 border-t border-slate-100 bg-white">
              <p className="text-xs sm:text-sm text-slate-500">
                Nota: esta pantalla es temporal. No afecta tu sesión ni tu navegación dentro del dashboard.
              </p>
            </div>
          </section>
        </div>
      </div>
    </section>
  );
}
