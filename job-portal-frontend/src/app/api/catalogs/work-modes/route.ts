import { NextResponse } from 'next/server';
import { backendFetch } from '../../_lib/http';

export async function GET() {
  const res = await backendFetch('/api/v1/catalogs/work-modes');

  const payload = await res.json().catch(() => []);
  return NextResponse.json(payload, { status: res.status });
}
