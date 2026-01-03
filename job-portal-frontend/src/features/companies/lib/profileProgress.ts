export type EmployerType = 'COMPANY' | 'FREELANCE';

export type CompanyProfileCore = {
  employerType: EmployerType | null;
  legalName: string | null;
  taxId: string | null;
  contactEmail: string | null;
  districtId: string | null;
};

type ProgressCheck = {
  key: 'legalName' | 'taxId' | 'contactEmail' | 'districtId';
  ok: boolean;
};

export function computeCompanyProfileProgress(src: CompanyProfileCore) {
  const employerType = src.employerType ?? null;

  const legalNameOk = !!src.legalName && src.legalName.trim().length > 0;
  const emailOk = !!src.contactEmail && src.contactEmail.trim().length > 0;
  const districtOk = !!src.districtId && src.districtId.trim().length > 0;

  const requiresTaxId = employerType !== 'FREELANCE';
  const taxIdOk = !requiresTaxId || (!!src.taxId && src.taxId.trim().length > 0);

  const checks: ProgressCheck[] = [
    { key: 'legalName', ok: legalNameOk },
    { key: 'contactEmail', ok: emailOk },
    { key: 'districtId', ok: districtOk },
    ...(requiresTaxId ? [{ key: 'taxId' as const, ok: taxIdOk }] : []),
  ];

  const missing: string[] = [];

  if (!legalNameOk) missing.push('Razón social');
  if (!emailOk) missing.push('Correo');
  if (!districtOk) missing.push('Ubicación');
  if (requiresTaxId && !taxIdOk) missing.push('RUC');

  const progress =
    checks.length === 0
      ? 0
      : Math.round((checks.filter((c) => c.ok).length / checks.length) * 100);

  const profileComplete = progress === 100;

  return {
    progress,
    profileComplete,
    missing,
    requiresTaxId,
    checks: {
      legalNameOk,
      taxIdOk,
      emailOk,
      districtOk,
    },
  };
}
