import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

//
// CONFIGURACIÓN
//
const PUBLIC_PATHS = [
  "/",
  "/home",
  "/auth/login",
  "/auth/register",
  "/auth/forgot-password",
  "/auth/reset-password",
  "/acerca",
  "/accesibilidad",
  "/terminos",
  "/ayuda",
  "/contacto",
];

const DASHBOARD_ROOT = "/dashboard"; // futuro admin
const APPLICANT_ROOT = "/applicant";
const COMPANY_ROOT = "/company";

//
// UTILS
//

// Decodificar JWT sin librerías
function decodeJwt(token: string): any | null {
  try {
    const payload = token.split(".")[1];
    const decoded = JSON.parse(Buffer.from(payload, "base64").toString());
    return decoded;
  } catch {
    return null;
  }
}

// Verificar si exp expira antes de ahora
function isExpired(exp: number | undefined): boolean {
  if (!exp) return true;
  const now = Math.floor(Date.now() / 1000);
  return exp <= now;
}

//
// MIDDLEWARE
//
export async function middleware(req: NextRequest) {
  const url = req.nextUrl;
  const path = url.pathname;

  // 1. Permitir rutas públicas
  if (PUBLIC_PATHS.some((p) => path.startsWith(p))) {
    return NextResponse.next();
  }

  // 2. Leer cookies seguras
  const access = req.cookies.get("jp_at")?.value ?? null;
  const refresh = req.cookies.get("jp_rt")?.value ?? null;

  // 3. Si no hay sesión, requerir login
  if (!access || !refresh) {
    return redirectToLogin(req);
  }

  // 4. Decodificar JWT
  const payload = decodeJwt(access);
  const role = payload?.role;
  const exp = payload?.exp;

  // 5. Si acc expiró → intentar refresh
  if (isExpired(exp)) {
    const refreshed = await tryRefreshToken(req);

    if (!refreshed.ok) {
      return forceLogout();
    }

    // Si se refrescó, dejar continuar con request actual
    return refreshed.response;
  }

  // 6. Validar acceso por rol

  if (path.startsWith(APPLICANT_ROOT)) {
    if (role !== "APPLICANT") return redirectByRole(role);
  }

  if (path.startsWith(COMPANY_ROOT)) {
    if (role !== "COMPANY") return redirectByRole(role);
  }

  // 7. Si intenta acceder a /dashboard (futuro admin)
  if (path.startsWith(DASHBOARD_ROOT)) {
    if (role !== "ADMIN") return redirectByRole(role);
  }

  // 8. Si va a /me → lo redirigimos automáticamente
  if (path === "/me") {
    return redirectByRole(role);
  }

  return NextResponse.next();
}

//
// FUNCIONES DE APOYO
//

function redirectToLogin(req: NextRequest) {
  const loginUrl = new URL("/auth/login", req.url);
  loginUrl.searchParams.set("next", req.nextUrl.pathname);
  return NextResponse.redirect(loginUrl);
}

function forceLogout() {
  const res = NextResponse.redirect(new URL("/auth/login", "http://localhost"));
  res.cookies.set("jp_at", "", { path: "/", maxAge: 0 });
  res.cookies.set("jp_rt", "", { path: "/", maxAge: 0 });
  return res;
}

function redirectByRole(role: string | undefined) {
  switch (role) {
    case "APPLICANT":
      return NextResponse.redirect(new URL("/applicant", "http://localhost"));
    case "COMPANY":
      return NextResponse.redirect(new URL("/company", "http://localhost"));
    case "ADMIN":
      return NextResponse.redirect(new URL("/dashboard", "http://localhost"));
    default:
      return forceLogout();
  }
}

//
// Intento de refresh
//
async function tryRefreshToken(req: NextRequest) {
  try {
    const refresh = req.cookies.get("jp_rt")?.value;
    if (!refresh) return { ok: false };

    const refreshUrl = new URL("/api/auth/refresh", req.url);

    const resp = await fetch(refreshUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ refreshToken: refresh }),
    });

    if (!resp.ok) return { ok: false };

    // Debe devolver nuevas cookies desde el BFF
    const response = NextResponse.next();
    return { ok: true, response };
  } catch (err) {
    return { ok: false };
  }
}

export const config = {
  matcher: [
    "/applicant/:path*",
    "/company/:path*",
    "/dashboard/:path*",
    "/me",
  ],
};
