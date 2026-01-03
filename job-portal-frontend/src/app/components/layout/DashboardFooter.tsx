'use client';

import { usePathname } from 'next/navigation';
import Footer from '@/app/components/layout/Footer';
import { routes } from '@/lib/routes';

const MINIMAL_FOOTER_PATHS = new Set<string>([
  routes.dashboard.company.profileSetup,
  routes.dashboard.company.settings,
  routes.dashboard.company.reviews,
  routes.dashboard.company.jobs,
  routes.dashboard.company.jobNew,
  routes.dashboard.company.applications,
  routes.dashboard.company.notifications,

  routes.dashboard.applicant.profileSetup,
  routes.dashboard.applicant.settings,
  routes.dashboard.applicant.reviews,
  routes.dashboard.applicant.jobs,
  routes.dashboard.applicant.messages,
  routes.dashboard.applicant.notifications,
  routes.dashboard.applicant.publishJobs,
]);

function isMinimalFooterPath(pathname: string): boolean {

  if (MINIMAL_FOOTER_PATHS.has(pathname)) return true;

  if (pathname.startsWith(`${routes.dashboard.company.jobs}/`)) return true;

  if (pathname.startsWith(`${routes.dashboard.applicant.jobs}/`)) return true;

  if (pathname.startsWith(`${routes.dashboard.company.applications}/`)) return true;

  return false;
}

export default function DashboardFooter() {
  const pathname = usePathname() ?? '';
  const variant = isMinimalFooterPath(pathname) ? 'minimal' : 'full';
  return <Footer variant={variant} />;
}
