import { NextRequest, NextResponse } from 'next/server';
import { backendFetch } from '../../../_lib/http';

type Ctx = { params: Promise<{ id: string }> };

export async function POST(req: NextRequest, { params }: Ctx) {
  const { id } = await params;
  const body = await req.json().catch(() => ({}));

  const res = await backendFetch(`/api/v1/jobs/${id}/applications`, {
    method: 'POST',
    body: JSON.stringify(body),
  });

  const payload = await res.json().catch(() => ({}));
  return NextResponse.json(payload, { status: res.status });
}
