import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Términos y Condiciones | EmpleosPeru',
  description: 'Condiciones generales de uso de la plataforma EmpleosPeru.',
};

export default function TerminosPage() {
  return (
    <section className="bg-slate-50">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-10 sm:py-14">
        <header className="mb-8">
          <h1 className="text-3xl sm:text-4xl font-bold text-slate-900 mb-3">
            Términos y Condiciones de Uso
          </h1>
          <p className="text-slate-600 max-w-2xl">
            Esta sección resume las condiciones generales para el uso de EmpleosPeru
            como portal de empleos. El contenido podrá ser ajustado y complementado
            posteriormente según los requerimientos legales aplicables.
          </p>
        </header>

        <div className="prose prose-sm sm:prose-base max-w-none text-slate-800">
          <h2>1. Aceptación de los términos</h2>
          <p>
            Al registrarte, acceder o utilizar EmpleosPeru, aceptas estos Términos y
            Condiciones. Si no estás de acuerdo con alguno de los puntos, deberás
            abstenerte de utilizar la plataforma.
          </p>

          <h2>2. Uso de la plataforma</h2>
          <p>
            EmpleosPeru se ofrece como un medio para publicar ofertas de empleo y gestionar
            postulaciones. El contenido publicado por empresas y personas usuarias es de
            su exclusiva responsabilidad. La plataforma se reserva el derecho de moderar o
            retirar contenido que considere inadecuado.
          </p>

          <h2>3. Cuentas de usuario</h2>
          <p>
            Cada persona usuaria es responsable de la confidencialidad de sus credenciales
            de acceso y de toda actividad realizada con su cuenta. Se recomienda utilizar
            contraseñas seguras y activar mecanismos de seguridad adicionales cuando estén
            disponibles.
          </p>

          <h2>4. Publicación de ofertas y postulaciones</h2>
          <p>
            Las empresas se comprometen a publicar ofertas veraces y actualizadas.
            Las personas postulantes declaran que la información contenida en su perfil
            y postulaciones es real, precisa y se encuentra debidamente actualizada.
          </p>

          <h2>5. Datos personales y privacidad</h2>
          <p>
            El tratamiento de datos personales se rige por la Política de Privacidad
            de EmpleosPeru. Te recomendamos revisar dicha política para entender cómo se
            recopila, utiliza y protege tu información.
          </p>
          <p>
            Ciertas funcionalidades pueden requerir el tratamiento de datos adicionales,
            lo cual será informado de manera clara en los flujos correspondientes.
          </p>

          <h2>6. Limitación de responsabilidad</h2>
          <p>
            EmpleosPeru se ofrece &quot;tal cual&quot; y dentro de los límites que permita la
            normativa aplicable. La plataforma no garantiza en forma absoluta la disponibilidad
            continua del servicio ni la obtención de un empleo concreto como resultado
            del uso de la misma.
          </p>

          <h2>7. Modificaciones</h2>
          <p>
            Estos Términos y Condiciones pueden ser actualizados en cualquier momento.
            Cuando se realicen cambios relevantes, se procurará informar a las personas
            usuarias a través de la propia plataforma.
          </p>

          <h2>8. Contacto</h2>
          <p>
            Si tienes consultas relacionadas con estos Términos y Condiciones, puedes
            contactarnos a través de la página de <a href="/contacto">Contacto</a>.
          </p>
        </div>
      </div>
    </section>
  );
}
