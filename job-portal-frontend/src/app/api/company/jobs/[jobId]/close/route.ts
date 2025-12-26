import { backendFetch } from '@/app/api/_lib/http';

type Ctx = { params: Promise<{ jobId: string }> };

export async function POST(_req: Request, { params }: Ctx) {
  const { jobId } = await params;

  const res = await backendFetch(`/api/v1/company/jobs/${jobId}/close`, {
    method: 'POST',
    retryOn401: true,
  });

  const text = await res.text();
  return new Response(text, {
    status: res.status,
    headers: { 'Content-Type': 'application/json' },
  });
}
