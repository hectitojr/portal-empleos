import type { JobOffer } from '@/lib/types';
import { headers } from 'next/headers';

type PageProps = {
  params: Promise<{ id: string }>;
};

export default async function JobDetailPage({ params }: PageProps) {
  const { id } = await params;

  const h = await headers();
  const proto = h.get('x-forwarded-proto') ?? 'https';
  const host = h.get('host');
  if (!host) {
    throw new Error('Missing Host header');
  }
  const base = `${proto}://${host}`;

  const res = await fetch(`${base}/api/jobs/${id}`, { cache: 'no-store' });
  if (!res.ok) {
    throw new Error(`Failed to fetch job ${id}: ${res.status}`);
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
