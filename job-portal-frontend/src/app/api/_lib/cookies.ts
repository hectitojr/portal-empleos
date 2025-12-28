import { cookies } from 'next/headers';
import { env } from '@/lib/env';

export const ACCESS_COOKIE = 'jp_at';
export const REFRESH_COOKIE = 'jp_rt';
export const ACCESS_EXP_COOKIE = 'jp_at_exp';
export const ROLE_COOKIE = 'jp_role';

const isProd = process.env.NODE_ENV === 'production';

function normalizeCookieDomain(raw?: string) {
  const v = (raw ?? '').trim();
  if (!v) return undefined;

  const lower = v.toLowerCase();
  if (lower === '.vercel.app' || lower.endsWith('.vercel.app')) return undefined;

  return v;
}

const cookieDomain = normalizeCookieDomain(env.AUTH_COOKIE_DOMAIN);
const cookieSecure = isProd ? true : false;
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

function normalizeRole(r?: string | null): string | null {
  if (!r) return null;
  let up = r.trim().toUpperCase();
  if (up.startsWith('ROLE_')) up = up.substring(5);
  if (up === 'APPLICANT' || up === 'COMPANY' || up === 'ADMIN') return up;
  return null;
}

function decodeJwtPayload(token: string): any | null {
  try {
    const payload = token.split('.')[1];
    if (!payload) return null;

    const b64 = payload.replace(/-/g, '+').replace(/_/g, '/');
    const padded = b64.padEnd(b64.length + ((4 - (b64.length % 4)) % 4), '=');
    const json = Buffer.from(padded, 'base64').toString('utf8');

    return JSON.parse(json);
  } catch {
    return null;
  }
}

function extractRoleFromAccessToken(accessToken: string): string | null {
  const p = decodeJwtPayload(accessToken);
  const role =
    normalizeRole(p?.role) ||
    normalizeRole(Array.isArray(p?.roles) ? p.roles[0] : null) ||
    normalizeRole(Array.isArray(p?.authorities) ? p.authorities[0] : null) ||
    normalizeRole(Array.isArray(p?.realm_access?.roles) ? p.realm_access.roles[0] : null);

  return role;
}

export async function setAuthCookies(params: {
  accessToken: string;
  expiresIn: number;
  refreshToken?: string;

  role?: string | null;
}) {
  const jar = await cookies();

  jar.set(
    ACCESS_COOKIE,
    params.accessToken,
    buildCookieOptions({
      httpOnly: true,
      maxAge: params.expiresIn,
    })
  );

  const expEpoch = Math.floor(Date.now() / 1000) + params.expiresIn - 5;
  jar.set(
    ACCESS_EXP_COOKIE,
    String(expEpoch),
    buildCookieOptions({
      httpOnly: false,
      maxAge: params.expiresIn,
    })
  );

  if (params.refreshToken) {
    jar.set(
      REFRESH_COOKIE,
      params.refreshToken,
      buildCookieOptions({
        httpOnly: true,
        maxAge: refreshTtl,
      })
    );
  }

  const role = normalizeRole(params.role) || extractRoleFromAccessToken(params.accessToken);

  if (role) {
    jar.set(
      ROLE_COOKIE,
      role,
      buildCookieOptions({
        httpOnly: true,
        maxAge: refreshTtl,
      })
    );
  }
}

export async function clearAuthCookies() {
  const jar = await cookies();

  const base = {
    secure: cookieSecure,
    sameSite: 'lax' as const,
    path: '/',
    maxAge: 0,
    ...(cookieDomain ? { domain: cookieDomain } : {}),
  };

  jar.set(ACCESS_COOKIE, '', { ...base, httpOnly: true });
  jar.set(REFRESH_COOKIE, '', { ...base, httpOnly: true });
  jar.set(ROLE_COOKIE, '', { ...base, httpOnly: true });
  jar.set(ACCESS_EXP_COOKIE, '', { ...base, httpOnly: false });
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
