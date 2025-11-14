import type { NextRequest } from 'next/server';
import { json } from '../../_lib/http';
import { env } from '@/lib/env';

const BACKEND = env.BACKEND_BASE_URL;

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => ({}));

  const res = await fetch(`${BACKEND}/api/v1/auth/forgot-password`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });

  const data = await res.json().catch(() => ({}));
  return json(data, res.status);
}
