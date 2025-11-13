// src/app/api/_lib/cookies.ts
import { cookies } from 'next/headers';

export const ACCESS_COOKIE = 'jp_at';
export const REFRESH_COOKIE = 'jp_rt';
export const ACCESS_EXP_COOKIE = 'jp_at_exp';

const isProd = process.env.NODE_ENV === 'production';
const refreshTtl = Number(process.env.REFRESH_TTL_SECONDS ?? 2592000); // 30d

export async function setAuthCookies(params: {
  accessToken: string;
  expiresIn: number; // segundos
  refreshToken?: string;
}) {
  const jar = await cookies();

  // Access token
  jar.set(ACCESS_COOKIE, params.accessToken, {
    httpOnly: true,
    secure: isProd,
    sameSite: 'lax',
    path: '/',
    maxAge: params.expiresIn,
  });

  // Exp aproximada (para hints de UX)
  const expEpoch = Math.floor(Date.now() / 1000) + params.expiresIn - 5;
  jar.set(ACCESS_EXP_COOKIE, String(expEpoch), {
    httpOnly: false,
    secure: isProd,
    sameSite: 'lax',
    path: '/',
    maxAge: params.expiresIn,
  });

  if (params.refreshToken) {
    jar.set(REFRESH_COOKIE, params.refreshToken, {
      httpOnly: true,
      secure: isProd,
      sameSite: 'lax',
      path: '/',
      maxAge: refreshTtl,
    });
  }
}

export async function clearAuthCookies() {
  const jar = await cookies();
  [ACCESS_COOKIE, ACCESS_EXP_COOKIE, REFRESH_COOKIE].forEach((name) => {
    jar.set(name, '', { path: '/', maxAge: 0 });
  });
}

export async function readTokens() {
  const jar = await cookies();
  return {
    access: jar.get(ACCESS_COOKIE)?.value || null,
    refresh: jar.get(REFRESH_COOKIE)?.value || null,
    accessExp: Number(jar.get(ACCESS_EXP_COOKIE)?.value || 0),
  };
}
