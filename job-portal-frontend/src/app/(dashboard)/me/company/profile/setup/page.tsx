'use client';

import { useEffect, useMemo, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import type { SubmitHandler } from 'react-hook-form';
import { Controller, useForm } from 'react-hook-form';
import { Info } from 'lucide-react';
import type { Route } from 'next';

import ConfirmDialog from '@/app/components/ui/ConfirmDialog';
import { useUnsavedChangesGuard } from '@/app/components/navigation/useUnsavedChangesGuard';
import { useNavigationGuard } from '@/app/components/navigation/NavigationGuardProvider';

import FlashBanner from '@/app/components/ui/FlashBanner';
import { useDismissOnDirty } from '@/app/components/ui/useDismissOnDirty';

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/app/components/ui/select';

import { computeCompanyProfileProgress } from '@/features/companies/lib/profileProgress';
import { routes } from '@/lib/routes';
import { applyApiErrorToForm } from '@/lib/apiError';
import { isValidPeruRuc, normalizeRuc } from '@/lib/ruc';
import { bffFetchOrThrow } from '@/lib/api/bffClient';

import {
  getMyCompany,
  updateMyCompany,
  type CompanyUpdateRequest,
  type EmployerType,
} from '@/features/companies/api/companiesClient';

import { useMe } from '@/features/iam/hooks/useMe';
import { useUpdateMyIdentity } from '@/features/iam/hooks/useUpdateMyIdentity';
import type { DocumentType } from '@/features/iam/api/iamClient';

type UUID = string;

const DEPARTMENTS_ENDPOINT = '/api/catalogs/departments';
const PROVINCES_ENDPOINT = '/api/catalogs/provinces';
const DISTRICTS_ENDPOINT = '/api/catalogs/districts';
const DISTRICT_RESOLVE_ENDPOINT = (id: string) => `/api/catalogs/districts/${id}`;

const RUC_LENGTH = 11;
const ALLOWED_RUC_PREFIXES = new Set(['10', '15', '16', '17', '20']);

const PHONE_REGEX = /^(\d{7}|\d{9})$/;

type GeoItem = { id: UUID; name: string };
type DistrictResolveResponse = { id: UUID; name: string; provinceId: UUID; departmentId: UUID };

type FormValues = {
  employerType: EmployerType | '';

  legalName: string;
  taxId: string;
  contactEmail: string;
  contactPhone: string;

  departmentId: string;
  provinceId: string;
  districtId: string;
};

type IdentityFormValues = {
  documentType: DocumentType;
  documentNumber: string;
};

function normalizeIdentity(docType: DocumentType, raw: string) {
  const t = (raw ?? '').trim();
  if (!t) return '';

  if (docType === 'DNI' || docType === 'CE') {
    const digits = t.replace(/\D+/g, '');
    return digits;
  }

  return t.replace(/\s+/g, '').toUpperCase();
}

function validateIdentity(docType: DocumentType, normalized: string) {
  if (!normalized) return 'El número de documento es requerido.';

  if (docType === 'DNI') {
    return /^\d{8}$/.test(normalized) ? null : 'DNI inválido. Debe tener 8 dígitos.';
  }

  if (docType === 'CE') {
    return /^\d{9,12}$/.test(normalized) ? null : 'CE inválido. Debe tener entre 9 y 12 dígitos.';
  }

  return /^[A-Z0-9]{6,12}$/.test(normalized)
    ? null
    : 'Pasaporte inválido. Usa 6 a 12 caracteres alfanuméricos.';
}

function normalizeEmployerType(raw: unknown): EmployerType | '' {
  const v = String(raw ?? '')
    .trim()
    .toUpperCase();
  if (v === 'COMPANY') return 'COMPANY';
  if (v === 'FREELANCE') return 'FREELANCE';
  return '';
}

export default function CompanyProfileSetupPage() {
  const router = useRouter();
  const qc = useQueryClient();

  const [serverError, setServerError] = useState<string | null>(null);
  const [serverOk, setServerOk] = useState<string | null>(null);

  const [okVisible, setOkVisible] = useState(false);
  const okAnimateMs = 900;

  const [confirmOpen, setConfirmOpen] = useState(false);

  const guard = useNavigationGuard();

  function openConfirm() {
    setConfirmOpen(true);
  }

  function closeConfirm() {
    setConfirmOpen(false);
    guard.cancelLeave();
  }

  function confirmLeave() {
    setConfirmOpen(false);
    guard.confirmLeave();
  }

  const authMeQuery = useMe();

  const meQuery = useQuery({
    queryKey: ['company', 'me'],
    queryFn: getMyCompany,
    staleTime: 30_000,
  });

  const companyMe = meQuery.data;

  const form = useForm<FormValues>({
    mode: 'onChange',
    defaultValues: {
      employerType: '',
      legalName: '',
      taxId: '',
      contactEmail: '',
      contactPhone: '',
      departmentId: '',
      provinceId: '',
      districtId: '',
    },
  });

  const initialRef = useRef<FormValues>(form.getValues());

  form.register('departmentId');
  form.register('provinceId', {
    validate: (v, values) => {
      const dept = (values.departmentId ?? '').trim();
      const prov = (v ?? '').trim();
      if (!dept) return true;
      return prov ? true : 'Selecciona una provincia.';
    },
  });

  form.register('districtId', {
    validate: (v, values) => {
      const dept = (values.departmentId ?? '').trim();
      const prov = (values.provinceId ?? '').trim();
      const dist = (v ?? '').trim();
      if (!dept) return true;
      if (!prov) return true;
      return dist ? true : 'Selecciona un distrito.';
    },
  });

  const watched = form.watch();
  const departmentId = watched.departmentId;
  const provinceId = watched.provinceId;
  const districtId = watched.districtId;

  const departmentsQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'departments'],
    queryFn: () => bffFetchOrThrow<GeoItem[]>(DEPARTMENTS_ENDPOINT, { method: 'GET' }),
    staleTime: 24 * 60 * 60 * 1000,
  });

  const provincesQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'provinces', departmentId],
    queryFn: () =>
      bffFetchOrThrow<GeoItem[]>(
        `${PROVINCES_ENDPOINT}?departmentId=${encodeURIComponent(departmentId)}`,
        { method: 'GET' }
      ),
    enabled: !!departmentId,
    staleTime: 24 * 60 * 60 * 1000,
  });

  const districtsQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'districts', provinceId],
    queryFn: () =>
      bffFetchOrThrow<GeoItem[]>(
        `${DISTRICTS_ENDPOINT}?provinceId=${encodeURIComponent(provinceId)}`,
        { method: 'GET' }
      ),
    enabled: !!provinceId,
    staleTime: 24 * 60 * 60 * 1000,
  });

  const resolveQuery = useQuery<DistrictResolveResponse>({
    queryKey: ['catalogs', 'geo', 'district-resolve', companyMe?.districtId ?? null],
    queryFn: () =>
      bffFetchOrThrow<DistrictResolveResponse>(DISTRICT_RESOLVE_ENDPOINT(companyMe!.districtId!), {
        method: 'GET',
      }),
    enabled: !!companyMe?.districtId,
    staleTime: 5 * 60 * 1000,
  });

  useEffect(() => {
    if (!companyMe) return;

    const r = resolveQuery.data;

    const nextEmployerType = normalizeEmployerType(companyMe.employerType);

    const nextValues: FormValues = {
      employerType: nextEmployerType,
      legalName: companyMe.legalName ?? '',
      taxId: companyMe.taxId ? normalizeRuc(companyMe.taxId).slice(0, RUC_LENGTH) : '',
      contactEmail: companyMe.contactEmail ?? '',
      contactPhone: (companyMe.contactPhone ?? '').replace(/\D+/g, '').slice(0, 9),
      departmentId: r?.departmentId ?? '',
      provinceId: r?.provinceId ?? '',
      districtId: companyMe.districtId ?? '',
    };

    initialRef.current = nextValues;
    form.reset(nextValues, { keepTouched: false, keepDirty: false });
  }, [companyMe, resolveQuery.data, form]);

  useEffect(() => {
    const r = resolveQuery.data;
    if (!r) return;

    const curDept = form.getValues('departmentId');
    const curProv = form.getValues('provinceId');
    const curDist = form.getValues('districtId');

    const needsSync = curDept !== r.departmentId || curProv !== r.provinceId || curDist !== r.id;
    if (!needsSync) return;

    form.setValue('departmentId', r.departmentId, { shouldDirty: false, shouldTouch: false });
    form.setValue('provinceId', r.provinceId, { shouldDirty: false, shouldTouch: false });
    form.setValue('districtId', r.id, { shouldDirty: false, shouldTouch: false });
  }, [resolveQuery.data, form]);

  const updateMutation = useMutation({
    mutationFn: async (payload: CompanyUpdateRequest) => updateMyCompany(payload),
    onMutate: () => {
      setServerError(null);
      setServerOk(null);
      setOkVisible(false);
    },
    onSuccess: async () => {
      const current = form.getValues();
      initialRef.current = current;

      form.reset(current, {
        keepTouched: true,
        keepDirty: false,
      });

      setServerOk('Perfil actualizado correctamente.');
      setOkVisible(true);

      await qc.invalidateQueries({ queryKey: ['company', 'me'] });
      await qc.invalidateQueries({ queryKey: ['auth', 'me'] });
    },
    onError: (err: unknown) => {
      const msg = applyApiErrorToForm<FormValues>({
        err,
        setError: form.setError,
      });

      setServerError(msg);
    },
  });

  const computed = useMemo(() => {
    const employerType = watched.employerType;

    const employerTypeSelected = employerType === 'COMPANY' || employerType === 'FREELANCE';

    const legalName = watched.legalName.trim();
    const taxId = watched.taxId.trim();
    const email = watched.contactEmail.trim();
    const phone = watched.contactPhone.trim();

    const department = watched.departmentId.trim();
    const province = watched.provinceId.trim();
    const district = watched.districtId.trim();

    const geoAllEmpty = department.length === 0 && province.length === 0 && district.length === 0;
    const geoAllComplete = department.length > 0 && province.length > 0 && district.length > 0;

    const geoStateOk = geoAllEmpty || geoAllComplete;

    const geoErrors = {
      province: department && !province ? 'Selecciona una provincia.' : undefined,
      district: department && province && !district ? 'Selecciona un distrito.' : undefined,
    };

    const legalNameOkUx = legalName.length === 0 || legalName.length >= 2;

    const taxIdOkUx =
      employerType === 'FREELANCE'
        ? true
        : employerType === 'COMPANY'
          ? taxId.length === RUC_LENGTH && isValidPeruRuc(taxId)
          : false;

    const emailOkUx = email.length === 0 || /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    const phoneOkUx = phone.length === 0 || PHONE_REGEX.test(phone);

    const progressState = computeCompanyProfileProgress({
      employerType: employerTypeSelected ? (employerType as EmployerType) : null,
      legalName: watched.legalName.trim() || null,
      taxId: employerType === 'FREELANCE' ? null : watched.taxId.trim() || null,
      contactEmail: watched.contactEmail.trim() || null,
      districtId: watched.districtId.trim() || null,
    });

    return {
      employerTypeSelected,

      legalNameOk: legalNameOkUx,
      taxIdOk: taxIdOkUx,
      emailOk: emailOkUx,
      phoneOk: phoneOkUx,

      geoAllEmpty,
      geoAllComplete,
      geoStateOk,
      geoErrors,

      missing: progressState.missing,
      progress: progressState.progress,
      recommendedComplete: progressState.profileComplete,
      requiresTaxId: progressState.requiresTaxId,
    };
  }, [watched]);

  const canSubmit =
    computed.employerTypeSelected &&
    computed.legalNameOk &&
    computed.taxIdOk &&
    computed.emailOk &&
    computed.phoneOk &&
    computed.geoStateOk &&
    !updateMutation.isPending;

  useDismissOnDirty({
    isDirty: form.formState.isDirty,
    active: !!serverOk && okVisible,
    animateMs: okAnimateMs,
    onHide: () => setOkVisible(false),
    onClear: () => setServerOk(null),
  });

  const onSubmit: SubmitHandler<FormValues> = async (values) => {
    setServerError(null);
    setServerOk(null);
    setOkVisible(false);

    const dept = values.departmentId.trim();
    const prov = values.provinceId.trim();
    const dist = values.districtId.trim();

    const geoAllEmpty = dept === '' && prov === '' && dist === '';
    const geoAllComplete = dept !== '' && prov !== '' && dist !== '';

    const geoOk = await form.trigger(['provinceId', 'districtId']);
    if (!geoOk) {
      setServerError('Completa la ubicación antes de guardar o déjala vacía.');
      return;
    }

    const type = values.employerType;
    if (type !== 'COMPANY' && type !== 'FREELANCE') {
      setServerError('Selecciona un tipo de empleador antes de guardar.');
      return;
    }

    const rawPhone = values.contactPhone.trim();
    const normalizedPhone = rawPhone.replace(/\D+/g, '').slice(0, 9);
    if (normalizedPhone && !PHONE_REGEX.test(normalizedPhone)) {
      setServerError('Ingresa un teléfono válido de 7 o 9 dígitos.');
      form.setError('contactPhone', { type: 'validate', message: 'Ingresa 7 o 9 dígitos.' });
      return;
    }

    const payload: CompanyUpdateRequest = {
      employerType: type,
      legalName: values.legalName.trim() ? values.legalName.trim() : null,
      taxId:
        type === 'COMPANY'
          ? values.taxId.trim()
            ? normalizeRuc(values.taxId).slice(0, RUC_LENGTH)
            : null
          : null,
      contactEmail: values.contactEmail.trim() ? values.contactEmail.trim() : null,
      contactPhone: normalizedPhone ? normalizedPhone : null,
      districtId: geoAllComplete ? values.districtId : geoAllEmpty ? null : null,
    };

    await updateMutation.mutateAsync(payload);
  };

  const isLoading = meQuery.isLoading;
  const loadError = meQuery.error as any;

  const depsLoading =
    departmentsQuery.isLoading || (resolveQuery.isLoading && !!companyMe?.districtId) || false;

  const geoError = (departmentsQuery.error as any) || (resolveQuery.error as any) || null;

  const hasUnsavedChanges = form.formState.isDirty && !updateMutation.isPending;

  useUnsavedChangesGuard({
    enabled: hasUnsavedChanges,
    message: 'Tienes cambios sin guardar.',
    onOpenConfirm: () => openConfirm(),
    onConfirmLeave: async () => {
      form.reset(initialRef.current, { keepTouched: false, keepDirty: false });

      await new Promise<void>((r) => requestAnimationFrame(() => r()));
    },
    onCancelLeave: () => {
      setConfirmOpen(false);
    },
  });

  function guardedNavigate(path: Route) {
    if (!hasUnsavedChanges) {
      router.push(path);
      return;
    }

    guard.setPendingNavigate(() => router.push(path));
    guard.pingOpenConfirm();
  }

  const identityForm = useForm<IdentityFormValues>({
    mode: 'onChange',
    defaultValues: { documentType: 'DNI', documentNumber: '' },
  });

  const identityMutation = useUpdateMyIdentity();

  const identityWatched = identityForm.watch();
  const normalizedIdentity = useMemo(
    () => normalizeIdentity(identityWatched.documentType, identityWatched.documentNumber),
    [identityWatched.documentType, identityWatched.documentNumber]
  );

  const identityError = useMemo(() => {
    if (!identityForm.formState.touchedFields.documentNumber) return null;
    return validateIdentity(identityWatched.documentType, normalizedIdentity);
  }, [
    identityForm.formState.touchedFields.documentNumber,
    identityWatched.documentType,
    normalizedIdentity,
  ]);

  const identityCompleted = authMeQuery.me?.identityCompleted === true;
  const employerProfileCompleted = authMeQuery.me?.employerProfileCompleted === true;

  const composedReady =
    authMeQuery.me?.role === 'COMPANY' &&
    identityCompleted &&
    employerProfileCompleted &&
    authMeQuery.me?.employerActive === true &&
    authMeQuery.me?.employerSuspended === false;

  async function submitIdentity() {
    setServerError(null);
    setServerOk(null);
    setOkVisible(false);

    const n = normalizedIdentity;
    const err = validateIdentity(identityWatched.documentType, n);

    if (err) {
      identityForm.setError('documentNumber', { type: 'validate', message: err });
      return;
    }

    try {
      await identityMutation.mutateAsync({
        documentType: identityWatched.documentType,
        documentNumber: n,
      });

      setServerOk('Identidad actualizada correctamente.');
      setOkVisible(true);

      identityForm.reset(
        { documentType: identityWatched.documentType, documentNumber: '' },
        { keepDirty: false, keepTouched: false }
      );
    } catch (e: any) {
      setServerError(e?.message || 'No se pudo actualizar la identidad.');
    }
  }

  const taxIdReg = form.register('taxId', {
    onBlur: () => {
      form.trigger('taxId');
    },
  });

  const phoneReg = form.register('contactPhone', {
    onBlur: () => {
      form.trigger('contactPhone');
    },
  });

  return (
    <section className="flex-1 min-h-0 bg-slate-50 px-4 py-8">
      <div className="max-w-4xl mx-auto">
        <header className="mb-6">
          <div className="mb-3">
            <button
              type="button"
              onClick={() => guardedNavigate('/company')}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              ← Volver al panel
            </button>
          </div>

          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
            Configura tu perfil de empleador
          </h1>
          <p className="mt-2 text-sm sm:text-base text-slate-600">
            Para publicar ofertas debes completar tu{' '}
            <span className="font-semibold">Identidad</span> y tu{' '}
            <span className="font-semibold">Perfil de empleador</span>.
          </p>
        </header>

        {isLoading && (
          <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6">
            <p className="text-sm text-slate-600">Cargando tu información…</p>
          </div>
        )}

        {loadError && !isLoading && (
          <div className="bg-white rounded-2xl shadow-sm border border-red-200 p-6">
            <p className="text-sm text-red-700 font-semibold">No se pudo cargar tu perfil.</p>
            <p className="mt-1 text-sm text-slate-600">
              Intenta recargar. Si el problema persiste, revisa tu sesión.
            </p>

            <div className="mt-4 flex gap-3">
              <button
                type="button"
                onClick={() => meQuery.refetch()}
                className="inline-flex items-center justify-center rounded-2xl bg-slate-900 px-4 py-2.5 text-white text-sm font-semibold hover:bg-slate-800 transition"
              >
                Reintentar
              </button>

              <button
                type="button"
                onClick={() => router.push(routes.public.login)}
                className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
              >
                Ir al login
              </button>
            </div>
          </div>
        )}

        {!isLoading && !loadError && (
          <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6 sm:p-8">
            <div className="mb-6 rounded-2xl border border-slate-100 bg-slate-50 p-4">
              <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                <div>
                  <p className="text-sm font-semibold text-slate-900">Estado de publicación</p>
                </div>

                <div className="flex items-center gap-2 flex-wrap">
                  <StatusPill
                    label={identityCompleted ? 'Identidad completada' : 'Identidad pendiente'}
                    tone={identityCompleted ? 'ok' : 'warn'}
                    help={
                      identityCompleted
                        ? 'Tu identidad fue registrada.'
                        : 'Registra tu documento para habilitar acciones críticas.'
                    }
                  />

                  <StatusPill
                    label={companyMe?.profileComplete ? 'Perfil completado' : 'Perfil pendiente'}
                    tone={companyMe?.profileComplete ? 'ok' : 'warn'}
                    help={
                      companyMe?.profileComplete
                        ? 'Tu perfil cumple los mínimos.'
                        : 'Completa los datos mínimos del perfil.'
                    }
                  />

                  <StatusPill
                    label={composedReady ? 'Publicación habilitada' : 'Publicación bloqueada'}
                    tone={composedReady ? 'ok' : 'danger'}
                    help={
                      composedReady
                        ? 'Puedes publicar ofertas.'
                        : 'Faltan requisitos o existe un bloqueo por estado.'
                    }
                  />

                  <StatusPill
                    label={companyMe?.active ? 'Activo' : 'Inactiva'}
                    tone={companyMe?.active ? 'ok' : 'neutral'}
                    help={
                      companyMe?.active
                        ? 'Tu empresa está habilitada para usar el portal.'
                        : 'Tu empresa está deshabilitada; contacta soporte si no reconoces este estado.'
                    }
                  />

                  <StatusPill
                    label={companyMe?.suspended ? 'Suspendida' : 'Sin suspensión'}
                    tone={companyMe?.suspended ? 'danger' : 'ok'}
                    help={
                      companyMe?.suspended
                        ? 'Tu empresa tiene un bloqueo por moderación o revisión.'
                        : 'Tu empresa no tiene bloqueos por moderación.'
                    }
                  />
                </div>
              </div>

              <div className="mt-3">
                <div className="flex items-center justify-between text-xs text-slate-600">
                  <span>{computed.progress}%</span>
                  <span>Progreso del perfil (companies)</span>
                </div>
                <div className="mt-2 h-2 rounded-full bg-slate-200 overflow-hidden">
                  <div
                    className="h-full rounded-full bg-blue-700"
                    style={{ width: `${computed.progress}%` }}
                  />
                </div>

                {computed.missing.length > 0 && (
                  <p className="mt-3 text-sm text-slate-600">
                    Te falta completar:{' '}
                    <span className="font-semibold text-slate-900">
                      {computed.missing.join(', ')}.
                    </span>
                  </p>
                )}
              </div>
            </div>

            {geoError && (
              <div className="mb-4 rounded-2xl border border-amber-200 bg-amber-50 p-4">
                <p className="text-sm text-amber-900 font-semibold">
                  No se pudieron cargar los catálogos de ubicación.
                </p>
                <p className="mt-1 text-sm text-slate-600">
                  Puedes continuar con el resto del formulario e intentar de nuevo.
                </p>

                <div className="mt-3">
                  <button
                    type="button"
                    onClick={() => {
                      departmentsQuery.refetch();
                      resolveQuery.refetch();
                    }}
                    className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
                  >
                    Reintentar catálogos
                  </button>
                </div>
              </div>
            )}

            <FlashBanner
              message={serverError}
              tone="error"
              autoDismissMs={6000}
              onClear={() => setServerError(null)}
            />

            <FlashBanner
              message={okVisible ? serverOk : null}
              tone="success"
              autoDismissMs={5000}
              animateMs={okAnimateMs}
              onClear={() => {
                setServerOk(null);
                setOkVisible(false);
              }}
            />

            <ConfirmDialog
              open={confirmOpen}
              title="Tienes cambios sin guardar"
              description="Si sales ahora, perderás los cambios realizados en este formulario."
              confirmText="Descartar cambios"
              cancelText="Seguir editando"
              destructive
              busy={updateMutation.isPending}
              onCancel={closeConfirm}
              onConfirm={confirmLeave}
            />

            {/* ✅ Identidad: compacta si está completada, formulario solo si falta */}
            <section className="mb-8 rounded-2xl border border-slate-100 bg-white p-5">
              <div className="flex items-start justify-between gap-3">
                <div>
                  <h2 className="text-lg font-semibold text-slate-900">Identidad</h2>

                  {!identityCompleted && (
                    <p className="mt-1 text-sm text-slate-600">
                      Registra tu documento para habilitar la publicación de empleos y otras
                      acciones críticas.
                    </p>
                  )}

                  {identityCompleted && (
                    <p className="mt-1 text-sm text-slate-600">Tu identidad ya está completada.</p>
                  )}
                </div>

                {identityCompleted && (
                  <span className="inline-flex items-center rounded-full border border-emerald-200 bg-emerald-50 px-3 py-1 text-xs font-semibold text-emerald-800">
                    ✓ Completada
                  </span>
                )}
              </div>

              {!identityCompleted && (
                <div className="mt-4 grid gap-4 sm:grid-cols-3">
                  <Field label="Tipo de documento" required>
                    <select
                      className={selectClass(false, false)}
                      {...identityForm.register('documentType')}
                    >
                      <option value="DNI">DNI</option>
                      <option value="CE">CE</option>
                      <option value="PASSPORT">Pasaporte</option>
                    </select>
                  </Field>

                  <Field
                    label="Número de documento"
                    required
                    error={
                      (identityForm.formState.errors.documentNumber?.message as
                        | string
                        | undefined) ??
                      identityError ??
                      undefined
                    }
                  >
                    <input
                      className={inputClass(!!identityError)}
                      placeholder={
                        identityWatched.documentType === 'DNI'
                          ? '8 dígitos'
                          : identityWatched.documentType === 'CE'
                            ? '9–12 dígitos'
                            : '6–12 alfanuméricos'
                      }
                      {...identityForm.register('documentNumber', {
                        onBlur: () => {
                          const n = normalizeIdentity(
                            identityWatched.documentType,
                            identityWatched.documentNumber
                          );
                          const err = validateIdentity(identityWatched.documentType, n);
                          if (err)
                            identityForm.setError('documentNumber', {
                              type: 'validate',
                              message: err,
                            });
                          else identityForm.clearErrors('documentNumber');
                        },
                      })}
                    />
                  </Field>

                  <div className="flex items-end">
                    <button
                      type="button"
                      onClick={submitIdentity}
                      disabled={identityMutation.isPending}
                      className="inline-flex w-full items-center justify-center rounded-2xl bg-blue-700 px-4 py-2.5 text-white text-sm font-semibold hover:bg-blue-800 transition disabled:opacity-60 disabled:cursor-not-allowed"
                    >
                      {identityMutation.isPending ? 'Guardando…' : 'Guardar identidad'}
                    </button>
                  </div>
                </div>
              )}
            </section>

            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
              <section>
                <h2 className="text-lg font-semibold text-slate-900">Perfil de empleador</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Estos datos ayudan a validar el perfil y mejorar la confianza de los postulantes.
                </p>

                <div className="mt-4 grid gap-4 sm:grid-cols-2">
                  <Field
                    label="Tipo de empleador"
                    required
                    error={form.formState.errors.employerType?.message as string | undefined}
                    hint={
                      watched.employerType === 'COMPANY'
                        ? 'Requiere RUC para poder publicar ofertas.'
                        : undefined
                    }
                  >
                    <div className="max-w-sm">
                      <Controller
                        control={form.control}
                        name="employerType"
                        rules={{ required: 'Selecciona un tipo de empleador.' }}
                        render={({ field }) => (
                          <Select
                            key={field.value ?? 'empty'}
                            value={field.value ? String(field.value) : undefined}
                            onValueChange={(val) => {
                              const next = normalizeEmployerType(val) as EmployerType;
                              field.onChange(next);

                              form.setValue('employerType', next, {
                                shouldDirty: true,
                                shouldTouch: true,
                                shouldValidate: true,
                              });

                              if (next === 'FREELANCE') {
                                form.setValue('taxId', '', {
                                  shouldDirty: true,
                                  shouldTouch: false,
                                  shouldValidate: true,
                                });
                                form.clearErrors('taxId');
                              }
                            }}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Selecciona tipo de empleador…" />
                            </SelectTrigger>

                            <SelectContent>
                              <SelectItem value="COMPANY">Empresa</SelectItem>
                              <SelectItem value="FREELANCE">Reclutador independiente</SelectItem>
                            </SelectContent>
                          </Select>
                        )}
                      />
                    </div>
                  </Field>

                  <div className="hidden sm:block" />

                  <Field
                    label="Razón social / Nombre a mostrar"
                    required
                    error={
                      form.formState.touchedFields.legalName &&
                      watched.legalName.trim().length > 0 &&
                      !computed.legalNameOk
                        ? 'Debe tener al menos 2 caracteres.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(
                        form.formState.touchedFields.legalName &&
                          watched.legalName.trim().length > 0 &&
                          !computed.legalNameOk
                      )}
                      placeholder={
                        watched.employerType === 'FREELANCE'
                          ? 'Ej: Reclutador Juan Pérez'
                          : 'Ej: ACME SAC'
                      }
                      {...form.register('legalName')}
                    />
                  </Field>

                  {watched.employerType === 'COMPANY' && (
                    <Field
                      label="RUC"
                      required
                      hint="11 dígitos. Solo números."
                      error={
                        !form.formState.touchedFields.taxId
                          ? undefined
                          : watched.taxId.trim().length === 0
                            ? 'El RUC es requerido.'
                            : watched.taxId.trim().length < RUC_LENGTH
                              ? 'Debe tener 11 dígitos.'
                              : watched.taxId.trim().length === RUC_LENGTH &&
                                  !ALLOWED_RUC_PREFIXES.has(watched.taxId.trim().slice(0, 2))
                                ? 'Prefijo inválido. Debe comenzar con 10, 15, 16, 17 o 20.'
                                : watched.taxId.trim().length === RUC_LENGTH &&
                                    !isValidPeruRuc(watched.taxId.trim())
                                  ? 'RUC inválido. Verifica el número.'
                                  : undefined
                      }
                    >
                      <input
                        className={inputClass(
                          !!(
                            form.formState.touchedFields.taxId &&
                            watched.taxId.trim().length > 0 &&
                            watched.taxId.trim().length === RUC_LENGTH &&
                            !computed.taxIdOk
                          )
                        )}
                        placeholder="Ej: 20123456789"
                        inputMode="numeric"
                        maxLength={RUC_LENGTH}
                        autoComplete="off"
                        {...taxIdReg}
                        onChange={(e) => {
                          const raw = e.target.value ?? '';
                          const next = raw.replace(/\D+/g, '').slice(0, RUC_LENGTH);

                          taxIdReg.onChange({
                            ...e,
                            target: { ...e.target, value: next },
                          } as any);

                          form.setValue('taxId', next, {
                            shouldDirty: true,
                            shouldTouch: true,
                            shouldValidate: true,
                          });
                        }}
                        onPaste={(e) => {
                          e.preventDefault();
                          const pasted = e.clipboardData.getData('text') ?? '';
                          const next = pasted.replace(/\D+/g, '').slice(0, RUC_LENGTH);

                          form.setValue('taxId', next, {
                            shouldDirty: true,
                            shouldTouch: true,
                            shouldValidate: true,
                          });
                        }}
                      />
                    </Field>
                  )}

                  {watched.employerType === 'FREELANCE' && <div className="hidden sm:block" />}
                </div>
              </section>

              <section>
                <h2 className="text-lg font-semibold text-slate-900">Contacto</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Este correo y teléfono se usan para comunicación y notificaciones.
                </p>

                <div className="mt-4 grid gap-4 sm:grid-cols-2">
                  <Field
                    label="Correo de contacto"
                    required
                    error={
                      form.formState.touchedFields.contactEmail &&
                      watched.contactEmail.trim().length > 0 &&
                      !computed.emailOk
                        ? 'Ingresa un correo válido.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(
                        form.formState.touchedFields.contactEmail &&
                          watched.contactEmail.trim().length > 0 &&
                          !computed.emailOk
                      )}
                      placeholder="contacto@empresa.com"
                      autoComplete="email"
                      {...form.register('contactEmail')}
                    />
                  </Field>

                  <Field
                    label="Teléfono"
                    hint="Opcional. Solo 7 (fijo) o 9 (celular) dígitos."
                    error={
                      form.formState.touchedFields.contactPhone &&
                      watched.contactPhone.trim().length > 0 &&
                      !computed.phoneOk
                        ? 'Ingresa un teléfono válido de 7 o 9 dígitos.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(
                        form.formState.touchedFields.contactPhone &&
                          watched.contactPhone.trim().length > 0 &&
                          !computed.phoneOk
                      )}
                      placeholder="Ej: 987654321 o 2345678"
                      inputMode="numeric"
                      maxLength={9}
                      autoComplete="tel"
                      {...phoneReg}
                      onChange={(e) => {
                        const raw = e.target.value ?? '';
                        const next = raw.replace(/\D+/g, '').slice(0, 9);

                        phoneReg.onChange({
                          ...e,
                          target: { ...e.target, value: next },
                        } as any);

                        form.setValue('contactPhone', next, {
                          shouldDirty: true,
                          shouldTouch: true,
                          shouldValidate: true,
                        });
                      }}
                      onPaste={(e) => {
                        e.preventDefault();
                        const pasted = e.clipboardData.getData('text') ?? '';
                        const next = pasted.replace(/\D+/g, '').slice(0, 9);

                        form.setValue('contactPhone', next, {
                          shouldDirty: true,
                          shouldTouch: true,
                          shouldValidate: true,
                        });
                      }}
                    />
                  </Field>
                </div>
              </section>

              <section>
                <h2 className="text-lg font-semibold text-slate-900">Ubicación</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Selecciona el distrito donde opera tu perfil de empleador.
                </p>

                {depsLoading && (
                  <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
                    <p className="text-sm text-slate-600">Cargando catálogos de ubicación…</p>
                  </div>
                )}

                <div className="mt-4 grid gap-4 sm:grid-cols-3">
                  <Field label="Departamento" required>
                    <select
                      className={selectClass(false, false)}
                      value={departmentId}
                      onChange={(e) => {
                        const next = e.target.value;

                        if (next !== departmentId) {
                          form.setValue('departmentId', next, {
                            shouldDirty: true,
                            shouldTouch: true,
                            shouldValidate: true,
                          });

                          form.setValue('provinceId', '', {
                            shouldDirty: true,
                            shouldTouch: false,
                            shouldValidate: true,
                          });
                          form.setValue('districtId', '', {
                            shouldDirty: true,
                            shouldTouch: false,
                            shouldValidate: true,
                          });

                          form.clearErrors(['provinceId', 'districtId']);

                          if (next) {
                            form.setValue('provinceId', '', {
                              shouldTouch: true,
                              shouldValidate: true,
                            });
                          }
                        }
                      }}
                      onBlur={() => form.trigger('departmentId')}
                    >
                      <option value="">Selecciona…</option>
                      {(departmentsQuery.data ?? []).map((d) => (
                        <option key={d.id} value={d.id}>
                          {d.name}
                        </option>
                      ))}
                    </select>
                  </Field>

                  <Field
                    label="Provincia"
                    required
                    error={
                      !computed.geoAllEmpty && computed.geoErrors.province
                        ? computed.geoErrors.province
                        : (form.formState.errors.provinceId?.message as string | undefined)
                    }
                  >
                    <select
                      className={selectClass(!departmentId, false)}
                      value={provinceId}
                      disabled={!departmentId || provincesQuery.isLoading}
                      onChange={(e) => {
                        const next = e.target.value;

                        if (next !== provinceId) {
                          form.setValue('provinceId', next, {
                            shouldDirty: true,
                            shouldTouch: true,
                            shouldValidate: true,
                          });

                          form.setValue('districtId', '', {
                            shouldDirty: true,
                            shouldTouch: false,
                            shouldValidate: true,
                          });

                          form.clearErrors(['districtId']);

                          if (next) {
                            form.setValue('districtId', '', {
                              shouldTouch: true,
                              shouldValidate: true,
                            });
                          }
                        }
                      }}
                      onBlur={() => form.trigger('provinceId')}
                    >
                      <option value="">
                        {!departmentId
                          ? 'Selecciona departamento…'
                          : provincesQuery.isLoading
                            ? 'Cargando…'
                            : 'Selecciona…'}
                      </option>

                      {(provincesQuery.data ?? []).map((p) => (
                        <option key={p.id} value={p.id}>
                          {p.name}
                        </option>
                      ))}
                    </select>
                  </Field>

                  <Field
                    label="Distrito"
                    required
                    error={
                      !computed.geoAllEmpty && computed.geoErrors.district
                        ? computed.geoErrors.district
                        : (form.formState.errors.districtId?.message as string | undefined)
                    }
                  >
                    <select
                      className={selectClass(!provinceId, false)}
                      value={districtId}
                      disabled={!provinceId || districtsQuery.isLoading}
                      onChange={(e) =>
                        form.setValue('districtId', e.target.value, {
                          shouldDirty: true,
                          shouldTouch: true,
                          shouldValidate: true,
                        })
                      }
                      onBlur={() => form.trigger('districtId')}
                    >
                      <option value="">
                        {!provinceId
                          ? 'Selecciona provincia…'
                          : districtsQuery.isLoading
                            ? 'Cargando…'
                            : 'Selecciona…'}
                      </option>

                      {(districtsQuery.data ?? []).map((dd) => (
                        <option key={dd.id} value={dd.id}>
                          {dd.name}
                        </option>
                      ))}
                    </select>
                  </Field>
                </div>
              </section>

              <div className="pt-2 flex flex-col sm:flex-row gap-3 sm:items-center sm:justify-between border-t border-slate-100">
                <div className="text-sm text-slate-600">
                  {updateMutation.isPending
                    ? 'Guardando cambios…'
                    : 'Asegúrate de guardar tus cambios.'}
                </div>

                <div className="flex gap-3">
                  <button
                    type="button"
                    disabled={updateMutation.isPending}
                    onClick={() => guardedNavigate('/company')}
                    className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition disabled:opacity-60 disabled:cursor-not-allowed"
                  >
                    Descartar
                  </button>

                  <button
                    type="submit"
                    disabled={!canSubmit}
                    className={`inline-flex items-center justify-center rounded-2xl px-4 py-2.5 text-sm font-semibold transition ${
                      canSubmit
                        ? 'bg-blue-700 text-white hover:bg-blue-800'
                        : 'bg-slate-200 text-slate-500 cursor-not-allowed'
                    }`}
                  >
                    Guardar cambios
                  </button>
                </div>
              </div>

              <div className="rounded-2xl border border-slate-100 bg-white p-4">
                <p className="text-sm text-slate-600">
                  ¿Listo para publicar? Ve a{' '}
                  <a
                    className="text-blue-700 hover:text-blue-800 font-semibold"
                    href={routes.dashboard.company.jobs}
                  >
                    Mis ofertas
                  </a>{' '}
                  y crea una nueva publicación.
                </p>
              </div>
            </form>
          </div>
        )}
      </div>
    </section>
  );
}

