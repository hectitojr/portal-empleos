import { backendFetch } from '@/app/api/_lib/http';

function buildResponse(upstream: Response, bodyText: string) {
  const contentType = upstream.headers.get('content-type') ?? 'application/json; charset=utf-8';

  const headers = new Headers();
  headers.set('Content-Type', contentType);
  headers.set('Cache-Control', 'no-store');

  const setCookie = upstream.headers.get('set-cookie');

  if (setCookie) headers.append('set-cookie', setCookie);

  const traceId = upstream.headers.get('x-trace-id');
  if (traceId) headers.set('x-trace-id', traceId);

  return new Response(bodyText, { status: upstream.status, headers });
}

export async function GET() {
  const res = await backendFetch('/api/v1/companies/me', { retryOn401: true });
  const text = await res.text();
  return buildResponse(res, text);
}

export async function PUT(req: Request) {
  let payload: unknown;
  try {
    payload = await req.json();
  } catch {
    return new Response(JSON.stringify({ message: 'Tipo de contenido no soportado.' }), {
      status: 415,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Cache-Control': 'no-store',
      },
    });
  }

  const res = await backendFetch('/api/v1/companies/me', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      Accept: 'application/json',
    },
    body: JSON.stringify(payload),
    retryOn401: true,
  });

  const text = await res.text();
  return buildResponse(res, text);
}
