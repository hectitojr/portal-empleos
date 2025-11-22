import type { NextRequest } from 'next/server';
import { NextResponse } from 'next/server';
import { setAuthCookies } from '@/app/api/_lib/cookies';
import { env } from '@/lib/env';

type AuthResp = {
  tokenType: string;
  accessToken: string;
  expiresIn: number;
  refreshToken: string;
  role?: string; 
};

const BACKEND = env.BACKEND_BASE_URL;

function decodeJwtPayload(token: string): any | null {
  try {
    const payload = token.split('.')[1];
    if (!payload) return null;

    const b64 = payload.replace(/-/g, '+').replace(/_/g, '/');
    const padded = b64.padEnd(b64.length + (4 - (b64.length % 4)) % 4, '=');

    return JSON.parse(Buffer.from(padded, 'base64').toString('utf8'));
  } catch {
    return null;
  }
}

function normalizeRole(raw: string | null): string | null {
  if (!raw) return null;
  const upper = raw.toUpperCase();

  if (upper.includes('APPLICANT')) return 'APPLICANT';
  if (upper.includes('COMPANY')) return 'COMPANY';

  return null;
}

function extractRoleFromJwt(accessToken: string): string | null {
  const decoded = decodeJwtPayload(accessToken);
  if (!decoded) return null;

  const candidates: Array<string | undefined> = [
    decoded.role,
    decoded.roles?.[0],
    decoded.authorities?.[0],
    decoded.scope, 
    decoded.realm_access?.roles?.[0], 
  ];

  for (const c of candidates) {
    if (!c) continue;
    const norm = normalizeRole(c);
    if (norm) return norm;

    if (typeof c === 'string' && c.includes(' ')) {
      const parts = c.split(' ');
      for (const p of parts) {
        const n = normalizeRole(p);
        if (n) return n;
      }
    }
  }

  return null;
}

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => ({}));

  const res = await fetch(`${BACKEND}/api/v1/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });

  const data = await res.json().catch(() => ({}));

  if (!res.ok) {
    return NextResponse.json(data, { status: res.status });
  }

  const a = data as AuthResp;

  await setAuthCookies({
    accessToken: a.accessToken,
    expiresIn: a.expiresIn,
    refreshToken: a.refreshToken,
  });

  const role = normalizeRole(a.role ?? null) ?? extractRoleFromJwt(a.accessToken);

  const response = NextResponse.json({ ok: true, role });

  if (role) {
    response.cookies.set('jp_role', role, {
      httpOnly: true,
      sameSite: 'lax',
      path: '/',
      maxAge: a.expiresIn,
      secure: process.env.NODE_ENV === 'production',
    });
  }

  return response;
}
