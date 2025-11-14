import { NextRequest, NextResponse } from 'next/server';
import { backendFetch } from '../../_lib/http';

export async function GET(req: NextRequest, ctx: { params: { id: string } }) {
  const { id } = ctx.params;

  const res = await backendFetch(`/api/v1/jobs/${id}`);

  const payload = await res.json().catch(() => ({}));
  return NextResponse.json(payload, { status: res.status });
}
