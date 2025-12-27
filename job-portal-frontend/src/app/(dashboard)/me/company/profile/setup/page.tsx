'use client';

import { useEffect, useMemo, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import type { SubmitHandler } from 'react-hook-form';
import { useForm } from 'react-hook-form';
import { Info } from 'lucide-react';

import FlashBanner from '@/app/components/ui/FlashBanner';
import { useDismissOnDirty } from '@/app/components/ui/useDismissOnDirty';

import { computeCompanyProfileProgress } from '@/features/companies/lib/profileProgress';
import { routes } from '@/lib/routes';
import { applyApiErrorToForm } from '@/lib/apiError';
import { isValidPeruRuc, normalizeRuc } from '@/lib/ruc';
import { bffFetchOrThrow } from '@/lib/api/bffClient';

type UUID = string;

type CompanyMeResponse = {
  id: UUID;
  legalName: string | null;
  taxId: string | null;
  contactEmail: string | null;
  contactPhone: string | null;
  districtId: UUID | null;
  profileComplete: boolean;
  active: boolean;
  suspended: boolean;
};

type CompanyUpdateRequest = {
  legalName: string | null;
  taxId: string | null;
  contactEmail: string | null;
  contactPhone: string | null;
  districtId: UUID | null;
};

const COMPANY_ME_ENDPOINT = '/api/companies/me';

const DEPARTMENTS_ENDPOINT = '/api/catalogs/departments';
const PROVINCES_ENDPOINT = '/api/catalogs/provinces';
const DISTRICTS_ENDPOINT = '/api/catalogs/districts';
const DISTRICT_RESOLVE_ENDPOINT = (id: string) => `/api/catalogs/districts/${id}`;

type GeoItem = { id: UUID; name: string };
type DistrictResolveResponse = { id: UUID; name: string; provinceId: UUID; departmentId: UUID };

type FormValues = {
  legalName: string;
  taxId: string;
  contactEmail: string;
  contactPhone: string;

  departmentId: string;
  provinceId: string;
  districtId: string;
};

export default function CompanyProfileSetupPage() {
  const router = useRouter();
  const qc = useQueryClient();

  const [serverError, setServerError] = useState<string | null>(null);
  const [serverOk, setServerOk] = useState<string | null>(null);

  const [okVisible, setOkVisible] = useState(false);
  const okAnimateMs = 900;

  const meQuery = useQuery({
    queryKey: ['company', 'me'],
    queryFn: () => bffFetchOrThrow<CompanyMeResponse>(COMPANY_ME_ENDPOINT, { method: 'GET' }),
    staleTime: 30_000,
  });

  const me = meQuery.data;

  const form = useForm<FormValues>({
    mode: 'onChange',
    defaultValues: {
      legalName: '',
      taxId: '',
      contactEmail: '',
      contactPhone: '',
      departmentId: '',
      provinceId: '',
      districtId: '',
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
    queryKey: ['catalogs', 'geo', 'district-resolve', me?.districtId ?? null],
    queryFn: () =>
      bffFetchOrThrow<DistrictResolveResponse>(DISTRICT_RESOLVE_ENDPOINT(me!.districtId!), {
        method: 'GET',
      }),
    enabled: !!me?.districtId,
    staleTime: 5 * 60 * 1000,
  });

  useEffect(() => {
    if (!me) return;

    const r = resolveQuery.data;

    form.reset(
      {
        legalName: me.legalName ?? '',
        taxId: me.taxId ?? '',
        contactEmail: me.contactEmail ?? '',
        contactPhone: me.contactPhone ?? '',
        departmentId: r?.departmentId ?? '',
        provinceId: r?.provinceId ?? '',
        districtId: me.districtId ?? '',
      },
      { keepTouched: false, keepDirty: false }
    );
  }, [me, resolveQuery.data, form]);

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
    mutationFn: async (payload: CompanyUpdateRequest) =>
      bffFetchOrThrow<CompanyMeResponse>(COMPANY_ME_ENDPOINT, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      }),
    onMutate: () => {
      setServerError(null);
      setServerOk(null);
      setOkVisible(false);
    },
    onSuccess: async () => {
      form.reset(form.getValues(), {
        keepTouched: true,
        keepDirty: false,
      });

      setServerOk('Perfil actualizado correctamente.');
      setOkVisible(true);

      await qc.invalidateQueries({ queryKey: ['company', 'me'] });
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
    const legalName = watched.legalName.trim();
    const taxId = watched.taxId.trim();
    const email = watched.contactEmail.trim();
    const phone = watched.contactPhone.trim();

    const department = watched.departmentId.trim();
    const province = watched.provinceId.trim();
    const district = watched.districtId.trim();

    const legalNameOkUx = legalName.length === 0 || legalName.length >= 2;
    const taxIdOkUx = taxId.length === 0 || isValidPeruRuc(taxId);
    const emailOkUx = email.length === 0 || /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    const phoneOkUx = phone.length === 0 || /^[0-9+()\s-]{6,20}$/.test(phone);

    const geoAllEmpty = department.length === 0 && province.length === 0 && district.length === 0;
    const geoAllComplete = department.length > 0 && province.length > 0 && district.length > 0;
    const geoStateOk = geoAllEmpty || geoAllComplete;

    const progressState = computeCompanyProfileProgress({
      legalName: watched.legalName,
      taxId: watched.taxId,
      contactEmail: watched.contactEmail,
      districtId: watched.districtId,
    });

    return {
      legalNameOk: legalNameOkUx,
      taxIdOk: taxIdOkUx,
      emailOk: emailOkUx,
      phoneOk: phoneOkUx,
      geoAllEmpty,
      geoAllComplete,
      geoStateOk,

      missing: progressState.missing,
      progress: progressState.progress,
      recommendedComplete: progressState.profileComplete,
    };
  }, [watched]);

  const canSubmit =
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

    if (!geoAllEmpty && !geoAllComplete) {
      setServerError('Completa la ubicación (departamento, provincia y distrito) o déjala vacía.');
      return;
    }

    const payload: CompanyUpdateRequest = {
      legalName: values.legalName.trim() ? values.legalName.trim() : null,
      taxId: values.taxId.trim() ? normalizeRuc(values.taxId).slice(0, 11) : null,
      contactEmail: values.contactEmail.trim() ? values.contactEmail.trim() : null,
      contactPhone: values.contactPhone.trim() ? values.contactPhone.trim() : null,
      districtId: geoAllComplete ? values.districtId : null,
    };

    await updateMutation.mutateAsync(payload);
  };

  const isLoading = meQuery.isLoading;
  const loadError = meQuery.error as any;

  const depsLoading =
    departmentsQuery.isLoading || (resolveQuery.isLoading && !!me?.districtId) || false;

  const geoError = (departmentsQuery.error as any) || (resolveQuery.error as any) || null;

  return (
    <section className="flex-1 min-h-0 bg-slate-50 px-4 py-8">
      <div className="max-w-4xl mx-auto">
        <header className="mb-6">
          <div className="mb-3">
            <button
              type="button"
              onClick={() => router.push('/company')}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              ← Volver al panel
            </button>
          </div>

          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
            Configura el perfil de tu empresa
          </h1>
          <p className="mt-2 text-sm sm:text-base text-slate-600">
            Completa los datos de tu empresa para publicar ofertas y gestionar postulaciones.
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
                  <p className="text-sm font-semibold text-slate-900">Progreso del perfil</p>
                  <p className="text-sm text-slate-600">
                    Completa lo esencial para publicar sin inconvenientes.
                  </p>
                </div>

                <div className="flex items-center gap-2">
                  <StatusPill
                    label={me?.profileComplete ? 'Perfil completo' : 'Perfil incompleto'}
                    tone={me?.profileComplete ? 'ok' : 'warn'}
                    help={
                      me?.profileComplete
                        ? 'Tu perfil cumple los requisitos mínimos para postular.'
                        : 'Completa los datos requeridos para habilitar tus postulaciones.'
                    }
                  />

                  <StatusPill
                    label={me?.active ? 'Activa' : 'Inactiva'}
                    tone={me?.active ? 'ok' : 'neutral'}
                    help={
                      me?.active
                        ? 'Tu empresa está habilitada para usar el portal y publicar ofertas.'
                        : 'Tu empresa está deshabilitada; contacta soporte si no reconoces este estado.'
                    }
                  />

                  <StatusPill
                    label={me?.suspended ? 'Suspendida' : 'Sin suspensión'}
                    tone={me?.suspended ? 'danger' : 'ok'}
                    help={
                      me?.suspended
                        ? 'Tu empresa tiene un bloqueo por moderación o revisión.'
                        : 'Tu empresa no tiene bloqueos por moderación.'
                    }
                  />
                </div>
              </div>

              <div className="mt-3">
                <div className="flex items-center justify-between text-xs text-slate-600">
                  <span>{computed.progress}%</span>
                  <span>Recomendado para publicar</span>
                </div>
                <div className="mt-2 h-2 rounded-full bg-slate-200 overflow-hidden">
                  <div
                    className="h-full rounded-full bg-blue-700"
                    style={{ width: `${computed.progress}%` }}
                  />
                </div>

                {computed.missing.length > 0 && (
                  <p className="mt-3 text-sm text-slate-600">
                    Te falta completar datos clave para publicar:{' '}
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

            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
              {/* Datos legales */}
              <section>
                <h2 className="text-lg font-semibold text-slate-900">Datos legales</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Estos datos ayudan a validar la autenticidad de la empresa.
                </p>

                <div className="mt-4 grid gap-4 sm:grid-cols-2">
                  <Field
                    label="Razón social / Nombre legal"
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
                      placeholder="Ej: ACME SAC"
                      {...form.register('legalName')}
                    />
                  </Field>

                  <Field
                    label="RUC"
                    required
                    hint="11 dígitos. Solo números."
                    error={
                      form.formState.touchedFields.taxId &&
                      watched.taxId.trim().length > 0 &&
                      !computed.taxIdOk
                        ? 'RUC inválido. Verifica que tenga 11 dígitos y sea válido.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(
                        form.formState.touchedFields.taxId &&
                          watched.taxId.trim().length > 0 &&
                          !computed.taxIdOk
                      )}
                      placeholder="Ej: 20123456789"
                      inputMode="numeric"
                      maxLength={11}
                      {...form.register('taxId', {
                        setValueAs: (v) => normalizeRuc(String(v ?? '')).slice(0, 11),
                      })}
                    />
                  </Field>
                </div>
              </section>

              {/* Contacto */}
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
                    hint="Opcional. Ej: +51 999 999 999"
                    error={
                      form.formState.touchedFields.contactPhone &&
                      watched.contactPhone.trim().length > 0 &&
                      !computed.phoneOk
                        ? 'Teléfono inválido.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(
                        form.formState.touchedFields.contactPhone &&
                          watched.contactPhone.trim().length > 0 &&
                          !computed.phoneOk
                      )}
                      placeholder="+51 999 999 999"
                      autoComplete="tel"
                      {...form.register('contactPhone')}
                    />
                  </Field>
                </div>
              </section>

              {/* Ubicación */}
              <section>
                <h2 className="text-lg font-semibold text-slate-900">Ubicación</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Selecciona el distrito donde opera tu empresa. Esto se utiliza para tus
                  publicaciones y visibilidad.
                </p>

                {depsLoading && (
                  <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
                    <p className="text-sm text-slate-600">Cargando catálogos de ubicación…</p>
                  </div>
                )}

                <div className="mt-4 grid gap-4 sm:grid-cols-3">
                  <Field
                    label="Departamento"
                    required
                    error={
                      form.formState.touchedFields.departmentId &&
                      !computed.geoAllEmpty &&
                      !computed.geoAllComplete
                        ? 'Completa la ubicación o déjala vacía.'
                        : undefined
                    }
                  >
                    <select
                      className={selectClass(false, false)}
                      value={departmentId}
                      onChange={(e) => {
                        const next = e.target.value;

                        if (next !== departmentId) {
                          form.setValue('departmentId', next, {
                            shouldDirty: true,
                            shouldTouch: true,
                          });

                          form.setValue('provinceId', '', {
                            shouldDirty: true,
                            shouldTouch: false,
                          });
                          form.setValue('districtId', '', {
                            shouldDirty: true,
                            shouldTouch: false,
                          });

                          form.clearErrors(['provinceId', 'districtId']);
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
                      form.formState.touchedFields.provinceId &&
                      !computed.geoAllEmpty &&
                      !computed.geoAllComplete
                        ? 'Completa la ubicación o déjala vacía.'
                        : undefined
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
                          });

                          form.setValue('districtId', '', {
                            shouldDirty: true,
                            shouldTouch: false,
                          });
                          form.clearErrors(['districtId']);
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
                      form.formState.touchedFields.districtId &&
                      !computed.geoAllEmpty &&
                      !computed.geoAllComplete
                        ? 'Completa la ubicación o déjala vacía.'
                        : undefined
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

              {/* Acciones */}
              <div className="pt-2 flex flex-col sm:flex-row gap-3 sm:items-center sm:justify-between border-t border-slate-100">
                <div className="text-sm text-slate-600">
                  {updateMutation.isPending
                    ? 'Guardando cambios…'
                    : 'Asegúrate de guardar tus cambios.'}
                </div>

                <div className="flex gap-3">
                  <button
                    type="button"
                    onClick={() => form.reset()}
                    className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
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
