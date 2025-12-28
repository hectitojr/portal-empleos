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
    role: a.role ?? null,
  });

  return NextResponse.json({ ok: true });
}
