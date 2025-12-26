import { backendFetch } from '@/app/api/_lib/http';

type Ctx = { params: Promise<{ districtId: string }> };

export async function GET(_: Request, { params }: Ctx) {
  const { districtId } = await params;

  const res = await backendFetch(`/api/v1/catalogs/districts/${encodeURIComponent(districtId)}`, {
    retryOn401: true,
  });

  const text = await res.text();

  return new Response(text, {
    status: res.status,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  });
}
