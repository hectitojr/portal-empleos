import { NextRequest } from 'next/server';
import { json } from '../../_lib/http';

const BACKEND = process.env.BACKEND_URL!;

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => ({}));
  // Si tu backend expone /api/v1/auth/forgot, descomenta el fetch y elimina el 501.
  // const res = await fetch(`${BACKEND}/api/v1/auth/forgot`, { method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify(body) });
  // const data = await res.json().catch(()=>({}));
  // return json(data, res.status);

  return json({ code: 'NOT_IMPLEMENTED', message: 'Recuperación aún no implementada en el backend.' }, 501);
}
