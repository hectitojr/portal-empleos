import { cookies } from 'next/headers';
import { redirect } from 'next/navigation';
import { routes } from '@/lib/routes';

export default async function MeRedirectPage() {
  const jar = await cookies();
  const role = jar.get('jp_role')?.value;

  if (role === 'APPLICANT') {
    redirect(routes.dashboard.applicant.home);
  }

  if (role === 'COMPANY') {
    redirect(routes.dashboard.company.home);
  }

  redirect(routes.public.home);
}
