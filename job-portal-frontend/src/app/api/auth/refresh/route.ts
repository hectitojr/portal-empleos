import { NextRequest, NextResponse } from 'next/server';
import { env } from '@/lib/env';
import { attachAuthCookies, readRefreshFromRequest } from '@/lib/auth';
import type { AuthResponse, RefreshRequest } from '@/lib/types';

export async function POST(req: NextRequest) {
  const refresh = readRefreshFromRequest(req);
  if (!refresh) return NextResponse.json({ code: 'UNAUTHENTICATED' }, { status: 401 });

  const res = await fetch(`${env.BACKEND_BASE_URL}/api/v1/auth/refresh`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ refreshToken: refresh } satisfies RefreshRequest)
  });

  const data = (await res.json().catch(() => ({}))) as Partial<AuthResponse> & Record<string, unknown>;
  if (!res.ok) return NextResponse.json(data, { status: res.status });

  const out = NextResponse.json({ ok: true });
  attachAuthCookies(out, { access: data.accessToken! });
  return out;
}
