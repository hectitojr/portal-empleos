import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Contacto | EmpleosPeru',
  description: 'Ponte en contacto con el equipo de EmpleosPeru para soporte, consultas y sugerencias.',
};

export default function ContactoPage() {
  return (
    <section className="bg-slate-50">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10 sm:py-14">
        <header className="mb-8 text-center">
          <h1 className="text-3xl sm:text-4xl font-bold text-slate-900 mb-3">
            Contacto
          </h1>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Si tienes dudas, sugerencias o necesitas soporte con tu cuenta,
            completa el siguiente formulario. Responderemos a la brevedad posible.
          </p>
        </header>

        <section
          aria-label="Formulario de contacto"
          className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6 sm:p-8"
        >
          <form className="space-y-6" noValidate>
            <div className="grid gap-4 sm:grid-cols-2">
              <div className="space-y-1">
                <label htmlFor="contact-name" className="text-sm font-medium text-slate-700">
                  Nombre completo
                </label>
                <input
                  id="contact-name"
                  name="name"
                  type="text"
                  className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500"
                  placeholder="Tu nombre"
                />
              </div>

              <div className="space-y-1">
                <label htmlFor="contact-email" className="text-sm font-medium text-slate-700">
                  Correo electrónico
                </label>
                <input
                  id="contact-email"
                  name="email"
                  type="email"
                  autoComplete="email"
                  className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500"
                  placeholder="tu@email.com"
                />
              </div>
            </div>

            <div className="space-y-1">
              <label htmlFor="contact-type" className="text-sm font-medium text-slate-700">
                Motivo de contacto
              </label>
              <select
                id="contact-type"
                name="type"
                className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500"
              >
                <option value="">Selecciona una opción</option>
                <option value="support">Soporte / Problemas con la plataforma</option>
                <option value="feedback">Sugerencias y comentarios</option>
                <option value="business">Consultas comerciales</option>
                <option value="other">Otro</option>
              </select>
            </div>

            <div className="space-y-1">
              <label htmlFor="contact-message" className="text-sm font-medium text-slate-700">
                Mensaje
              </label>
              <textarea
                id="contact-message"
                name="message"
                rows={5}
                className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 resize-y"
                placeholder="Cuéntanos brevemente en qué podemos ayudarte."
              />
            </div>

            <div className="flex items-center justify-between gap-4 flex-wrap">
              <p className="text-xs text-slate-500">
                Al enviar este formulario aceptas que podamos contactar contigo
                utilizando los datos proporcionados.
              </p>
              <button
                type="submit"
                className="inline-flex items-center justify-center rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-6 py-2.5 transition"
              >
                Enviar mensaje
              </button>
            </div>
          </form>
        </section>
      </div>
    </section>
  );
}