function Field({
  label,
  required,
  hint,
  error,
  children,
}: {
  label: string;
  required?: boolean;
  hint?: string;
  error?: string;
  children: React.ReactNode;
}) {
  return (
    <label className="block">
      <div className="flex items-center gap-2">
        <span className="text-sm font-semibold text-slate-900">
          {label} {required && <span className="text-red-600">*</span>}
        </span>
      </div>

      <div className="mt-2">{children}</div>

      {hint && !error && <p className="mt-1 text-xs text-slate-500">{hint}</p>}
      {error && <p className="mt-1 text-xs text-red-600 font-medium">{error}</p>}
    </label>
  );
}

function inputClass(hasError?: boolean) {
  return [
    'w-full rounded-2xl border px-3 py-2.5 text-sm outline-none transition',
    'bg-white',
    hasError
      ? 'border-red-300 focus:border-red-400 focus:ring-4 focus:ring-red-100'
      : 'border-slate-200 focus:border-blue-400 focus:ring-4 focus:ring-blue-100',
  ].join(' ');
}

function selectClass(disabled?: boolean, hasError?: boolean) {
  return [
    'w-full rounded-2xl border px-3 py-2.5 text-sm outline-none transition',
    disabled ? 'bg-slate-50 text-slate-500' : 'bg-white',
    hasError
      ? 'border-red-300 focus:border-red-400 focus:ring-4 focus:ring-red-100'
      : 'border-slate-200 focus:border-blue-400 focus:ring-4 focus:ring-blue-100',
  ].join(' ');
}

