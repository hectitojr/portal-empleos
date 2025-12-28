import type { Metadata } from 'next';
import { redirect } from 'next/navigation';

type SearchParams = Record<string, string | string[] | undefined>;

type Props = {
  searchParams?: Promise<SearchParams>;
};

export const metadata: Metadata = {
  robots: { index: false, follow: false },
};

export default async function RegisterPage({ searchParams }: Props) {
  const resolved = (await searchParams) ?? {};

  const sp = new URLSearchParams();

  for (const [k, v] of Object.entries(resolved)) {
    if (typeof v === 'string') sp.set(k, v);
    else if (Array.isArray(v) && v[0]) sp.set(k, v[0]);
  }

  sp.set('mode', 'register');
  redirect(`/auth/login?${sp.toString()}`);
}
