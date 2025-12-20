import Link from 'next/link';
import { routes } from '@/lib/routes';

type FooterVariant = 'full' | 'minimal';

type Props = {
  variant?: FooterVariant;
};

export default function Footer({ variant = 'full' }: Props) {
  const isMinimal = variant === 'minimal';

  return (
    <footer className="bg-slate-900 text-slate-300" role="contentinfo">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col justify-center py-5">
        {!isMinimal && (
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
        )}

        {/* Divider (solo en full) */}
        {!isMinimal && <div className="my-4 border-t border-slate-800/70" />}

        {/* Copyright (siempre) */}
        <div className="flex items-center justify-center">
          <p className="text-center text-xs sm:text-sm text-slate-400">
            © 2025 EmpleosPeru. Todos los derechos reservados.
          </p>
        </div>
      </div>
    </footer>
  );
}
