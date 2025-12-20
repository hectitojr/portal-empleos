import { backendFetch } from '@/app/api/_lib/http';

export async function GET(_: Request, ctx: { params: { districtId: string } }) {
  const { districtId } = ctx.params;

  const res = await backendFetch(`/api/v1/catalogs/districts/${encodeURIComponent(districtId)}`, {
    retryOn401: true,
  });

  const text = await res.text();
  return new Response(text, { status: res.status, headers: { 'Content-Type': 'application/json' } });
}
