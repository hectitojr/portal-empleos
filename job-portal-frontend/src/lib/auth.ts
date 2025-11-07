import type { NextRequest } from 'next/server';
import { NextResponse } from 'next/server';
import { env } from './env';

const ACCESS = 'access_token';
const REFRESH = 'refresh_token';

export function attachAuthCookies(
  res: NextResponse,
  { access, refresh }: { access: string; refresh?: string }
) {
  res.cookies.set(ACCESS, access, {
    httpOnly: true,
    sameSite: 'lax',
    secure: env.AUTH_COOKIE_SECURE,
    path: '/',
    domain: env.AUTH_COOKIE_DOMAIN
  });

  if (refresh) {
    res.cookies.set(REFRESH, refresh, {
      httpOnly: true,
      sameSite: 'lax',
      secure: env.AUTH_COOKIE_SECURE,
      path: '/',
      domain: env.AUTH_COOKIE_DOMAIN
    });
  }

  return res;
}

export function clearAuthCookies(res: NextResponse) {
  res.cookies.delete(ACCESS);
  res.cookies.delete(REFRESH);
  return res;
}

export function readAccessFromRequest(req: NextRequest): string | undefined {
  return req.cookies.get(ACCESS)?.value;
}

export function readRefreshFromRequest(req: NextRequest): string | undefined {
  return req.cookies.get(REFRESH)?.value;
}
