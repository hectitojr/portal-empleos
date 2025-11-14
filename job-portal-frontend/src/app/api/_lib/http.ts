import { NextResponse } from 'next/server';
import { readTokens, setAuthCookies, clearAuthCookies } from './cookies';
import { env } from '@/lib/env';

type BackendAuthResponse = {
  tokenType: string;
  accessToken: string;
  expiresIn: number;
  refreshToken?: string;
};

const BACKEND = env.BACKEND_BASE_URL;

async function backendFetchRaw(path: string, init?: RequestInit) {
  const url = path.startsWith('http') ? path : `${BACKEND}${path}`;

  return fetch(url, {
    ...init,
    headers: {
      'Content-Type': 'application/json',
      ...(init?.headers || {}),
    },
  });
}

export async function backendFetch(
  path: string,
  init?: RequestInit & { retryOn401?: boolean }
): Promise<Response> {
  const { access } = await readTokens();

  const res = await backendFetchRaw(path, {
    ...init,
    headers: {
      ...(init?.headers || {}),
      ...(access ? { Authorization: `Bearer ${access}` } : {}),
    },
  });

  if (res.status === 401 && init?.retryOn401 !== false) {
    const refreshed = await tryRefresh();
    if (refreshed) {
      const { access: newAccess } = await readTokens();
      return backendFetchRaw(path, {
        ...init,
        headers: {
          ...(init?.headers || {}),
          ...(newAccess ? { Authorization: `Bearer ${newAccess}` } : {}),
        },
      });
    }
  }

  return res;
}

export async function tryRefresh(): Promise<boolean> {
  const { refresh } = await readTokens();
  if (!refresh) return false;

  const res = await backendFetchRaw('/api/v1/auth/refresh', {
    method: 'POST',
    body: JSON.stringify({ refreshToken: refresh }),
    headers: { 'Content-Type': 'application/json' },
  });

  if (!res.ok) {
    await clearAuthCookies();
    return false;
  }

  const data = (await res.json()) as BackendAuthResponse;

  await setAuthCookies({
    accessToken: data.accessToken,
    expiresIn: data.expiresIn,
    refreshToken: data.refreshToken,
  });

  return true;
}

export function json(data: unknown, init?: number | ResponseInit) {
  const status =
    typeof init === 'number'
      ? init
      : (init as ResponseInit)?.status ?? 200;

  return NextResponse.json(data, {
    status,
    ...(typeof init === 'object' ? init : {}),
  });
}
