import { NextRequest, NextResponse } from 'next/server';
import { backendFetch } from '../../_lib/http';

type Ctx = { params: Promise<{ id: string }> };

export async function GET(req: NextRequest, { params }: Ctx) {
  const { id } = await params;

  const res = await backendFetch(`/api/v1/jobs/${id}`);

  const payload = await res.json().catch(() => ({}));
  return NextResponse.json(payload, { status: res.status });
}
