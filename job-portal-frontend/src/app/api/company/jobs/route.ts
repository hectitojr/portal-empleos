import { backendFetch } from '@/app/api/_lib/http';

export async function GET(req: Request) {
  const url = new URL(req.url);
  const qs = url.search ? url.search : '';

  const res = await backendFetch(`/api/v1/company/jobs${qs}`, {
    method: 'GET',
    retryOn401: true,
  });

  const text = await res.text();
  return new Response(text, {
    status: res.status,
    headers: { 'Content-Type': 'application/json' },
  });
}

export async function POST(req: Request) {
  const body = await req.text();

  const res = await backendFetch('/api/v1/company/jobs', {
    method: 'POST',
    body,
    retryOn401: true,
  });

  const text = await res.text();
  return new Response(text, {
    status: res.status,
    headers: { 'Content-Type': 'application/json' },
  });
}
