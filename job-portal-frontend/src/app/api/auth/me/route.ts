import { backendFetch, json } from '@/app/api/_lib/http';
import { clearAuthCookies } from '@/app/api/_lib/cookies';

export async function GET() {
  try {

    const res = await backendFetch('/api/v1/auth/me', { retryOn401: true });
    const data = await res.json().catch(() => ({}));

    if (res.status === 401 || res.status === 403) {
      await clearAuthCookies();
    }

    return json(data, res.status);
  } catch (e) {
    await clearAuthCookies();
    return json({ error: 'UNAUTHENTICATED', message: 'No autenticado.' }, 401);
  }
}
