import { json } from '../../_lib/http';
import { clearAuthCookies } from '../../_lib/cookies';

export async function POST() {
  await clearAuthCookies();
  return json({ ok: true });
}
