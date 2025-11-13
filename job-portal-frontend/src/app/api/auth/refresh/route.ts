import { json, tryRefresh } from '../../_lib/http';

export async function POST() {
  const ok = await tryRefresh();
  if (!ok) return json({ code: 'TOKEN_REFRESH_FAILED' }, 401);
  return json({ ok: true });
}
