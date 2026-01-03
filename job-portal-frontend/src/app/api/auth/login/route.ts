import type { NextRequest } from 'next/server';
import { json } from '@/app/api/_lib/http';
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

async function readUpstreamBody(res: Response): Promise<{ bodyText: string; json: any | null }> {
  const bodyText = await res.text().catch(() => '');
  if (!bodyText) return { bodyText: '', json: null };

  try {
    return { bodyText, json: JSON.parse(bodyText) };
  } catch {
    return { bodyText, json: null };
  }
}

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => ({}));

  const res = await fetch(`${BACKEND}/api/v1/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    cache: 'no-store',
    body: JSON.stringify(body),
  });

  const traceId = res.headers.get('x-trace-id') ?? null;
  const { bodyText, json: parsed } = await readUpstreamBody(res);

  if (!res.ok) {
    const payload =
      parsed ??
      ({
        error: 'INTERNAL_ERROR',
        message: bodyText || 'Error en autenticación.',
        status: res.status,
      } as const);

    return json(payload, {
      status: res.status,
      headers: traceId ? { 'x-trace-id': traceId } : undefined,
    });
  }

  const a = (parsed ?? {}) as Partial<AuthResp>;

  if (!a.accessToken || !a.expiresIn || !a.refreshToken) {
    return json(
      {
        error: 'INTERNAL_ERROR',
        message: 'Respuesta inválida del servidor de autenticación.',
        status: 500,
      },
      {
        status: 500,
        headers: traceId ? { 'x-trace-id': traceId } : undefined,
      }
    );
  }

  await setAuthCookies({
    accessToken: a.accessToken,
    expiresIn: a.expiresIn,
    refreshToken: a.refreshToken,
    role: a.role ?? null,
  });

  return json(
    { ok: true },
    {
      status: 200,
      headers: traceId ? { 'x-trace-id': traceId } : undefined,
    }
  );
}
