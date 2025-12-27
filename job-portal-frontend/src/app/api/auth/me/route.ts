import { backendFetch } from '@/app/api/_lib/http';
import { clearAuthCookies } from '@/app/api/_lib/cookies';

function buildResponse(upstream: Response, bodyText: string) {
  const contentType =
    upstream.headers.get('content-type') ?? 'application/json; charset=utf-8';

  const headers = new Headers();
  headers.set('Content-Type', contentType);
  headers.set('Cache-Control', 'no-store');

  const traceId = upstream.headers.get('x-trace-id');
  if (traceId) headers.set('x-trace-id', traceId);

  return new Response(bodyText, { status: upstream.status, headers });
}

export async function GET() {
  try {
    const res = await backendFetch('/api/v1/auth/me', { retryOn401: true });
    const text = await res.text();

    if (res.status === 401 || res.status === 403) {
      await clearAuthCookies();
    }

    return buildResponse(res, text);
  } catch {
    await clearAuthCookies();
    return new Response(
      JSON.stringify({ error: 'UNAUTHENTICATED', message: 'No autenticado.' }),
      { status: 401, headers: { 'Content-Type': 'application/json', 'Cache-Control': 'no-store' } },
    );
  }
}
