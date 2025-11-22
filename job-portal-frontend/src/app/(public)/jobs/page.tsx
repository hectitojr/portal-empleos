import type { JobOffer } from '@/lib/types';
import { headers } from 'next/headers';
import Link from 'next/link';

export default async function JobsPage() {
  const h = await headers();
  const proto = h.get('x-forwarded-proto') ?? 'http';
  const host = h.get('host')!;
  const base = `${proto}://${host}`;

  const res = await fetch(`${base}/api/jobs`, { cache: 'no-store' });

  if (!res.ok) {
    const status = res.status;
    return (
      <section className="space-y-4">
        <h1 className="text-2xl font-semibold">Ofertas</h1>
        <div className="rounded border p-4 text-sm">
          {status === 401 ? (
            <p>No autenticado. <a className="underline" href="/auth/login?next=/jobs">Inicia sesión</a> para ver las ofertas.</p>
          ) : (
            <p>Error al cargar ofertas (HTTP {status}). Intenta nuevamente.</p>
          )}
        </div>
      </section>
    );
  }

  const jobs: JobOffer[] = await res.json();

  return (
    <section className="space-y-4">
      <h1 className="text-2xl font-semibold">Ofertas</h1>
      <ul className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {jobs.map((j) => (
          <li key={j.id} className="rounded-xl border p-4">
            <Link href={`/jobs/${j.id}`} className="block">
              <h2 className="font-medium">{j.title}</h2>
              <p className="text-sm text-muted-foreground">{j.company.legalName}</p>
            </Link>
          </li>
        ))}
      </ul>
    </section>
  );
}
