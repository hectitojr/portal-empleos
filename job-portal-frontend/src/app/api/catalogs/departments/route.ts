import { backendFetch, json } from '@/app/api/_lib/http';

export async function GET() {
  const res = await backendFetch('/api/v1/catalogs/departments', { retryOn401: true });
  const text = await res.text();

  return new Response(text, { status: res.status, headers: { 'Content-Type': 'application/json' } });
}
