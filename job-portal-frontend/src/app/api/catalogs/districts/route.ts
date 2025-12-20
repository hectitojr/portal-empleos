import { backendFetch } from '@/app/api/_lib/http';

export async function GET(req: Request) {
  const url = new URL(req.url);
  const provinceId = url.searchParams.get('provinceId');

  const qs = provinceId ? `?provinceId=${encodeURIComponent(provinceId)}` : '';
  const res = await backendFetch(`/api/v1/catalogs/districts${qs}`, { retryOn401: true });

  const text = await res.text();
  return new Response(text, { status: res.status, headers: { 'Content-Type': 'application/json' } });
}
