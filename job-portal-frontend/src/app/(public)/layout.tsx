'use client';

import { type ReactNode, useEffect, useState } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import Link from 'next/link';
import { Briefcase } from 'lucide-react';

import { routes } from '@/lib/routes';
import Footer from '@/app/components/layout/Footer';

import { useMe } from '@/features/iam/hooks/useMe';
import AccountMenu from '@/features/iam/components/AccountMenu';

export default function PublicLayout({ children }: { children: ReactNode }) {
  const router = useRouter();
  const pathname = usePathname();
  const isLogin = pathname?.startsWith('/auth/login');

  const { data: me } = useMe();

  const role = (me as any)?.role as
    | 'APPLICANT'
    | 'COMPANY'
    | 'ADMIN'
    | undefined;

  const [activeHash, setActiveHash] = useState<string>(
    typeof window !== 'undefined' ? window.location.hash : ''
  );

  useEffect(() => {
    const sync = () => setActiveHash(window.location.hash);
    window.addEventListener('hashchange', sync);
    return () => window.removeEventListener('hashchange', sync);
  }, []);

  const itemBase = 'inline-flex h-16 items-center border-b-2 transition-colors px-1';
  const itemIdle =
    'border-transparent text-[#595959] hover:text-[#2d2d2d] hover:border-[#2557a7]';
  const itemActive = 'border-[#2557a7] text-[#2d2d2d]';

  const inicioActive = pathname === '/';
  const empresasActive = activeHash === '#empresas';

  return (
    <div className="min-h-screen flex flex-col bg-slate-50">
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
              <Briefcase
                className="w-6 h-6"
                style={{ color: '#2557a7' }}
                aria-hidden="true"
              />
              <span className="text-2xl font-bold" style={{ color: '#2557a7' }}>
                EmpleosPeru
              </span>
            </button>

            <nav
              className="hidden md:flex items-stretch space-x-6"
              aria-label="Navegación principal"
            >
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
                  className={`${itemBase} ${
                    empresasActive ? itemActive : itemIdle
                  }`}
                >
                  Empresas
                </a>
              )}
            </nav>
          </div>

          <div className="flex items-stretch space-x-6">
            {me?.email ? (
              <AccountMenu
                email={me.email}
                variant={(role ?? 'APPLICANT') as any}
                jobsHref={
                  (role === 'COMPANY'
                    ? routes.dashboard.company.home
                    : routes.dashboard.applicant.home) as any
                }
                showPublishCta={role === 'COMPANY'}
              />
            ) : (
              !isLogin && (
                <>
                  <button
                    onClick={() => {
                      const next = encodeURIComponent(pathname || '/');
                      router.push(`/auth/login?next=${next}`);
                    }}
                    className={`${itemBase} ${
                      pathname === '/auth/login' ? itemActive : itemIdle
                    }`}
                  >
                    Iniciar sesión
                  </button>

                  <span className="hidden md:inline-flex items-center h-16 text-slate-300">
                    |
                  </span>

                  <a href="#publicar" className={`${itemBase} ${itemIdle}`}>
                    Publicar empleos
                  </a>
                </>
              )
            )}
          </div>
        </div>
      </header>

      <main className="pt-16 flex-1 flex flex-col" role="main">
        {children}
      </main>

      <Footer />
    </div>
  );
}
