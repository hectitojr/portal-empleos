export default function ApplicantProfileSetupPage() {
  return (
    <section className="min-h-[calc(100vh-4rem)] bg-slate-50 px-4 py-8">
      <div className="max-w-4xl mx-auto bg-white rounded-2xl shadow-sm border border-slate-100 p-6 sm:p-8">
        <header className="mb-6">
          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
            Configura tu perfil de postulante
          </h1>
          <p className="mt-2 text-sm sm:text-base text-slate-600">
            Aquí podrás completar tu información profesional, experiencia,
            educación y habilidades para postular a empleos.
          </p>
        </header>

        <p className="text-sm text-slate-500">
          Más adelante aquí conectaremos los formularios
          reales del módulo <strong>applicants</strong> del backend.
        </p>
      </div>
    </section>
  );
}
