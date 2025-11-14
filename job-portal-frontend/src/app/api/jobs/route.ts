import { NextRequest, NextResponse } from 'next/server';
import { backendFetch } from '../_lib/http';

export async function GET(req: NextRequest) {
  const search = req.nextUrl.search || '';
  const path = `/api/v1/jobs${search}`;

  const res = await backendFetch(path);

  const payload = await res.json().catch(() => ({}));
  return NextResponse.json(payload, { status: res.status });
}
