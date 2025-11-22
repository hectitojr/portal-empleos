'use client';

import { useEffect, useMemo, useState } from 'react';
import Link from 'next/link';
import { Briefcase } from 'lucide-react';
import { usePathname, useRouter } from 'next/navigation';
import type { Route } from 'next';
import AccountMenu from '@/features/iam/components/AccountMenu';
import { routes } from '@/lib/routes';

export default function DashboardHeader() {
  const pathname = usePathname();
  const router = useRouter();

  const isApplicant =
    pathname.startsWith('/dashboard/applicant') || pathname === '/applicant';
  const isCompany =
    pathname.startsWith('/dashboard/company') || pathname === '/company';
  const isAdmin = pathname.startsWith('/dashboard/admin');

  // ✅ estado para tabs con hash (#empresas) solo en applicant
  const [activeHash, setActiveHash] = useState<string>(
    typeof window !== 'undefined' ? window.location.hash : ''
  );

  useEffect(() => {
    if (!isApplicant) return;
    const sync = () => setActiveHash(window.location.hash);
    window.addEventListener('hashchange', sync);
    return () => window.removeEventListener('hashchange', sync);
  }, [isApplicant]);

  const itemBase =
    'inline-flex h-16 items-center border-b-2 transition-colors px-1';
  const itemIdle =
    'border-transparent text-[#595959] hover:text-[#2d2d2d] hover:border-[#2557a7]';
  const itemActive = 'border-[#2557a7] text-[#2d2d2d]';

  const inicioActive = useMemo(
    () =>
      pathname === routes.dashboard.applicant.home ||
      pathname === `${routes.dashboard.applicant.home}/`,
    [pathname]
  );

  const empresasActive = activeHash === '#empresas';

  // TODO: luego lo sacas de tu estado global auth
  const userEmail = 'ozzychzel@gmail.com';

  /** ✅ ActiveKey para iconos derecho */
  const applicantActiveKey = useMemo(() => {
    if (pathname.startsWith('/applicant/messages') || activeHash === '#mensajes')
      return 'messages';
    if (
      pathname.startsWith('/applicant/notifications') ||
      activeHash === '#notificaciones'
    )
      return 'notifications';
    if (pathname.startsWith('/me/applicant')) return 'account';
    return 'jobs';
  }, [pathname, activeHash]);

  return (
    <header
      role="banner"
      className="fixed top-0 left-0 right-0 bg-white shadow-sm z-50"
    >
      <div className="flex items-stretch justify-between h-16 px-6 md:px-8">
        {/* LEFT: logo siempre compartido */}
        <div className="flex items-stretch space-x-6">
          <button
            onClick={() => router.push(routes.dashboard.me)}
            className="flex items-center space-x-2 h-16"
            aria-label="Ir al inicio"
          >
            <Briefcase className="w-6 h-6 text-blue-600" aria-hidden="true" />
            <span className="text-2xl font-bold text-blue-600">
              EmpleosPeru
            </span>
          </button>

          {/* CENTER: navegación por rol */}
          {isApplicant && (
            <nav
              className="hidden md:flex items-stretch space-x-6"
              aria-label="Navegación Applicant"
            >
              <Link
                href={routes.dashboard.applicant.home as Route}
                aria-current={inicioActive ? 'page' : undefined}
                className={`${itemBase} ${
                  inicioActive ? itemActive : itemIdle
                }`}
              >
                Inicio
              </Link>

              <a
                href="#empresas"
                onClick={() => setActiveHash('#empresas')}
                className={`${itemBase} ${
                  empresasActive ? itemActive : itemIdle
                }`}
              >
                Empresas
              </a>
            </nav>
          )}

          {isCompany && (
            <nav
              className="hidden md:flex items-stretch space-x-6"
              aria-label="Navegación Company"
            >
              <Link
                href={routes.dashboard.company.home as Route}
                className={`${itemBase} ${
                  pathname === routes.dashboard.company.home
                    ? itemActive
                    : itemIdle
                }`}
              >
                Panel empresa
              </Link>
              <Link
                href={routes.dashboard.company.jobs as Route}
                className={`${itemBase} ${
                  pathname.startsWith(routes.dashboard.company.jobs)
                    ? itemActive
                    : itemIdle
                }`}
              >
                Mis empleos
              </Link>
            </nav>
          )}

          {isAdmin && (
            <nav
              className="hidden md:flex items-stretch space-x-6"
              aria-label="Navegación Admin"
            >
              <Link
                href={'/dashboard/admin' as Route}
                className={`${itemBase} ${itemActive}`}
              >
                Admin
              </Link>
            </nav>
          )}
        </div>

        {/* RIGHT: AccountMenu solo para applicant */}
        {isApplicant ? (
          <AccountMenu
            email={userEmail}
            variant="APPLICANT"
            activeKey={applicantActiveKey}
            jobsHref={routes.dashboard.applicant.home}
            // placeholders (cuando crees páginas reales solo cambias esto)
            messagesHref={'/applicant/messages' as Route}
            notificationsHref={'/applicant/notifications' as Route}
            accountHref={routes.dashboard.applicant.profileSetup}
            showPublishCta
          />
        ) : (
          <div className="flex items-center gap-3 text-sm text-slate-600">
            <span className="hidden sm:inline">{userEmail}</span>
            <button
              onClick={() => console.log('logout')}
              className="text-blue-700 hover:text-blue-800 font-medium"
            >
              Cerrar sesión
            </button>
          </div>
        )}
      </div>
    </header>
  );
}
