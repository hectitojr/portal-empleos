export default function CompanyHomePage() {
  return (
    <section
      aria-label="Panel de la empresa"
      className="space-y-6"
    >
      <header>
        <h1 className="text-2xl font-bold text-slate-900">
          Panel de la empresa
        </h1>
        <p className="mt-1 text-slate-600">
          Aquí administrarás tus ofertas, postulaciones y perfil de empresa.
        </p>
      </header>

      <div className="grid gap-6 md:grid-cols-3">
        <section className="md:col-span-2 p-6 bg-white rounded-2xl shadow-sm border border-slate-100">
          <h2 className="text-lg font-semibold text-slate-900 mb-2">
            Próximos pasos
          </h2>
          <p className="text-sm text-slate-600 mb-3">
            Cuando integremos el módulo de <strong>companies</strong>,
            desde aquí podrás:
          </p>
          <ul className="text-sm text-slate-600 space-y-1 list-disc pl-5">
            <li>Completar el perfil de tu empresa.</li>
            <li>Publicar nuevas ofertas de empleo.</li>
            <li>Revisar y gestionar postulaciones recibidas.</li>
          </ul>
        </section>

        <aside className="p-6 bg-white rounded-2xl shadow-sm border border-slate-100">
          <h3 className="text-sm font-semibold text-slate-900 mb-2">
            Actividad reciente
          </h3>
          <p className="text-sm text-slate-600">
            Más adelante mostraremos aquí estadísticas básicas de tus
            publicaciones: vistas, postulaciones y estado de tus vacantes.
          </p>
        </aside>
      </div>
    </section>
  );
}
