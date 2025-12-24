import { backendFetch } from '@/app/api/_lib/http';

function buildResponse(upstream: Response, bodyText: string) {
  const contentType =
    upstream.headers.get('content-type') ?? 'application/json; charset=utf-8';

  const headers = new Headers();
  headers.set('Content-Type', contentType);
  headers.set('Cache-Control', 'no-store');

  const setCookie = upstream.headers.get('set-cookie');
  if (setCookie) headers.set('set-cookie', setCookie);

  const traceId = upstream.headers.get('x-trace-id');
  if (traceId) headers.set('x-trace-id', traceId);

  return new Response(bodyText, { status: upstream.status, headers });
}

export async function GET() {
  const res = await backendFetch('/api/v1/applicants/me', { retryOn401: true });
  const text = await res.text();
  return buildResponse(res, text);
}

export async function PUT(req: Request) {
  const body = await req.text();

  const res = await backendFetch('/api/v1/applicants/me', {
    method: 'PUT',
    body,
    retryOn401: true,
  });

  const text = await res.text();
  return buildResponse(res, text);
}
