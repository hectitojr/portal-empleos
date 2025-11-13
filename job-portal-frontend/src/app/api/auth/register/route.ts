import { NextRequest } from 'next/server';
import { json } from '../../_lib/http';
import { setAuthCookies } from '../../_lib/cookies';

type AuthResp = { tokenType: string; accessToken: string; expiresIn: number; refreshToken: string };
const BACKEND = process.env.BACKEND_URL!;

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => ({}));
  const res = await fetch(`${BACKEND}/api/v1/auth/register`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });

  const data = await res.json().catch(() => ({}));
  if (!res.ok) return json(data, res.status);

  const a = data as AuthResp;
  await setAuthCookies({
    accessToken: a.accessToken,
    expiresIn: a.expiresIn,
    refreshToken: a.refreshToken,
  });

  return json({ ok: true }, 201);
}
