import type { ApiErrorResponse, ApiResult } from './types';

export class BffHttpError extends Error {
  status: number;
  body: string;
  traceId: string | null;
  error: ApiErrorResponse | null;

  constructor(message: string, args: { status: number; body: string; traceId: string | null; error: ApiErrorResponse | null }) {
    super(message);
    this.name = 'BffHttpError';
    this.status = args.status;
    this.body = args.body;
    this.traceId = args.traceId;
    this.error = args.error;
  }
}

export function tryParseApiError(bodyText?: string): ApiErrorResponse | null {
  if (!bodyText) return null;

  try {
    const parsed = JSON.parse(bodyText);
    if (parsed && typeof parsed === 'object' && typeof (parsed as any).error === 'string') {
      return parsed as ApiErrorResponse;
    }
    return null;
  } catch {
    return null;
  }
}

function buildInit(init?: RequestInit): RequestInit {
  return {
    cache: 'no-store',
    ...init,
    headers: {
      ...(init?.headers || {}),
    },
  };
}

export async function bffFetchResult<T>(path: string, init?: RequestInit): Promise<ApiResult<T>> {
  const res = await fetch(path, buildInit(init));

  const traceId = res.headers.get('x-trace-id');
  const text = await res.text().catch(() => '');

  if (!res.ok) {
    return {
      ok: false,
      status: res.status,
      traceId,
      bodyText: text,
      error: tryParseApiError(text),
    };
  }

  if (!text) {
    return { ok: true, data: null as unknown as T, status: res.status, traceId };
  }

  try {
    const data = JSON.parse(text) as T;
    return { ok: true, data, status: res.status, traceId };
  } catch {

    return {
      ok: false,
      status: 500,
      traceId,
      bodyText: text,
      error: {
        error: 'INTERNAL_ERROR',
        message: 'Respuesta inválida del servidor.',
        status: 500,
        traceId,
      },
    };
  }
}

export async function bffFetchOrThrow<T>(path: string, init?: RequestInit): Promise<T> {
  const result = await bffFetchResult<T>(path, init);

  if (!result.ok) {
    const apiMessage = result.error?.message;
    throw new BffHttpError(apiMessage || 'Error de servidor.', {
      status: result.status,
      body: result.bodyText ?? '',
      traceId: result.traceId ?? null,
      error: result.error ?? null,
    });
  }

  return result.data;
}
