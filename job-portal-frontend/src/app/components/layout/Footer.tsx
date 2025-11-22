import Link from 'next/link';
import { routes } from '@/lib/routes';

export default function Footer() {
  return (
    <footer className="bg-slate-900 text-slate-300" role="contentinfo">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-5 flex flex-col justify-between h-full">

        {/* Links */}
        <div className="flex items-center justify-center">
          <nav aria-label="Footer menu">
            <ul className="flex flex-wrap justify-center gap-6 text-sm text-slate-300">
              <li>
                <Link href={routes.public.help} className="hover:text-white transition-colors">
                  Centro de Ayuda
                </Link>
              </li>
              <li>
                <Link href={routes.public.contact} className="hover:text-white transition-colors">
                  Contacto
                </Link>
              </li>
              <li>
                <Link href={routes.public.about} className="hover:text-white transition-colors">
                  Acerca de
                </Link>
              </li>
              <li>
                <Link
                  href={routes.public.accessibility}
                  className="hover:text-white transition-colors"
                >
                  Accesibilidad en EmpleosPeru
                </Link>
              </li>
              <li>
                <Link href={routes.public.terms} className="hover:text-white transition-colors">
                  Términos y Condiciones
                </Link>
              </li>
            </ul>
          </nav>
        </div>

        {/* Divider */}
        <div className="my-4 border-t border-slate-800/70" />

        {/* Copyright */}
        <div className="flex items-center justify-center py-2">
          <p className="text-center text-xs sm:text-sm text-slate-400">
            © 2025 EmpleosPeru. Todos los derechos reservados.
          </p>
        </div>
      </div>
    </footer>
  );
}
