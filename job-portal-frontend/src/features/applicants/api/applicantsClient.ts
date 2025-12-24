export type UUID = string;

export type ApplicantExperienceDto = {
  company: string;
  role: string;
  startDate: string; 
  endDate: string | null;
  description: string | null;
};

export type ApplicantEducationDto = {
  institution: string;
  degree: string;
  startDate: string; 
  endDate: string | null;
  description: string | null;
};

export type ApplicantSkillDto = {
  name: string;
  level: string | null;
};

export type ApplicantMeResponse = {
  id: UUID;
  fullName: string;
  contactEmail: string;
  contactPhone: string | null;
  districtId: UUID | null;
  profileSummary: string | null;
  profileComplete: boolean;
  active: boolean;
  suspended: boolean;
  experiences: ApplicantExperienceDto[];
  educations: ApplicantEducationDto[];
  skills: ApplicantSkillDto[];
  disabilityIds: UUID[];
};

export type ApplicantUpsertRequest = {
  fullName: string;
  contactEmail: string;
  contactPhone: string | null;
  districtId: UUID | null;
  profileSummary: string | null;
  experiences: ApplicantExperienceDto[];
  educations: ApplicantEducationDto[];
  skills: ApplicantSkillDto[];
  disabilityIds: UUID[]; 
};

const APPLICANT_ME_ENDPOINT = '/api/applicants/me';

async function fetchJson<T>(input: RequestInfo, init?: RequestInit): Promise<T> {
  const res = await fetch(input, init);
  if (!res.ok) {
    const text = await res.text().catch(() => '');
    const err: any = new Error('Request failed');
    err.status = res.status;
    err.body = text;
    throw err;
  }
  return res.json();
}

export function getMyApplicant(): Promise<ApplicantMeResponse> {
  return fetchJson<ApplicantMeResponse>(APPLICANT_ME_ENDPOINT, { method: 'GET' });
}

export function upsertMyApplicant(payload: ApplicantUpsertRequest): Promise<ApplicantMeResponse> {
  return fetchJson<ApplicantMeResponse>(APPLICANT_ME_ENDPOINT, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
  });
}
