import { bffFetchOrThrow, bffFetchResult } from '@/lib/api/bffClient';

export type RegisterPayload = {
  email: string;
  password: string;
  role: 'APPLICANT' | 'COMPANY';
  acceptTerms: boolean;
  acceptDataPolicy: boolean;
};

export type EmployerType = 'COMPANY' | 'FREELANCE';

export type MeResponse = {
  id: string;
  email: string;
  role: 'APPLICANT' | 'COMPANY' | 'ADMIN';

  active: boolean;
  suspended: boolean;

  identityCompleted: boolean;
  employerType: EmployerType | null;
  employerProfileCompleted: boolean;
  employerActive: boolean;
  employerSuspended: boolean;
};

export function loginReq(email: string, password: string) {
  return bffFetchResult('/api/auth/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'same-origin',
    body: JSON.stringify({ email, password }),
  });
}

export function registerReq(payload: RegisterPayload) {
  return bffFetchResult('/api/auth/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'same-origin',
    body: JSON.stringify(payload),
  });
}

export function meReq(): Promise<MeResponse> {
  return bffFetchOrThrow<MeResponse>('/api/auth/me', {
    method: 'GET',
    credentials: 'same-origin',
  });
}

export function logoutReq() {
  return bffFetchResult('/api/auth/logout', {
    method: 'POST',
    credentials: 'same-origin',
  });
}
