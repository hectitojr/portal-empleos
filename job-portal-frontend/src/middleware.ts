import { NextResponse, NextRequest } from 'next/server';

export function middleware(req: NextRequest) {
  const { pathname, searchParams } = req.nextUrl;
  const isDashboard =
    pathname.startsWith('/me') ||
    pathname.startsWith('/applications') ||
    pathname.startsWith('/company') ||
    pathname.startsWith('/admin');

  if (isDashboard) {
    const hasAccess = req.cookies.get('access_token')?.value;
    if (!hasAccess) {
      const url = req.nextUrl.clone();
      url.pathname = '/auth/login';
      url.searchParams.set('next', pathname + (searchParams.toString() ? `?${searchParams}` : ''));
      return NextResponse.redirect(url);
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: ['/((?!_next|favicon.ico|api).*)']
};
