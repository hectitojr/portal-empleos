export default function CompanyProfileSetupPage() {
  return (
    <section className="min-h-[calc(100vh-4rem)] bg-slate-50 px-4 py-8">
      <div className="max-w-4xl mx-auto bg-white rounded-2xl shadow-sm border border-slate-100 p-6 sm:p-8">
        <header className="mb-6">
          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
            Configura el perfil de tu empresa
          </h1>
          <p className="mt-2 text-sm sm:text-base text-slate-600">
            Completa los datos de tu empresa para poder publicar ofertas y
            gestionar postulaciones.
          </p>
        </header>

        <p className="text-sm text-slate-500">
          (Placeholder inicial) Luego aquí conectaremos el módulo{' '}
          <strong>companies</strong> de tu backend para gestionar la ficha de
          empresa.
        </p>
      </div>
    </section>
  );
}
