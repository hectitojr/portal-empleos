'use client';

export default function CompanyApplicationsPage() {
  return (
    <section className="flex flex-col flex-1 min-h-0">
      <div className="max-w-6xl mx-auto w-full px-4 sm:px-6 py-8">
        <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
          Postulaciones
        </h1>
        <p className="mt-2 text-slate-600">
          Próximamente: bandeja global y pipeline por oferta.
        </p>

        <div className="mt-6 rounded-2xl border border-slate-100 bg-white p-6 shadow-sm">
          <p className="text-sm text-slate-700">
            Esta sección quedará lista cuando conectemos endpoints de postulaciones y estados.
          </p>
        </div>
      </div>
    </section>
  );
}
