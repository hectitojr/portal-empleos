export type RegisterPayload = {
  email: string;
  password: string;
  role: 'APPLICANT' | 'COMPANY';
  acceptTerms: boolean;
  acceptDataPolicy: boolean;
};

export async function loginReq(email: string, password: string) {
  const res = await fetch('/api/auth/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'same-origin',
    body: JSON.stringify({ email, password }),
  });
  const data = await res.json().catch(() => ({}));
  return { ok: res.ok, data };
}

export async function registerReq(payload: RegisterPayload) {
  const res = await fetch('/api/auth/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'same-origin',
    body: JSON.stringify(payload),
  });
  const data = await res.json().catch(() => ({}));
  return { ok: res.ok, data };
}
