import { NextRequest, NextResponse } from 'next/server';
import { backendFetch } from '../../../../_lib/http';

type Params = { params: { id: string } };

export async function GET(_req: NextRequest, { params }: Params) {
  const { id } = params;

  const res = await backendFetch(`/api/v1/me/applicant/jobs/${id}`);
  const payload = await res.json().catch(() => ({}));
  return NextResponse.json(payload, { status: res.status });
}
