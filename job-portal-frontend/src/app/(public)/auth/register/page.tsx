import { redirect } from 'next/navigation';

export default function RegisterPage({
  searchParams,
}: {
  searchParams?: Record<string, string | string[] | undefined>;
}) {
  const sp = new URLSearchParams();

  if (searchParams) {
    for (const [k, v] of Object.entries(searchParams)) {
      if (typeof v === 'string') sp.set(k, v);
      else if (Array.isArray(v) && v[0]) sp.set(k, v[0]);
    }
  }

  sp.set('mode', 'register');
  redirect(`/auth/login?${sp.toString()}`);
}
