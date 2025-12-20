'use client';

export default function CompanyNotificationsPage() {
  return (
    <section className="flex flex-col flex-1 min-h-0">
      <div className="max-w-6xl mx-auto w-full px-4 sm:px-6 py-8">
        <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
          Notificaciones
        </h1>
        <p className="mt-2 text-slate-600">
          Próximamente: alertas de postulaciones y estado de ofertas.
        </p>

        <div className="mt-6 rounded-2xl border border-slate-100 bg-white p-6 shadow-sm">
          <p className="text-sm text-slate-700">
            mensaje temporal: Esta sección quedará lista cuando conectemos con el backend
          </p>
        </div>
      </div>
    </section>
  );
}
