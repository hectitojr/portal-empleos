import { NextRequest, NextResponse } from "next/server";

const BACKEND_BASE = process.env.INTERNAL_API_BASE ?? process.env.NEXT_PUBLIC_API_BASE;

export async function POST(req: NextRequest) {
  try {
    const body = await req.json(); // { email, password, remember? }
    const res = await fetch(`${BACKEND_BASE}/api/v1/auth/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      // NO credentials aquí; esto es server→backend
      body: JSON.stringify(body),
    });

    if (!res.ok) {
      const err = await res.json().catch(() => ({}));
      return NextResponse.json(
        { code: err?.code ?? "LOGIN_FAILED", message: err?.message ?? "Credenciales inválidas" },
        { status: res.status }
      );
    }

    // Esperamos del backend: { accessToken, refreshToken, role, next? }
    const data = await res.json();

    const accessMaxAge = 60 * 15; // 15 min
    const refreshMaxAge = body?.remember ? 60 * 60 * 24 * 14 : 60 * 60 * 24 * 7; // 14d / 7d

    const resp = NextResponse.json({ role: data.role, next: data.next });
    // Cookies seguras
    resp.headers.append(
      "Set-Cookie",
      `jp_at=${data.accessToken}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=${accessMaxAge}`
    );
    resp.headers.append(
      "Set-Cookie",
      `jp_rt=${data.refreshToken}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=${refreshMaxAge}`
    );
    return resp;
  } catch (e) {
    return NextResponse.json({ code: "SERVER_ERROR", message: "Error interno" }, { status: 500 });
  }
}
