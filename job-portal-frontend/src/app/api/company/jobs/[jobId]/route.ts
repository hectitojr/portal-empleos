import { backendFetch } from '@/app/api/_lib/http';

type Ctx = { params: Promise<{ jobId: string }> };

export async function PUT(req: Request, { params }: Ctx) {
  const { jobId } = await params;
  const body = await req.text();

  const res = await backendFetch(`/api/v1/company/jobs/${jobId}`, {
    method: 'PUT',
    body,
    retryOn401: true,
  });

  const text = await res.text();
  return new Response(text, {
    status: res.status,
    headers: { 'Content-Type': 'application/json' },
  });
}
