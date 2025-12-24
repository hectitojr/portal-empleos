type Args = {
  fullName?: string | null;
  contactEmail?: string | null;
  districtId?: string | null;
  experiencesCount?: number;
  educationsCount?: number;
};

export function computeApplicantProfileProgress(args: Args) {
  const missing: string[] = [];

  const fullNameOk = !!args.fullName && args.fullName.trim().length >= 2;
  const emailOk =
    !!args.contactEmail && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(args.contactEmail.trim());

  const districtOk = !!args.districtId && args.districtId.trim().length > 0;

  const hasExpOrEdu = (args.experiencesCount ?? 0) > 0 || (args.educationsCount ?? 0) > 0;

  if (!fullNameOk) missing.push('Nombre completo');
  if (!emailOk) missing.push('Correo');
  if (!districtOk) missing.push('Ubicación');
  if (!hasExpOrEdu) missing.push('Experiencia o Educación');

  const total = 4;
  const done = total - missing.length;
  const progress = Math.max(0, Math.min(100, Math.round((done / total) * 100)));

  const profileComplete = fullNameOk && emailOk && hasExpOrEdu;

  return { missing, progress, profileComplete };
}
