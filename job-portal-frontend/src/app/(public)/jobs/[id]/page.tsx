import type { JobOffer } from '@/lib/types';
import { headers } from 'next/headers';

export default async function JobDetailPage({ params }: { params: { id: string } }) {
  const h = await headers();
  const proto = h.get('x-forwarded-proto') ?? 'http';
  const host = h.get('host') ?? '';
  const base = `${proto}://${host}`;

  const res = await fetch(`${base}/api/jobs/${params.id}`, { cache: 'no-store' });
  if (!res.ok) {
    throw new Error(`Failed to fetch job ${params.id}: ${res.status}`);
  }

  const j: JobOffer = await res.json();

  return (
    <article className="prose dark:prose-invert">
      <h1>{j.title}</h1>
      <p>
        <b>Empresa:</b> {j.company.legalName}
      </p>
      {j.area && (
        <p>
          <b>Área:</b> {j.area}
        </p>
      )}
      {j.sector && (
        <p>
          <b>Sector:</b> {j.sector}
        </p>
      )}
      {j.district && (
        <p>
          <b>Distrito:</b> {j.district}
        </p>
      )}
    </article>
  );
}
