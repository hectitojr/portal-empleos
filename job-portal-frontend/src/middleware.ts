import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

const PUBLIC_EXACT = new Set([
  '/',
  '/home',
  '/acerca',
  '/accesibilidad',
  '/terminos',
  '/ayuda',
  '/contacto',
]);

const PUBLIC_PREFIXES = [
  '/auth',      
  '/jobs',   
  '/api/auth', 
];

const APPLICANT_ROOT = '/applicant';
const COMPANY_ROOT = '/company';
const DASHBOARD_ROOT = '/dashboard'; // futuro admin

function isPublic(path: string) {
  if (PUBLIC_EXACT.has(path)) return true;
  return PUBLIC_PREFIXES.some((p) => path.startsWith(p));
}

// Edge safe jwt decode
function decodeJwt(token: string): any | null {
  try {
    const payload = token.split('.')[1];
    if (!payload) return null;
    const b64 = payload.replace(/-/g, '+').replace(/_/g, '/');
    const padded = b64.padEnd(b64.length + (4 - (b64.length % 4)) % 4, '=');
    const json = atob(padded);
    return JSON.parse(json);
  } catch {
    return null;
  }
}

function isExpired(exp?: number): boolean {
  if (!exp) return true;
  const now = Math.floor(Date.now() / 1000);
  return exp <= now;
}

function redirectToLogin(req: NextRequest) {
  const loginUrl = req.nextUrl.clone();
  loginUrl.pathname = '/auth/login';
  loginUrl.searchParams.set('next', req.nextUrl.pathname);
  return NextResponse.redirect(loginUrl);
}

function forceLogout(req: NextRequest) {
  const res = redirectToLogin(req);

  // limpiar cookies del lado cliente
  res.cookies.set('jp_at', '', { path: '/', maxAge: 0 });
  res.cookies.set('jp_rt', '', { path: '/', maxAge: 0 });
  res.cookies.set('jp_at_exp', '', { path: '/', maxAge: 0 });
  res.cookies.set('jp_role', '', { path: '/', maxAge: 0 });

  return res;
}

function redirectByRole(req: NextRequest, role?: string | null) {
  const url = req.nextUrl.clone();

  switch (role) {
    case 'APPLICANT':
      url.pathname = '/applicant';
      return NextResponse.redirect(url);
    case 'COMPANY':
      url.pathname = '/company';
      return NextResponse.redirect(url);
    case 'ADMIN':
      url.pathname = '/dashboard';
      return NextResponse.redirect(url);
    default:
      return forceLogout(req);
  }
}

function normalizeRole(r?: string | null): string | null {
  if (!r) return null;
  let up = r.trim().toUpperCase();
  if (up.startsWith('ROLE_')) up = up.substring(5);
  return up || null;
}

export function middleware(req: NextRequest) {
  const path = req.nextUrl.pathname;

  // 1) rutas públicas
  if (isPublic(path)) {
    return NextResponse.next();
  }

  // 2) leer cookies
  const access = req.cookies.get('jp_at')?.value ?? null;
  const refresh = req.cookies.get('jp_rt')?.value ?? null;

  // 3) sin sesión => login
  if (!access || !refresh) {
    return redirectToLogin(req);
  }

  // 4) validar access
  const payload = decodeJwt(access);
  const exp = payload?.exp as number | undefined;

  if (!payload || isExpired(exp)) {
    // access inválido/expirado => cortar sesión
    return forceLogout(req);
  }

  // 5) rol (prioriza cookie ya normalizada)
  const roleCookie = req.cookies.get('jp_role')?.value;

  const role =
    normalizeRole(roleCookie) ||
    normalizeRole(payload.role) ||
    normalizeRole(payload.roles?.[0]) ||
    normalizeRole(payload.authorities?.[0]);

  // 6) control por rol
  if (path.startsWith(APPLICANT_ROOT) && role !== 'APPLICANT') {
    return redirectByRole(req, role);
  }

  if (path.startsWith(COMPANY_ROOT) && role !== 'COMPANY') {
    return redirectByRole(req, role);
  }

  if (path.startsWith(DASHBOARD_ROOT) && role !== 'ADMIN') {
    return redirectByRole(req, role);
  }

  // 7) /me => al home por rol
  if (path === '/me') {
    return redirectByRole(req, role);
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    '/applicant/:path*',
    '/company/:path*',
    '/dashboard/:path*',
    '/me',
  ],
};
