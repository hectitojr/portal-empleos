// ----------------------
// IAM
// ----------------------
export type Role = 'APPLICANT' | 'COMPANY';

export type AuthResponse = {
  tokenType: string;   // "Bearer"
  accessToken: string; // JWT
  expiresIn: number;   // segundos
  refreshToken: string; // opaco
};

export type LoginRequest = { email: string; password: string };
export type RegisterRequest = { email: string; password: string; role: Role };
export type RefreshRequest = { refreshToken: string };


// ----------------------
// JOBS
// ----------------------
export type CompanySummary = {
  id: string;
  legalName: string;
  logoUrl?: string | null;
};

export type JobOffer = {
  id: string;
  title: string;
  status: string;
  disabilityFriendly: boolean;
  suspended: boolean;
  publishedAt?: string | null;
  company: CompanySummary;
  area?: string | null;
  sector?: string | null;
  district?: string | null;
};
