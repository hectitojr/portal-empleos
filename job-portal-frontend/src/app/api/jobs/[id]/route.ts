import { NextRequest, NextResponse } from 'next/server';
import { env } from '@/lib/env';
import { attachAuthCookies, readAccessFromRequest, readRefreshFromRequest } from '@/lib/auth';
import type { AuthResponse } from '@/lib/types';

async function fetchJob(id: string, access?: string) {
  const url = `${env.BACKEND_BASE_URL}/api/v1/jobs/${id}`;
  return fetch(url, {
    cache: 'no-store',
    headers: access ? { Authorization: `Bearer ${access}` } : undefined
  });
}

export async function GET(req: NextRequest, ctx: { params: { id: string } }) {
  const { id } = ctx.params;

  let access = readAccessFromRequest(req);
  let res = await fetchJob(id, access);

  if (res.status === 401) {
    const refresh = readRefreshFromRequest(req);
    if (refresh) {
      const refreshRes = await fetch(`${env.BACKEND_BASE_URL}/api/v1/auth/refresh`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ refreshToken: refresh })
      });

      if (refreshRes.ok) {
        const data = (await refreshRes.json().catch(() => ({}))) as Partial<AuthResponse>;
        access = data.accessToken;
        res = await fetchJob(id, access);

        const payload = await res.json().catch(() => ({}));
        const out = NextResponse.json(payload, { status: res.status });
        if (data.accessToken) attachAuthCookies(out, { access: data.accessToken });
        return out;
      }
    }
  }

  const payload = await res.json().catch(() => ({}));
  return NextResponse.json(payload, { status: res.status });
}
