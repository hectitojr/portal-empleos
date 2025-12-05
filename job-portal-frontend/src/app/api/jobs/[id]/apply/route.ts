import { NextRequest, NextResponse } from 'next/server';
import { backendFetch } from '../../../_lib/http';

type Params = { params: { id: string } };

export async function POST(req: NextRequest, { params }: Params) {
  const { id } = params;
  const body = await req.json().catch(() => ({}));

  const res = await backendFetch(`/api/v1/jobs/${id}/applications`, {
    method: 'POST',
    body: JSON.stringify(body),
  });

  const payload = await res.json().catch(() => ({}));
  return NextResponse.json(payload, { status: res.status });
}
