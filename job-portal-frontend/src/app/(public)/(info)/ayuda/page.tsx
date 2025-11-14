import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Centro de Ayuda | EmpleosPeru',
  description: 'Encuentra respuestas, guías y soporte para usar EmpleosPeru.',
};

export default function AyudaPage() {
  return (
    <section className="bg-slate-50">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-10 sm:py-14">
        <header className="mb-10 text-center">
          <h1 className="text-3xl sm:text-4xl font-bold text-slate-900 mb-3">
            Centro de Ayuda
          </h1>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Aquí encontrarás información general, respuestas a preguntas frecuentes
            y orientación para sacar el máximo provecho de EmpleosPeru, tanto si eres
            postulante como si gestionas ofertas de empleo como empresa.
          </p>
        </header>

        <div className="grid gap-8 lg:grid-cols-[2fr,1fr]">
          {/* Bloque principal */}
          <section
            aria-labelledby="faq-title"
            className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6 sm:p-8"
          >
            <h2 id="faq-title" className="text-xl font-semibold text-slate-900 mb-4">
              Preguntas frecuentes
            </h2>
            <div className="space-y-5 text-sm sm:text-base text-slate-700">
              <article>
                <h3 className="font-semibold text-slate-900 mb-1">
                  ¿Cómo crear una cuenta de postulante?
                </h3>
                <p>
                  Regístrate con tu correo electrónico y contraseña, confirma tu cuenta
                  y completa tu información profesional para empezar a postular a ofertas.
                  Más adelante podrás detallar experiencia, estudios y habilidades.
                </p>
              </article>

              <article>
                <h3 className="font-semibold text-slate-900 mb-1">
                  ¿Cómo publicar ofertas como empresa?
                </h3>
                <p>
                  Las empresas que creen una cuenta corporativa pueden publicar ofertas,
                  revisar postulaciones y gestionar procesos de selección desde su panel.
                  En esta sección iremos añadiendo guías paso a paso para el flujo completo.
                </p>
              </article>

              <article>
                <h3 className="font-semibold text-slate-900 mb-1">
                  ¿Qué hago si tengo problemas con mi cuenta?
                </h3>
                <p>
                  Si no puedes acceder, revisa primero la recuperación de contraseña.
                  Para casos puntuales (bloqueos, errores inesperados o dudas específicas),
                  puedes escribirnos desde la página de contacto.
                </p>
              </article>
            </div>
          </section>

          {/* Sidebar / enlaces rápidos */}
          <aside aria-label="Enlaces de soporte" className="space-y-4">
            <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
              <h2 className="text-sm font-semibold text-slate-900 mb-3">
                Secciones de ayuda
              </h2>
              <ul className="space-y-2 text-sm text-slate-700">
                <li>• Guías para postulantes</li>
                <li>• Guías para empresas</li>
                <li>• Gestión de cuenta y seguridad</li>
                <li>• Notificaciones y comunicaciones</li>
              </ul>
            </div>

            <div className="bg-slate-900 text-slate-50 rounded-2xl p-5">
              <h2 className="text-sm font-semibold mb-2">
                ¿No encontraste lo que buscabas?
              </h2>
              <p className="text-xs sm:text-sm mb-3 text-slate-200">
                Si necesitas ayuda específica sobre un proceso o encontraste un error,
                puedes ponerte en contacto con nosotros.
              </p>
              <a
                href="/contacto"
                className="inline-flex items-center justify-center rounded-xl bg-white text-slate-900 text-sm font-semibold px-4 py-2 hover:bg-slate-100 transition"
              >
                Ir a Contacto
              </a>
            </div>
          </aside>
        </div>
      </div>
    </section>
  );
}
