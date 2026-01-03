import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Términos y Condiciones | EmpleosPeru',
  description: 'Condiciones generales de uso de la plataforma EmpleosPeru.',
};

export default function TerminosPage() {
  return (
    <div className="bg-slate-50">
      <main className="max-w-3xl mx-auto px-4 py-6 w-full">
        <h1 className="text-2xl font-bold text-slate-900 mb-4">
          Términos y Condiciones
        </h1>

        <p className="text-sm text-slate-500 mb-6">
          Versión preliminar (muestra temporal)
        </p>

        <div className="mb-6 rounded-xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-900">
          ⚠️ Esta sección es una muestra temporal. El documento final se publicará antes del
          lanzamiento.
        </div>

<section className="space-y-4 text-sm text-slate-700">
  <p>
    Los presentes <strong>Términos y Condiciones</strong> regulan el acceso y uso de la plataforma
    <strong> EmpleosPeru</strong>, un portal digital orientado a facilitar la conexión entre
    candidatos y empleadores en el territorio peruano.
  </p>

  <p>
    EmpleosPeru actúa exclusivamente como <strong>intermediario tecnológico</strong> y no participa
    en los procesos de selección, contratación o acuerdos laborales que se puedan generar entre los
    usuarios de la plataforma.
  </p>

  <h2 className="text-lg font-semibold mt-6">
    Resumen informativo (versión preliminar)
  </h2>

  <div className="rounded-xl border border-slate-200 bg-white p-4">
    <div className="space-y-3">
      <p className="line-clamp-3">
        <strong>1. Uso de la plataforma:</strong> Los usuarios pueden crear cuentas, gestionar su
        perfil, publicar o postular a ofertas laborales y comunicarse dentro de los alcances
        habilitados por el sistema.
      </p>

      <p className="line-clamp-3">
        <strong>2. Registro y veracidad:</strong> El usuario es responsable de proporcionar
        información veraz, actualizada y completa, así como de mantener la confidencialidad de sus
        credenciales de acceso.
      </p>

      <p className="line-clamp-3">
        <strong>3. Responsabilidades:</strong> Los empleadores se obligan a publicar ofertas reales y
        lícitas. Los candidatos se comprometen a utilizar la plataforma únicamente con fines
        laborales legítimos.
      </p>

      <p className="line-clamp-3">
        <strong>4. Datos personales:</strong> El tratamiento de la información personal se rige por
        la legislación peruana vigente, en especial la Ley N.º 29733 – Ley de Protección de Datos
        Personales.
      </p>

      <p className="line-clamp-3">
        <strong>5. Limitación de responsabilidad:</strong> EmpleosPeru no se responsabiliza por la
        veracidad del contenido publicado por los usuarios ni por los acuerdos celebrados fuera de
        la plataforma.
      </p>
    </div>

    <div className="mt-4 border-t border-slate-100 pt-3 text-xs text-slate-500">
      Este resumen tiene carácter informativo y no constituye el documento contractual definitivo.
    </div>
  </div>

  <h2 className="text-lg font-semibold mt-6">Vigencia</h2>
  <p>
    La versión final y completa de los Términos y Condiciones será publicada antes del lanzamiento
    oficial de la plataforma. El uso continuo de EmpleosPeru implicará la aceptación de dichos
    términos una vez vigentes.
  </p>

  <h2 className="text-lg font-semibold mt-6">Contacto</h2>
  <p>
    Para cualquier consulta relacionada con estos términos, puedes escribirnos a:
    <br />
    <strong>soporte@empleosperu.com</strong>
  </p>
</section>

      </main>
    </div>
  );
}
