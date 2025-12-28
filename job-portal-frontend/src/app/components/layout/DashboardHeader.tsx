'use client';

import { useEffect, useMemo } from 'react';
import Link from 'next/link';
import { Briefcase } from 'lucide-react';
import { usePathname, useRouter } from 'next/navigation';
import type { Route } from 'next';
import { useQueryClient } from '@tanstack/react-query';

import AccountMenu from '@/features/iam/components/AccountMenu';
import { logoutReq } from '@/features/iam/api/authClient';
import { useMe } from '@/features/iam/hooks/useMe';
import { routes } from '@/lib/routes';

import { useNavigationGuard } from '@/app/components/navigation/NavigationGuardProvider';

type MenuKey = 'jobs' | 'applications' | 'messages' | 'notifications' | 'account';

export default function DashboardHeader() {
  const pathname = usePathname();
  const router = useRouter();
  const qc = useQueryClient();
  const { data: me, error } = useMe();

  const guard = useNavigationGuard();
  const userEmail = me?.email ?? '';

  const isApplicant =
    pathname === routes.dashboard.applicant.home ||
    pathname.startsWith('/applicant/') ||
    pathname.startsWith('/me/applicant');

  const isCompany =
    pathname === routes.dashboard.company.home ||
    pathname.startsWith('/company/') ||
    pathname.startsWith('/me/company');

  const isAdmin = pathname === '/dashboard/admin' || pathname.startsWith('/dashboard/admin/');

  useEffect(() => {
    const status = (error as any)?.status;
    if (status === 401 || status === 403) {
      router.push(routes.public.login);
      router.refresh();
    }
  }, [error, router]);

  const itemBase = 'inline-flex h-16 items-center border-b-2 transition-colors px-1';
  const itemIdle = 'border-transparent text-[#595959] hover:text-[#2d2d2d] hover:border-[#2557a7]';
  const itemActive = 'border-[#2557a7] text-[#2d2d2d]';

  const applicantActiveKey = useMemo<MenuKey | undefined>(() => {
    if (pathname.startsWith('/me/applicant')) return 'account';

    if (pathname.startsWith(routes.dashboard.applicant.jobs)) return 'jobs';
    if (pathname.startsWith(routes.dashboard.applicant.messages)) return 'messages';
    if (pathname.startsWith(routes.dashboard.applicant.notifications)) return 'notifications';

    return undefined;
  }, [pathname]);

  const companyActiveKey = useMemo<MenuKey | undefined>(() => {
    if (pathname.startsWith('/me/company')) return 'account';

    if (pathname.startsWith(routes.dashboard.company.notifications)) return 'notifications';
    if (pathname.startsWith(routes.dashboard.company.jobs)) return 'jobs';

    return undefined;
  }, [pathname]);

  function guardedPush(path: Route) {
    if (!guard.isDirty()) {
      router.push(path);
      return;
    }

    guard.setPendingNavigate(() => router.push(path));
    guard.pingOpenConfirm();
  }

  async function handleLogout() {
    await logoutReq();
    qc.clear();
    router.push(routes.public.login);
    router.refresh();
  }

  function guardedLogout() {
    if (!guard.isDirty()) {
      void handleLogout();
      return;
    }

    guard.setPendingNavigate(() => {
      void handleLogout();
    });
    guard.pingOpenConfirm();
  }

  const inicioActive = useMemo(() => pathname === routes.dashboard.applicant.home, [pathname]);

  return (
    <header role="banner" className="fixed top-0 left-0 right-0 bg-white shadow-sm z-50">
      <div className="flex items-stretch justify-between h-16 px-4 sm:px-6 md:px-8">
        <div className="flex items-stretch min-w-0 gap-3 sm:gap-6">
          <button
            onClick={() => guardedPush(routes.dashboard.me)}
            className="flex items-center gap-2 h-16 min-w-0"
            aria-label="Ir al inicio"
            type="button"
          >
            <Briefcase className="w-6 h-6 text-blue-600" aria-hidden="true" />
            <span className="hidden sm:inline text-2xl font-bold text-blue-600">EmpleosPeru</span>
            <span className="sm:hidden text-lg font-bold text-blue-600">EP</span>
          </button>

          {isApplicant && (
            <nav className="hidden md:flex items-stretch space-x-6">
              <Link
                href={routes.dashboard.applicant.home}
                className={`${itemBase} ${inicioActive ? itemActive : itemIdle}`}
              >
                Inicio
              </Link>
            </nav>
          )}

          {isCompany && (
            <nav className="hidden md:flex items-stretch space-x-6">
              <Link
                href={routes.dashboard.company.home}
                className={`${itemBase} ${
                  pathname === routes.dashboard.company.home ? itemActive : itemIdle
                }`}
              >
                Panel empresa
              </Link>

              <Link
                href={routes.dashboard.company.jobs}
                className={`${itemBase} ${
                  pathname.startsWith(routes.dashboard.company.jobs) ? itemActive : itemIdle
                }`}
              >
                Mis empleos
              </Link>
            </nav>
          )}
        </div>

        {isApplicant && (
          <AccountMenu
            email={userEmail}
            variant="APPLICANT"
            activeKey={applicantActiveKey}
            jobsHref={routes.dashboard.applicant.jobs}
            messagesHref={routes.dashboard.applicant.messages}
            notificationsHref={routes.dashboard.applicant.notifications}
            accountHref={routes.dashboard.applicant.profileSetup}
            settingsHref={routes.dashboard.applicant.settings}
            reviewsHref={routes.dashboard.applicant.reviews}
            showPublishCta
            publishHref={routes.dashboard.applicant.publishJobs}
            onLogout={guardedLogout}
          />
        )}

        {isCompany && (
          <AccountMenu
            email={userEmail}
            variant="COMPANY"
            activeKey={companyActiveKey}
            jobsHref={routes.dashboard.company.jobs}
            notificationsHref={routes.dashboard.company.notifications}
            accountHref={routes.dashboard.company.profileSetup}
            settingsHref={routes.dashboard.company.settings}
            reviewsHref={routes.dashboard.company.reviews}
            showPublishCta
            publishHref={routes.dashboard.company.jobNew}
            onLogout={guardedLogout}
          />
        )}

        {isAdmin && (
          <div className="flex items-center gap-3 text-sm text-slate-600">
            <span className="hidden sm:inline">{userEmail}</span>
            <button
              onClick={guardedLogout}
              className="text-blue-700 hover:text-blue-800 font-medium"
              type="button"
            >
              Cerrar sesión
            </button>
          </div>
        )}
      </div>
    </header>
  );
}
