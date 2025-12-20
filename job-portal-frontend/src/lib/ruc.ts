const ALLOWED_PREFIXES = new Set(['10', '15', '16', '17', '20']);

export function normalizeRuc(input: string): string {
  return (input ?? '').replace(/\D/g, '');
}

export function isValidPeruRuc(input: string): boolean {
  const ruc = normalizeRuc(input);

  if (!/^\d{11}$/.test(ruc)) return false;
  if (!ALLOWED_PREFIXES.has(ruc.slice(0, 2))) return false;

  const weights = [5, 4, 3, 2, 7, 6, 5, 4, 3, 2];
  let sum = 0;

  for (let i = 0; i < 10; i++) sum += Number(ruc[i]) * weights[i];

  const remainder = sum % 11;
  let check = 11 - remainder;
  if (check === 10) check = 0;
  if (check === 11) check = 1;

  return Number(ruc[10]) === check;
}
