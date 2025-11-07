'use client';

import { type ReactNode, useEffect, useState } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import Link from 'next/link';
import { Briefcase } from 'lucide-react';

export default function PublicLayout({ children }: { children: ReactNode }) {
  const router = useRouter();
  const pathname = usePathname();
  const isLogin = pathname?.startsWith('/auth/login');

  const [activeHash, setActiveHash] = useState<string>(
    typeof window !== 'undefined' ? window.location.hash : ''
  );

  useEffect(() => {
    const sync = () => setActiveHash(window.location.hash);
    window.addEventListener('hashchange', sync);
    return () => window.removeEventListener('hashchange', sync);
  }, []);

  const itemBase = 'inline-flex h-16 items-center border-b-2 transition-colors px-1';
  const itemIdle = 'border-transparent text-[#595959] hover:text-[#2d2d2d] hover:border-[#2557a7]';
  const itemActive = 'border-[#2557a7] text-[#2d2d2d]';

  const inicioActive = pathname === '/';
  const empresasActive = activeHash === '#empresas';

  return (
    <div className="min-h-screen flex flex-col bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50">
      {/* Header fijo */}
      <header
        className="fixed top-0 left-0 right-0 bg-white z-50 shadow-sm"
        role="banner"
      >
        <div className="flex items-stretch justify-between h-16 px-6 md:px-8">
          <div className="flex items-stretch space-x-6">
            <button
              onClick={() => router.push('/')}
              className="flex items-center space-x-2 h-16"
              aria-label="Ir al inicio"
            >
              <Briefcase className="w-6 h-6" style={{ color: '#2557a7' }} aria-hidden="true" />
              <span className="text-2xl font-bold" style={{ color: '#2557a7' }}>
                empleospro
              </span>
            </button>

            <nav className="hidden md:flex items-stretch space-x-6" aria-label="Navegación principal">
              <Link
                href="/"
                aria-current={inicioActive ? 'page' : undefined}
                className={`${itemBase} ${inicioActive ? itemActive : itemIdle}`}
              >
                Inicio
              </Link>

              {!isLogin && (
                <a
                  href="#empresas"
                  onClick={() => setActiveHash('#empresas')}
                  className={`${itemBase} ${empresasActive ? itemActive : itemIdle}`}
                >
                  Empresas
                </a>
              )}
            </nav>
          </div>

          <div className="flex items-stretch space-x-6">
            {!isLogin && (
              <button
                onClick={() => {
                  const next = encodeURIComponent(pathname || '/');
                  router.push(`/auth/login?next=${next}`);
                }}
                className={`${itemBase} ${pathname === '/auth/login' ? itemActive : itemIdle}`}
              >
                Iniciar sesión
              </button>
            )}

            {!isLogin && (
              <>
                <span className="hidden md:inline-flex items-center h-16 text-slate-300">|</span>
                <a href="#publicar" className={`${itemBase} ${itemIdle}`}>
                  Publicar empleos
                </a>
              </>
            )}
          </div>
        </div>
      </header>

      {/* Contenido: deja espacio del header (h-16) y ocupa el resto */}
      <main className="pt-16 flex-1" role="main">
        {children}
      </main>

      {/* Footer */}
      <footer className="bg-slate-900 text-slate-300" role="contentinfo">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <nav aria-label="Footer menu">
            <ul className="flex flex-wrap justify-center gap-6 text-sm text-slate-300">
              <li><Link href="/ayuda" className="hover:text-white transition-colors">Centro de Ayuda</Link></li>
              <li><Link href="/contacto" className="hover:text-white transition-colors">Contacto</Link></li>
              <li><Link href="/acerca" className="hover:text-white transition-colors">Acerca de</Link></li>
              <li><Link href="/accesibilidad" className="hover:text-white transition-colors">Accesibilidad en EmpleosPro</Link></li>
              <li><Link href="/terminos" className="hover:text-white transition-colors">Condiciones</Link></li>
            </ul>
          </nav>

          <div className="mt-8 border-t border-slate-800/70" />

          <div className="py-4 text-center text-xs sm:text-sm text-slate-400">
            © 2025 EmpleosPro. Todos los derechos reservados.
          </div>
        </div>
      </footer>
    </div>
  );
}
