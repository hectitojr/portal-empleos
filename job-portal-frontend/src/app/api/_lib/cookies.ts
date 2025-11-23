import { cookies } from 'next/headers';
import { env } from '@/lib/env';

export const ACCESS_COOKIE = 'jp_at';
export const REFRESH_COOKIE = 'jp_rt';
export const ACCESS_EXP_COOKIE = 'jp_at_exp';
export const ROLE_COOKIE = 'jp_role';

const isProd = process.env.NODE_ENV === 'production';

const cookieDomain = env.AUTH_COOKIE_DOMAIN || undefined;
const cookieSecure = isProd && env.AUTH_COOKIE_SECURE;
const refreshTtl = Number(process.env.REFRESH_TTL_SECONDS ?? 2592000);

type BaseCookieOptions = {
  httpOnly: boolean;
  maxAge: number;
};

function buildCookieOptions(base: BaseCookieOptions) {
  return {
    ...base,
    secure: cookieSecure,
    sameSite: 'lax' as const,
    path: '/',
    ...(cookieDomain ? { domain: cookieDomain } : {}),
  };
}

export async function setAuthCookies(params: {
  accessToken: string;
  expiresIn: number;
  refreshToken?: string;
}) {
  const jar = await cookies();

  jar.set(
    ACCESS_COOKIE,
    params.accessToken,
    buildCookieOptions({
      httpOnly: true,
      maxAge: params.expiresIn,
    }),
  );

  const expEpoch = Math.floor(Date.now() / 1000) + params.expiresIn - 5;
  jar.set(
    ACCESS_EXP_COOKIE,
    String(expEpoch),
    buildCookieOptions({
      httpOnly: false,
      maxAge: params.expiresIn,
    }),
  );

  if (params.refreshToken) {
    jar.set(
      REFRESH_COOKIE,
      params.refreshToken,
      buildCookieOptions({
        httpOnly: true,
        maxAge: refreshTtl,
      }),
    );
  }
}

export async function clearAuthCookies() {
  const jar = await cookies();

  const base = {
    httpOnly: true,
    secure: cookieSecure,
    sameSite: 'lax' as const,
    path: '/',
    maxAge: 0,
    ...(cookieDomain ? { domain: cookieDomain } : {}),
  };

  [ACCESS_COOKIE, ACCESS_EXP_COOKIE, REFRESH_COOKIE, ROLE_COOKIE].forEach((name) => {
    jar.set(name, '', base);
  });
}

export async function readTokens() {
  const jar = await cookies();
  return {
    access: jar.get(ACCESS_COOKIE)?.value || null,
    refresh: jar.get(REFRESH_COOKIE)?.value || null,
    accessExp: Number(jar.get(ACCESS_EXP_COOKIE)?.value || 0),
    role: jar.get(ROLE_COOKIE)?.value || null,
  };
}
