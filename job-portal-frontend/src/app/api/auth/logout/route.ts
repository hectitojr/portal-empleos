import { NextResponse } from 'next/server';
import { clearAuthCookies } from '@/lib/auth';

export async function POST() {
  const out = NextResponse.json({ ok: true });
  clearAuthCookies(out);
  return out;
}
