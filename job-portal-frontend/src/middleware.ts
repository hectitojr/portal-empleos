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
  '/jobs',
  '/api/auth',
];

const AUTH_PREFIX = '/auth';

const APPLICANT_ROOT = '/applicant';
const COMPANY_ROOT = '/company';
const DASHBOARD_ROOT = '/dashboard';

function isPublic(path: string) {
  if (PUBLIC_EXACT.has(path)) return true;
  return PUBLIC_PREFIXES.some((p) => path.startsWith(p));
}

function isAuthRoute(path: string) {
  return path === '/auth' || path.startsWith('/auth/');
}

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

  res.cookies.set('jp_at', '', { path: '/', maxAge: 0 });
  res.cookies.set('jp_rt', '', { path: '/', maxAge: 0 });
  res.cookies.set('jp_at_exp', '', { path: '/', maxAge: 0 });
  res.cookies.set('jp_role', '', { path: '/', maxAge: 0 });

  return res;
}

function normalizeRole(r?: string | null): string | null {
  if (!r) return null;
  let up = r.trim().toUpperCase();
  if (up.startsWith('ROLE_')) up = up.substring(5);
  return up || null;
}

function redirectByRole(req: NextRequest, role?: string | null) {
  const url = req.nextUrl.clone();

  switch (role) {
    case 'APPLICANT':
      url.pathname = APPLICANT_ROOT;
      return NextResponse.redirect(url);
    case 'COMPANY':
      url.pathname = COMPANY_ROOT;
      return NextResponse.redirect(url);
    case 'ADMIN':
      url.pathname = DASHBOARD_ROOT;
      return NextResponse.redirect(url);
    default:
      return forceLogout(req);
  }
}

export function middleware(req: NextRequest) {
  const path = req.nextUrl.pathname;

  const access = req.cookies.get('jp_at')?.value ?? null;
  const refresh = req.cookies.get('jp_rt')?.value ?? null;

  if (!access || !refresh) {
    if (isPublic(path) || isAuthRoute(path)) return NextResponse.next();
    return redirectToLogin(req);
  }

  const payload = decodeJwt(access);
  const exp = payload?.exp as number | undefined;

  if (!payload || isExpired(exp)) {
    return forceLogout(req);
  }

  const roleCookie = req.cookies.get('jp_role')?.value;

  const role =
    normalizeRole(roleCookie) ||
    normalizeRole(payload.role) ||
    normalizeRole(payload.roles?.[0]) ||
    normalizeRole(payload.authorities?.[0]);

  if (path === '/' || path === '/home') {
    return redirectByRole(req, role);
  }

  if (isAuthRoute(path)) {
    return redirectByRole(req, role);
  }

  if (path.startsWith(APPLICANT_ROOT) && role !== 'APPLICANT') {
    return redirectByRole(req, role);
  }

  if (path.startsWith(COMPANY_ROOT) && role !== 'COMPANY') {
    return redirectByRole(req, role);
  }

  if (path.startsWith(DASHBOARD_ROOT) && role !== 'ADMIN') {
    return redirectByRole(req, role);
  }

  if (path === '/me') {
    return redirectByRole(req, role);
  }

  if (isPublic(path)) {
    return NextResponse.next();
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    '/',
    '/home',
    '/auth/:path*',
    '/applicant/:path*',
    '/company/:path*',
    '/dashboard/:path*',
    '/me',
    '/jobs/:path*',
    '/api/auth/:path*',
    '/acerca',
    '/accesibilidad',
    '/terminos',
    '/ayuda',
    '/contacto',
  ],
};