function StatusPill({
  label,
  tone,
  help,
}: {
  label: string;
  tone: 'ok' | 'warn' | 'danger' | 'neutral';
  help: string;
}) {
  const cls =
    tone === 'ok'
      ? 'border-emerald-200 bg-emerald-50 text-emerald-800'
      : tone === 'warn'
        ? 'border-amber-200 bg-amber-50 text-amber-900'
        : tone === 'danger'
          ? 'border-red-200 bg-red-50 text-red-700'
          : 'border-slate-200 bg-white text-slate-700';

  return (
    <span
      className={`group relative inline-flex items-center rounded-full border px-3 py-1 text-xs font-semibold ${cls}`}
    >
      <span className="inline-flex items-center gap-2">
        {label}
        <Info className="w-3.5 h-3.5 opacity-70" aria-hidden="true" />
      </span>

      <span
        role="tooltip"
        className="
          pointer-events-none absolute top-full left-1/2 -translate-x-1/2 mt-2 z-50
          whitespace-nowrap
          opacity-0 translate-y-1
          group-hover:opacity-100 group-hover:translate-y-0
          transition
        "
      >
        <span className="block rounded-xl bg-slate-900 text-white px-3 py-2 text-xs font-medium shadow-lg">
          {help}
        </span>
      </span>
    </span>
  );
}
