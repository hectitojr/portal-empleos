import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

// Rutas que requieren sesión
const PROTECTED_PREFIXES = [
  '/me',
  '/applications',
  '/company',
  '/admin',
  '/applicant',
  '/dashboard', // si tienes panel genérico
];

export function middleware(req: NextRequest) {
  const { pathname } = req.nextUrl;

  // ¿Requiere auth?
  const requiresAuth = PROTECTED_PREFIXES.some((p) => pathname.startsWith(p));
  if (!requiresAuth) return NextResponse.next();

  // Cookie que setea el BFF en /app/api/auth/*
  const hasAccess = Boolean(req.cookies.get('jp_at')?.value);
  if (!hasAccess) {
    const url = req.nextUrl.clone();
    url.pathname = '/auth/login';
    // preserva el next con su querystring original
    url.searchParams.set('next', pathname + (req.nextUrl.search || ''));
    return NextResponse.redirect(url);
  }

  return NextResponse.next();
}

// Ejecuta SOLO en rutas privadas (evitas /api, /_next, etc.)
export const config = {
  matcher: [
    '/me/:path*',
    '/applications/:path*',
    '/company/:path*',
    '/admin/:path*',
    '/applicant/:path*',
    '/dashboard/:path*',
  ],
};
