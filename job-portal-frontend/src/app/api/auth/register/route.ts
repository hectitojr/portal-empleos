import { NextRequest, NextResponse } from 'next/server';
import { env } from '@/lib/env';
import type { AuthResponse } from '@/lib/types';

export async function POST(req: NextRequest) {
  const body = await req.json();
  const res = await fetch(`${env.BACKEND_BASE_URL}/api/v1/auth/register`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });

  const data = (await res.json().catch(() => ({}))) as Partial<AuthResponse> & Record<string, unknown>;
  return NextResponse.json({ ok: res.ok, data }, { status: res.status });
}
