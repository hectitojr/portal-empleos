import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Accesibilidad | EmpleosPeru',
  description: 'Compromiso de EmpleosPeru con la accesibilidad y la inclusión en la plataforma.',
};

export default function AccesibilidadPage() {
  return (
    <section className="bg-slate-50">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10 sm:py-14">
        <header className="mb-8 text-center">
          <h1 className="text-3xl sm:text-4xl font-bold text-slate-900 mb-3">
            Accesibilidad en EmpleosPeru
          </h1>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Nuestro objetivo es que EmpleosPeru pueda ser utilizado por la mayor
            cantidad posible de personas, independientemente de sus capacidades,
            dispositivos o contexto de uso.
          </p>
        </header>

        <div className="space-y-8 text-sm sm:text-base text-slate-700">
          <section>
            <h2 className="text-lg font-semibold text-slate-900 mb-2">
              Principios de accesibilidad
            </h2>
            <p className="mb-3">
              La plataforma se diseña teniendo en cuenta buenas prácticas de accesibilidad web,
              con el objetivo de alinearse progresivamente a las recomendaciones de las
              Web Content Accessibility Guidelines (WCAG).
            </p>
            <ul className="list-disc pl-5 space-y-1">
              <li>Uso de etiquetas semánticas en las páginas y formularios.</li>
              <li>Contrastes de color pensados para mejorar la legibilidad.</li>
              <li>Compatibilidad con navegación por teclado siempre que sea posible.</li>
              <li>Texto alternativo en elementos clave de la interfaz.</li>
            </ul>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-slate-900 mb-2">
              Mejoras continuas
            </h2>
            <p>
              La accesibilidad es un proceso en evolución. A medida que la aplicación
              crece, se revisan componentes, flujos y patrones de diseño para reducir
              barreras y hacer más sencillo el uso para todas las personas.
            </p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-slate-900 mb-2">
              Comentarios y sugerencias
            </h2>
            <p className="mb-3">
              Si detectas algún problema de accesibilidad o tienes sugerencias para
              mejorar la experiencia, te invitamos a escribirnos.
            </p>
            <a
              href="/contacto"
              className="inline-flex items-center justify-center rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-5 py-2.5 transition"
            >
              Enviar sugerencia
            </a>
          </section>
        </div>
      </div>
    </section>
  );
}
