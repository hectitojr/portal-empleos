import { backendFetch } from '@/app/api/_lib/http';

export async function GET(req: Request) {
  const url = new URL(req.url);
  const departmentId = url.searchParams.get('departmentId');

  const qs = departmentId ? `?departmentId=${encodeURIComponent(departmentId)}` : '';
  const res = await backendFetch(`/api/v1/catalogs/provinces${qs}`, { retryOn401: true });

  const text = await res.text();
  return new Response(text, { status: res.status, headers: { 'Content-Type': 'application/json' } });
}
