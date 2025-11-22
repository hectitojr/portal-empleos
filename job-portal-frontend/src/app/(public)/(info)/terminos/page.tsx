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
            Estos Términos y Condiciones regulan el acceso y uso de la plataforma{' '}
            <strong>EmpleosPeru</strong>, que facilita la conexión entre personas que
            buscan empleo y empresas que ofrecen oportunidades laborales en el Perú.
          </p>
        </header>

        <div className="prose prose-sm sm:prose-base max-w-none text-slate-800">
          <h2>1. Objeto de la Plataforma</h2>
          <p>
            <strong>EmpleosPeru</strong> es una plataforma digital de intermediación
            laboral que permite a personas que buscan empleo (“Usuarios” o
            “Candidatos”) registrarse, gestionar su perfil profesional, postular a
            ofertas de empleo y comunicarse con empresas o entidades empleadoras
            (“Empleadores”). EmpleosPeru no es empleador, agencia de contratación, ni
            garantiza la obtención de un empleo.
          </p>

          <h2>2. Aceptación de los Términos</h2>
          <p>
            El acceso, navegación y uso de EmpleosPeru implican la aceptación plena,
            expresa e incondicional de estos Términos y Condiciones, así como de la
            Política de Privacidad y cualquier documento adicional que EmpleosPeru
            publique como parte del servicio. Si no estás de acuerdo con estos
            términos, debes abstenerte de utilizar la Plataforma.
          </p>

          <h2>3. Registro del Usuario</h2>
          <p>
            Para acceder a determinadas funcionalidades, el Usuario debe crear una
            cuenta proporcionando información veraz, actualizada y completa. El
            Usuario es responsable de:
          </p>
          <ul>
            <li>Mantener la confidencialidad de sus credenciales de acceso.</li>
            <li>
              Notificar a EmpleosPeru sobre cualquier uso no autorizado de su cuenta.
            </li>
            <li>
              Toda actividad realizada desde su cuenta, aun cuando delegue el uso a
              terceros.
            </li>
          </ul>

          <h2>4. Obligaciones del Usuario Candidato</h2>
          <p>El Usuario se compromete a:</p>
          <ul>
            <li>
              Proporcionar información auténtica, verificable y actualizada en su
              perfil, CV y postulaciones.
            </li>
            <li>
              No publicar contenido ofensivo, ilegal, difamatorio, discriminatorio o
              inapropiado.
            </li>
            <li>
              No suplantar la identidad de terceros ni utilizar datos personales sin
              autorización.
            </li>
            <li>
              Utilizar la Plataforma únicamente con fines laborales legítimos y
              permitidos por la ley.
            </li>
            <li>
              No realizar acciones que afecten la seguridad, estabilidad o
              funcionamiento de la Plataforma.
            </li>
          </ul>

          <h2>5. Obligaciones de los Empleadores</h2>
          <p>
            Los Empleadores que publiquen ofertas de trabajo en EmpleosPeru se
            comprometen a:
          </p>
          <ul>
            <li>
              Publicar ofertas reales, vigentes y que cumplan con la normativa laboral
              peruana.
            </li>
            <li>
              No solicitar pagos, depósitos, compras o adelantos económicos a los
              Candidatos como condición para postular o ser contratados.
            </li>
            <li>
              Respetar los datos personales de los Candidatos conforme a la Ley N.º
              29733 – Ley de Protección de Datos Personales.
            </li>
            <li>
              Brindar información clara y veraz sobre funciones, horarios,
              remuneraciones y condiciones de empleo, cuando corresponda.
            </li>
            <li>
              No incurrir en prácticas discriminatorias contrarias a la legislación
              peruana.
            </li>
          </ul>

          <h2>6. Contenido generado por los Usuarios</h2>
          <p>
            La información, comentarios, ofertas, mensajes y demás contenido publicado
            por Usuarios (Candidatos o Empleadores) es de responsabilidad exclusiva de
            quien lo genera. EmpleosPeru no garantiza la exactitud, integridad o
            veracidad de dicho contenido.
          </p>
          <p>
            EmpleosPeru se reserva el derecho de revisar, moderar, editar o eliminar
            contenido que considere inapropiado, ofensivo, ilegal, engañoso o contrario
            a estos Términos y a la legislación aplicable.
          </p>

          <h2>7. Uso permitido de la información</h2>
          <p>
            El Usuario autoriza a EmpleosPeru a utilizar la información que ingrese en
            la Plataforma únicamente para:
          </p>
          <ul>
            <li>La intermediación laboral y gestión de postulaciones.</li>
            <li>
              La mejora, mantenimiento y desarrollo de funcionalidades de la
              Plataforma.
            </li>
            <li>
              El análisis estadístico interno, siempre que la información se utilice de
              forma agregada o anonimizada cuando sea posible.
            </li>
          </ul>
          <p>
            EmpleosPeru no venderá ni comercializará la información personal de los
            Usuarios para fines ajenos a la prestación del servicio, según lo
            establecido en la Política de Privacidad.
          </p>

          <h2>8. Prohibiciones específicas</h2>
          <p>En EmpleosPeru queda estrictamente prohibido:</p>
          <ul>
            <li>Publicar ofertas falsas, engañosas o inexistentes.</li>
            <li>
              Enviar spam, cadenas de mensajes o comunicaciones comerciales no
              solicitadas a otros Usuarios.
            </li>
            <li>
              Intentar vulnerar la seguridad, integridad o disponibilidad de la
              Plataforma, sus sistemas o bases de datos.
            </li>
            <li>
              Utilizar la Plataforma con fines ilícitos, fraudulentos o contrarios a la
              moral y buenas costumbres.
            </li>
            <li>
              Crear múltiples cuentas para manipular procesos de selección, rankings o
              estadísticas.
            </li>
          </ul>

          <h2>9. Propiedad intelectual</h2>
          <p>
            El diseño, código fuente, logotipos, marcas, nombres comerciales,
            elementos gráficos y demás contenidos propios de EmpleosPeru son de
            propiedad exclusiva de la Plataforma o de terceros licenciantes, y se
            encuentran protegidos por la normativa de propiedad intelectual vigente.
          </p>
          <p>
            El Usuario no adquiere ningún derecho de propiedad intelectual por el uso
            de la Plataforma y se compromete a no reproducir, distribuir, modificar ni
            explotar dichos contenidos sin autorización previa y por escrito de sus
            titulares.
          </p>

          <h2>10. Responsabilidad y limitaciones</h2>
          <p>
            EmpleosPeru no garantiza que el Usuario obtendrá un empleo ni que las
            ofertas publicadas cumplan en todos los casos con las expectativas del
            Candidato. En tal sentido, EmpleosPeru no será responsable por:
          </p>
          <ul>
            <li>
              La veracidad, exactitud o actualización de la información publicada por
              Candidatos o Empleadores.
            </li>
            <li>
              Negociaciones, acuerdos, entrevistas, contrataciones o decisiones que se
              realicen fuera de la Plataforma.
            </li>
            <li>
              Daños o perjuicios derivados del uso o imposibilidad de uso de la
              Plataforma.
            </li>
            <li>
              Interacciones, conflictos o controversias entre Usuarios que excedan el
              ámbito de la intermediación realizada por EmpleosPeru.
            </li>
          </ul>

          <h2>11. Suspensión o cancelación de cuentas</h2>
          <p>
            EmpleosPeru podrá suspender temporalmente, limitar funcionalidades o
            cancelar de manera definitiva la cuenta de un Usuario en caso de:
          </p>
          <ul>
            <li>Incumplimiento de estos Términos y Condiciones.</li>
            <li>
              Sospecha de uso fraudulento, engañoso, malicioso o contrario a la ley.
            </li>
            <li>Requerimiento de autoridades competentes.</li>
          </ul>
          <p>
            La suspensión o cancelación de la cuenta no generará derecho a
            indemnización alguna a favor del Usuario.
          </p>

          <h2>12. Enlaces a sitios de terceros</h2>
          <p>
            La Plataforma puede incluir enlaces a sitios web de terceros. EmpleosPeru
            no se responsabiliza por el contenido, políticas o prácticas de dichos
            sitios externos. El acceso a sitios de terceros es responsabilidad del
            Usuario.
          </p>

          <h2>13. Protección de datos personales</h2>
          <p>
            El tratamiento de los datos personales de los Usuarios se rige por la{' '}
            <strong>Política de Privacidad de EmpleosPeru</strong>, la cual forma
            parte integrante de estos Términos y Condiciones. Al utilizar la
            Plataforma, el Usuario declara haber leído y aceptado dicha Política.
          </p>

          <h2>14. Modificaciones a los Términos y Condiciones</h2>
          <p>
            EmpleosPeru podrá modificar o actualizar estos Términos y Condiciones en
            cualquier momento. Las modificaciones entrarán en vigencia desde su
            publicación en la Plataforma. El uso continuado de EmpleosPeru tras la
            publicación de cambios implicará la aceptación de los mismos.
          </p>

          <h2>15. Legislación aplicable y jurisdicción</h2>
          <p>
            Estos Términos y Condiciones se rigen por las leyes de la República del
            Perú. Cualquier controversia derivada de la interpretación o ejecución de
            este documento será sometida a la jurisdicción de los tribunales
            competentes de la ciudad de Lima, Perú.
          </p>

          <h2>16. Contacto</h2>
          <p>
            Si tienes consultas relacionadas con estos Términos y Condiciones, puedes
            comunicarte con nosotros a:
            <br />
            <strong>soporte@empleosperu.com</strong>
          </p>
        </div>
      </div>
    </section>
  );
}
