import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Acerca de | EmpleosPeru',
  description: 'Conoce la misión, visión y enfoque de EmpleosPeru como portal de empleos.',
};

export default function AcercaPage() {
  return (
    <section className="bg-slate-50">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-10 sm:py-14">
        <header className="mb-8 text-center">
          <h1 className="text-3xl sm:text-4xl font-bold text-slate-900 mb-3">
            Acerca de EmpleosPeru
          </h1>
          <p className="text-slate-600 max-w-2xl mx-auto">
            EmpleosPeru es un portal pensado para conectar talento con oportunidades
            reales de trabajo, con un enfoque simple, transparente y centrado en la experiencia
            de usuarios postulantes y empresas.
          </p>
        </header>

        <div className="space-y-10 text-slate-700 text-sm sm:text-base">
          <section>
            <h2 className="text-xl font-semibold text-slate-900 mb-2">
              Nuestra misión
            </h2>
            <p>
              Facilitar el proceso de búsqueda de empleo y la gestión de procesos
              de selección, ofreciendo una plataforma clara, ordenada y confiable,
              que permita a las personas encontrar oportunidades alineadas con su perfil
              y a las empresas identificar candidatos de forma más eficiente.
            </p>
          </section>

          <section>
            <h2 className="text-xl font-semibold text-slate-900 mb-2">
              Nuestro enfoque
            </h2>
            <p className="mb-3">
              El producto está diseñado desde una perspectiva práctica: primero un MVP
              sólido y mantenible, y luego iteraciones que agregan valor de manera
              incremental. La prioridad es ofrecer una herramienta estable, usable
              y enfocada en lo esencial del proceso de reclutamiento.
            </p>
            <ul className="list-disc pl-5 space-y-1">
              <li>Experiencia cuidada para postulantes y empresas.</li>
              <li>Información de ofertas clara y estructurada.</li>
              <li>Flujos simples para postular y gestionar candidaturas.</li>
            </ul>
          </section>

          <section>
            <h2 className="text-xl font-semibold text-slate-900 mb-2">
              Próximos pasos
            </h2>
            <p>
              A medida que la plataforma evolucione, se irán incorporando nuevas
              funcionalidades, como herramientas para seguimiento de procesos,
              filtros avanzados, notificaciones inteligentes y paneles específicos
              por tipo de usuario.
            </p>
          </section>
        </div>
      </div>
    </section>
  );
}
