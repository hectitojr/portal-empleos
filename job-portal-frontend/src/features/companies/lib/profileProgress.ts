export type CompanyProfileCore = {
  legalName: string | null;
  taxId: string | null;
  contactEmail: string | null;
  districtId: string | null;
};

export function computeCompanyProfileProgress(src: CompanyProfileCore) {
  const legalNameOk = !!src.legalName && src.legalName.trim().length > 0;
  const taxIdOk = !!src.taxId && src.taxId.trim().length > 0;
  const emailOk = !!src.contactEmail && src.contactEmail.trim().length > 0;
  const districtOk = !!src.districtId && src.districtId.trim().length > 0;

  const missing: string[] = [];
  if (!taxIdOk) missing.push('Agregar RUC');
  if (!legalNameOk) missing.push('Completar razón social');
  if (!emailOk) missing.push('Completar correo');
  if (!districtOk) missing.push('Completar ubicación');

  const requiredChecks = [legalNameOk, taxIdOk, emailOk, districtOk];
  const progress = Math.round(
    (requiredChecks.filter(Boolean).length / requiredChecks.length) * 100
  );

  const profileComplete = progress === 100;

  return {
    progress,
    profileComplete,
    missing,
    checks: { legalNameOk, taxIdOk, emailOk, districtOk },
  };
}
