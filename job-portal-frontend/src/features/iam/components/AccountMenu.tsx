'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import type { Route } from 'next';
import { usePathname, useRouter } from 'next/navigation';
import {
  Bookmark,
  MessageSquare,
  Bell,
  User,
  FileText,
  Star,
  HelpCircle,
  LogOut,
  Settings,
  Users,
} from 'lucide-react';
import { logoutReq } from '@/features/iam/api/authClient';
import { routes } from '@/lib/routes';

type RoleVariant = 'APPLICANT' | 'COMPANY' | 'ADMIN';
type MenuKey = 'jobs' | 'applications' | 'messages' | 'notifications' | 'account';

type Props = {
  email: string;
  variant?: RoleVariant;
  activeKey?: MenuKey;

  jobsHref?: Route;
  applicationsHref?: Route;
  messagesHref?: Route;
  notificationsHref?: Route;
  accountHref?: Route;
  settingsHref?: Route;

  showPublishCta?: boolean;
  publishHref?: Route;

  onLogout?: () => void | Promise<void>;
};

function HeaderIconButton({
  children,
  label,
  active = false,
  showTooltip = true,
}: {
  children: React.ReactNode;
  label: string;
  active?: boolean;
  showTooltip?: boolean;
}) {
  return (
    <div
      aria-label={label}
      className={`
        group relative h-16 px-2 flex items-center justify-center
        transition-colors text-slate-700 hover:text-[#2d2d2d] hover:bg-slate-50
        ${active ? 'text-blue-700' : ''}
        after:content-[''] after:absolute after:left-0 after:bottom-0
        after:w-full after:h-[2px] after:bg-blue-700 after:rounded-full
        after:scale-x-0 after:transition-transform after:duration-200
        hover:after:scale-x-100 ${active ? 'after:scale-x-100' : ''}
      `}
    >
      <div className="w-10 h-10 flex items-center justify-center rounded-full">
        {children}
      </div>

      {showTooltip && (
        <div
          role="tooltip"
          className="pointer-events-none absolute top-full left-1/2 -translate-x-1/2 mt-3 z-[80]"
        >
          <div className="will-change-[opacity,transform] opacity-0 translate-y-1 group-hover:opacity-100 group-hover:translate-y-0 group-hover:delay-150 transition-[opacity,transform] duration-350 ease-smooth">
            <div className="mx-auto w-0 h-0 border-l-8 border-r-8 border-b-8 border-transparent border-b-slate-900/95 drop-shadow-sm" />
            <div className="mt-1 px-4 py-2 rounded-2xl bg-slate-900/95 text-white text-xs sm:text-sm font-semibold shadow-xl whitespace-nowrap">
              {label}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default function AccountMenu({
  email,
  variant = 'APPLICANT',
  activeKey,

  jobsHref,
  applicationsHref,
  messagesHref,
  notificationsHref,
  accountHref,
  settingsHref,

  showPublishCta,
  publishHref,

  onLogout,
}: Props) {
  const [open, setOpen] = useState(false);
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    setOpen(false);
  }, [pathname]);

  const isApplicant = variant === 'APPLICANT';
  const isCompany = variant === 'COMPANY';

  const computedJobsHref =
    jobsHref ??
    (isCompany ? routes.dashboard.company.jobs : routes.dashboard.applicant.home);

  const computedApplicationsHref = applicationsHref;

  const computedMessagesHref = messagesHref ?? ('/applicant#mensajes' as Route);
  const computedNotificationsHref =
    notificationsHref ??
    (isCompany ? ('/company/notifications' as Route) : ('/applicant#notificaciones' as Route));

  const computedAccountHref =
    accountHref ??
    (isCompany ? routes.dashboard.company.profileSetup : routes.dashboard.applicant.profileSetup);

  const computedSettingsHref =
    settingsHref ??
    (isCompany
      ? ('/me/company/settings' as Route)
      : ('/me/applicant/settings' as Route));

  const computedShowPublishCta = showPublishCta ?? isCompany;
  const computedPublishHref = publishHref ?? ('/company/jobs/new' as Route);

  async function handleLogout() {
    try {
      await logoutReq();
    } finally {
      setOpen(false);
      router.replace(routes.public.login);
      router.refresh();
    }
  }

  const itemBase =
    'inline-flex h-16 items-center border-b-2 transition-colors px-1';
  const itemIdle =
    'border-transparent text-[#595959] hover:text-[#2d2d2d] hover:border-[#2557a7]';

  return (
    <div className="flex items-center gap-4">
      <div className="flex items-stretch gap-1">

        <Link href={computedJobsHref} className="inline-flex items-stretch">
          <HeaderIconButton
            label={isCompany ? 'Mis ofertas' : 'Mis empleos'}
            active={activeKey === 'jobs'}
          >
            <Bookmark className="w-5 h-5" />
          </HeaderIconButton>
        </Link>

        {isCompany && computedApplicationsHref && (
          <Link href={computedApplicationsHref} className="inline-flex items-stretch">
            <HeaderIconButton
              label="Postulaciones"
              active={activeKey === 'applications'}
            >
              <Users className="w-5 h-5" />
            </HeaderIconButton>
          </Link>
        )}

        {isApplicant && (
          <Link href={computedMessagesHref} className="inline-flex items-stretch">
            <HeaderIconButton
              label="Mensajes"
              active={activeKey === 'messages'}
            >
              <MessageSquare className="w-5 h-5" />
            </HeaderIconButton>
          </Link>
        )}

        {/* Notificaciones */}
        <Link href={computedNotificationsHref} className="inline-flex items-stretch">
          <HeaderIconButton
            label="Notificaciones"
            active={activeKey === 'notifications'}
          >
            <Bell className="w-5 h-5" />
          </HeaderIconButton>
        </Link>

        {/* Cuenta */}
        <div className="relative flex items-stretch">
          <button
            type="button"
            onClick={() => setOpen((v) => !v)}
            className="inline-flex items-stretch"
            aria-expanded={open}
            aria-haspopup="menu"
          >
            <HeaderIconButton
              label="Cuenta"
              active={activeKey === 'account' || open}
              showTooltip={!open}
            >
              <User className="w-5 h-5" />
            </HeaderIconButton>
          </button>

          {open && (
            <div
              className="absolute right-0 top-full mt-4 w-72 z-[60]"
              role="menu"
            >
              <div
                className="
                  absolute right-7 -top-3
                  w-0 h-0
                  border-l-8 border-r-8 border-b-8
                  border-transparent
                  border-b-slate-200
                  drop-shadow-sm
                "
              />
              <div
                className="
                  absolute right-7 -top-2.5
                  w-0 h-0
                  border-l-7 border-r-7 border-b-7
                  border-transparent
                  border-b-white
                "
              />

              <div className="bg-white rounded-2xl shadow-xl border border-slate-100 overflow-hidden">
                <div className="px-4 pt-3 pb-2 border-b border-slate-100">
                  <p className="text-sm font-semibold text-slate-900 truncate">
                    {email}
                  </p>
                </div>

                <nav className="py-2 text-sm text-slate-700">
                  <Link
                    href={computedAccountHref}
                    className="w-full px-4 py-2.5 flex items-center gap-2 hover:bg-slate-50"
                    onClick={() => setOpen(false)}
                  >
                    <FileText className="w-4 h-4 text-slate-500" />
                    <span>Perfil</span>
                  </Link>

                  <button
                    type="button"
                    className="w-full px-4 py-2.5 flex items-center gap-2 hover:bg-slate-50"
                  >
                    <Star className="w-4 h-4 text-slate-500" />
                    <span>Mis evaluaciones</span>
                  </button>

                  <Link
                    href={computedSettingsHref}
                    className="w-full px-4 py-2.5 flex items-center gap-2 hover:bg-slate-50"
                    onClick={() => setOpen(false)}
                  >
                    <Settings className="w-4 h-4 text-slate-500" />
                    <span>Configuración</span>
                  </Link>

                  <Link
                    href={routes.public.help}
                    className="w-full px-4 py-2.5 flex items-center gap-2 hover:bg-slate-50"
                    onClick={() => setOpen(false)}
                  >
                    <HelpCircle className="w-4 h-4 text-slate-500" />
                    <span>Ayuda</span>
                  </Link>
                </nav>

                <div className="border-t border-slate-100">
                  <button
                    type="button"
                    className="w-full px-4 py-3 flex items-center justify-center gap-2 text-sm font-semibold text-blue-700 hover:bg-blue-50"
                    onClick={async () => {
                      setOpen(false);
                      if (onLogout) {
                        await onLogout();
                      } else {
                        await handleLogout();
                      }
                    }}
                  >
                    <LogOut className="w-4 h-4" />
                    <span>Cerrar sesión</span>
                  </button>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>

      {computedShowPublishCta && (
        <>
          <span className="hidden md:inline-flex items-center h-16 text-slate-300">
            |
          </span>

          <Link href={computedPublishHref} className={`${itemBase} ${itemIdle}`}>
            Publicar empleos
          </Link>
        </>
      )}
    </div>
  );
}
