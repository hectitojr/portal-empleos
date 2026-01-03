'use client';

import { useMemo, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { useForm, type SubmitHandler } from 'react-hook-form';
import type { Route } from 'next';

import FlashBanner from '@/app/components/ui/FlashBanner';
import { useDismissOnDirty } from '@/app/components/ui/useDismissOnDirty';

import ConfirmDialog from '@/app/components/ui/ConfirmDialog';
import { useUnsavedChangesGuard } from '@/app/components/navigation/useUnsavedChangesGuard';
import { useNavigationGuard } from '@/app/components/navigation/NavigationGuardProvider';

import { routes } from '@/lib/routes';
import { createCompanyJob } from '@/features/jobs/api/jobsClient';

import { CompanyPublishGate } from '@/features/companies/components/CompanyPublishGate';
import type { ApiErrorCode } from '@/lib/errors';

import { bffFetchOrThrow } from '@/lib/api/bffClient';

type UUID = string;

type GeoItem = { id: UUID; name: string };
type CatalogItem = { id: UUID; name: string };

const DEPARTMENTS_ENDPOINT = '/api/catalogs/departments';
const PROVINCES_ENDPOINT = '/api/catalogs/provinces';
const DISTRICTS_ENDPOINT = '/api/catalogs/districts';
const EMPLOYMENT_TYPES_ENDPOINT = '/api/catalogs/employment-types';
const WORK_MODES_ENDPOINT = '/api/catalogs/work-modes';

type FormValues = {
  title: string;
  description: string;
  disabilityFriendly: boolean;

  salaryMin: string;
  salaryMax: string;

  departmentId: string;
  provinceId: string;
  districtId: string;

  employmentTypeId: string;
  workModeId: string;
};

export default function CompanyJobNewPage() {
  const router = useRouter();

  const [serverError, setServerError] = useState<string | null>(null);
  const [serverOk, setServerOk] = useState<string | null>(null);

  const [isSaving, setIsSaving] = useState(false);

  const [okVisible, setOkVisible] = useState(false);
  const [errorVisible, setErrorVisible] = useState(false);

  const [showCompleteProfileCta, setShowCompleteProfileCta] = useState(false);

  const submitLockRef = useRef(false);

  const okAnimateMs = 900;
  const errorAnimateMs = 900;

  const OK_AUTO_DISMISS_MS = 5000;
  const ERROR_AUTO_DISMISS_MS = 6000;

  const redirectOnOkClearRef = useRef(false);

  const SALARY_MAX = 1_000_000;

  function normalizeSalaryInput(raw: string): string {
    let out = (raw ?? '').replace(/[^\d.]/g, '');

    const firstDot = out.indexOf('.');
    if (firstDot !== -1) {
      out = out.slice(0, firstDot + 1) + out.slice(firstDot + 1).replace(/\./g, '');
    }

    if (!out.startsWith('0.')) out = out.replace(/^0+(\d)/, '$1');

    return out;
  }

  function toFiniteNumberOrNull(v: string): number | null {
    const s = (v ?? '').trim();
    if (!s) return null;
    if (!/^\d+(\.\d{1,2})?$/.test(s)) return null;
    const n = Number(s);
    return Number.isFinite(n) ? n : null;
  }

  const form = useForm<FormValues>({
    mode: 'onChange',
    criteriaMode: 'firstError',
    shouldFocusError: true,
    defaultValues: {
      title: '',
      description: '',
      disabilityFriendly: false,

      salaryMin: '',
      salaryMax: '',

      departmentId: '',
      provinceId: '',
      districtId: '',

      employmentTypeId: '',
      workModeId: '',
    },
  });

  form.register('departmentId', { required: 'Selecciona un departamento.' });

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

  const employmentTypesQuery = useQuery<CatalogItem[]>({
    queryKey: ['catalogs', 'employment-types'],
    queryFn: () => bffFetchOrThrow<CatalogItem[]>(EMPLOYMENT_TYPES_ENDPOINT, { method: 'GET' }),
    staleTime: 24 * 60 * 60 * 1000,
  });

  const workModesQuery = useQuery<CatalogItem[]>({
    queryKey: ['catalogs', 'work-modes'],
    queryFn: () => bffFetchOrThrow<CatalogItem[]>(WORK_MODES_ENDPOINT, { method: 'GET' }),
    staleTime: 24 * 60 * 60 * 1000,
  });

  const catalogsLoading =
    departmentsQuery.isLoading || employmentTypesQuery.isLoading || workModesQuery.isLoading;

  const catalogsError =
    (departmentsQuery.error as any) ||
    (employmentTypesQuery.error as any) ||
    (workModesQuery.error as any) ||
    null;

  const computed = useMemo(() => {
    const titleOk = watched.title.trim().length >= 4;
    const descOk = watched.description.trim().length >= 20;

    const department = watched.departmentId.trim();
    const province = watched.provinceId.trim();
    const district = watched.districtId.trim();

    const geoAllComplete = department.length > 0 && province.length > 0 && district.length > 0;

    const geoErrors = {
      province: department && !province ? 'Selecciona una provincia.' : undefined,
      district: department && province && !district ? 'Selecciona un distrito.' : undefined,
    };

    return {
      titleOk,
      descOk,
      geoAllComplete,
      geoErrors,
    };
  }, [watched]);

  const canSubmit =
    computed.titleOk && computed.descOk && computed.geoAllComplete && !isSaving && !catalogsLoading;

  useDismissOnDirty({
    isDirty: form.formState.isDirty,
    active: !!serverOk && okVisible,
    animateMs: okAnimateMs,
    onHide: () => setOkVisible(false),
    onClear: () => setServerOk(null),
  });

  useDismissOnDirty({
    isDirty: form.formState.isDirty,
    active: !!serverError && errorVisible,
    animateMs: errorAnimateMs,
    onHide: () => setErrorVisible(false),
    onClear: () => setServerError(null),
  });

  const showError = (msg: string) => {
    setShowCompleteProfileCta(false);
    redirectOnOkClearRef.current = false;

    setServerOk(null);
    setOkVisible(false);

    setServerError(msg);
    setErrorVisible(true);
  };

  const showOk = (msg: string) => {
    setShowCompleteProfileCta(false);

    setServerError(null);
    setErrorVisible(false);

    setServerOk(msg);
    setOkVisible(true);
  };

  const onInvalid = () => {
    showError('Revisa los campos marcados antes de publicar.');
  };

  const initialRef = useRef<FormValues>(form.getValues());

  const hasUnsavedChanges = form.formState.isDirty && !isSaving;

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

  useUnsavedChangesGuard({
    enabled: hasUnsavedChanges,
    message: 'Tienes cambios sin guardar.',
    onOpenConfirm: () => openConfirm(),
    onConfirmLeave: () => {
      form.reset(initialRef.current, { keepTouched: false, keepDirty: false });
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

    guard.setGuard({
      enabled: true,
      message: 'Tienes cambios sin guardar.',
      onOpenConfirm: openConfirm,
      onConfirmLeave: () => {
        form.reset(initialRef.current, { keepTouched: false, keepDirty: false });
      },
      onCancelLeave: () => {
        setConfirmOpen(false);
      },
    });

    guard.setPendingNavigate(() => router.push(path));
    guard.pingOpenConfirm();
  }

  const onSubmit: SubmitHandler<FormValues> = async (values) => {
    if (submitLockRef.current) return;
    submitLockRef.current = true;

    redirectOnOkClearRef.current = false;

    setServerError(null);
    setServerOk(null);
    setOkVisible(false);
    setErrorVisible(false);
    setIsSaving(true);

    try {
      if (catalogsLoading) {
        showError('Espera a que se carguen los catálogos antes de publicar.');
        return;
      }

      if (!computed.titleOk || !computed.descOk) {
        showError('Completa el título y la descripción antes de publicar.');
        return;
      }

      const geoOk = await form.trigger(['provinceId', 'districtId', 'departmentId']);
      if (!geoOk || !computed.geoAllComplete) {
        if (!values.departmentId.trim()) {
          form.setError('departmentId', { type: 'required', message: 'Selecciona un departamento.' });
        }
        showError('Revisa los campos marcados antes de publicar.');
        return;
      }

      const min = toFiniteNumberOrNull(values.salaryMin);
      const max = toFiniteNumberOrNull(values.salaryMax);

      if (values.salaryMin && min === null) {
        form.setError('salaryMin', { type: 'validate', message: 'Solo números, con hasta 2 decimales.' });
        showError('Revisa los campos marcados antes de publicar.');
        return;
      }
      if (values.salaryMax && max === null) {
        form.setError('salaryMax', { type: 'validate', message: 'Solo números, con hasta 2 decimales.' });
        showError('Revisa los campos marcados antes de publicar.');
        return;
      }
      if (max != null && min == null) {
        form.setError('salaryMin', { type: 'validate', message: 'Ingresa el salario mínimo.' });
        showError('Revisa los campos marcados antes de publicar.');
        return;
      }
      if (min != null && min > SALARY_MAX) {
        form.setError('salaryMin', { type: 'validate', message: 'El salario mínimo es demasiado alto.' });
        showError('Revisa los campos marcados antes de publicar.');
        return;
      }
      if (max != null && max > SALARY_MAX) {
        form.setError('salaryMax', { type: 'validate', message: 'El salario máximo es demasiado alto.' });
        showError('Revisa los campos marcados antes de publicar.');
        return;
      }
      if (min != null && max != null && max < min) {
        form.setError('salaryMax', { type: 'validate', message: 'El máximo no puede ser menor que el mínimo.' });
        showError('Revisa los campos marcados antes de publicar.');
        return;
      }

      const res = await createCompanyJob({
        title: values.title.trim(),
        description: values.description.trim(),
        districtId: values.districtId,
        disabilityFriendly: !!values.disabilityFriendly,
        employmentTypeId: values.employmentTypeId ? values.employmentTypeId : null,
        workModeId: values.workModeId ? values.workModeId : null,
        salaryMin: min,
        salaryMax: max,
        areaId: null,
        sectorId: null,
      });

      if (!res.ok) {
        const code = res.error?.error as ApiErrorCode | string | undefined;

        if (code === 'COMPANY_INCOMPLETE') {
          setShowCompleteProfileCta(true);
          showError('Completa los requisitos de tu cuenta de empresa antes de publicar ofertas.');
          return;
        }

        const msg =
          (typeof res.error?.message === 'string' && res.error.message) ||
          'No se pudo publicar la oferta. Intenta nuevamente.';

        showError(msg);
        return;
      }

      const current = form.getValues();
      form.reset(current, { keepErrors: false, keepTouched: false, keepDirty: false });
      initialRef.current = current;

      redirectOnOkClearRef.current = true;
      showOk('Oferta publicada correctamente.');
    } finally {
      setIsSaving(false);
      submitLockRef.current = false;
    }
  };

  return (
    <section className="bg-slate-50 px-4 py-8">
      <div className="max-w-4xl mx-auto">
        <header className="mb-6">
          <div className="mb-3">
            <button
              type="button"
              onClick={() => guardedNavigate(routes.dashboard.company.home as Route)}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              ← Volver al panel
            </button>
          </div>

          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">Publicar nueva oferta</h1>
          <p className="mt-2 text-sm sm:text-base text-slate-600">
            Completa la información clave para publicar tu vacante.
          </p>
        </header>
        {catalogsError && (
          <div className="mb-4 rounded-2xl border border-amber-200 bg-amber-50 p-4">
            <p className="text-sm text-amber-900 font-semibold">No se pudieron cargar los catálogos.</p>
            <p className="mt-1 text-sm text-slate-700">
              Puedes reintentar. Si persiste, revisa tu sesión o el BFF.
            </p>

            <div className="mt-3 flex gap-3">
              <button
                type="button"
                onClick={() => {
                  departmentsQuery.refetch();
                  employmentTypesQuery.refetch();
                  workModesQuery.refetch();
                }}
                className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
              >
                Reintentar catálogos
              </button>
            </div>
          </div>
        )}

        <FlashBanner
          message={errorVisible ? serverError : null}
          tone="error"
          autoDismissMs={ERROR_AUTO_DISMISS_MS}
          animateMs={errorAnimateMs}
          onClear={() => {
            setServerError(null);
            setErrorVisible(false);
          }}
        />

        <FlashBanner
          message={okVisible ? serverOk : null}
          tone="success"
          autoDismissMs={OK_AUTO_DISMISS_MS}
          animateMs={okAnimateMs}
          onClear={() => {
            setServerOk(null);
            setOkVisible(false);

            if (redirectOnOkClearRef.current) {
              redirectOnOkClearRef.current = false;
              router.push(routes.dashboard.company.home);
              router.refresh();
            }
          }}
        />

        <ConfirmDialog
          open={confirmOpen}
          title="Tienes cambios sin guardar"
          description="Si sales ahora, perderás los cambios realizados en este formulario."
          confirmText="Descartar cambios"
          cancelText="Seguir editando"
          destructive
          busy={isSaving}
          onCancel={closeConfirm}
          onConfirm={confirmLeave}
        />

        {showCompleteProfileCta && (
          <div className="mb-4 rounded-2xl border border-amber-200 bg-amber-50 p-4">
            <p className="text-sm text-amber-900 font-semibold">Acción requerida</p>
            <p className="mt-1 text-sm text-slate-700">
              Completa tu identidad y/o perfil de empresa para habilitar la publicación.
            </p>

            <div className="mt-3 flex flex-col sm:flex-row gap-3">
              <button
                type="button"
                onClick={() => guardedNavigate(routes.dashboard.company.profileSetup as Route)}
                className="inline-flex items-center justify-center rounded-2xl bg-blue-700 px-4 py-2.5 text-white text-sm font-semibold hover:bg-blue-800 transition"
              >
                Ir a completar requisitos
              </button>

              <button
                type="button"
                onClick={() => guardedNavigate(routes.dashboard.company.home as Route)}
                className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
              >
                Volver al panel
              </button>
            </div>
          </div>
        )}

        <CompanyPublishGate>
          <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6 sm:p-8">
            {catalogsLoading && (
              <div className="mb-5 rounded-2xl border border-slate-100 bg-slate-50 p-4">
                <p className="text-sm text-slate-600">Cargando catálogos…</p>
              </div>
            )}

            <form onSubmit={form.handleSubmit(onSubmit, onInvalid)} className="space-y-8">
              <section>
                <h2 className="text-lg font-semibold text-slate-900">Información de la oferta</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Un título claro y una descripción detallada mejoran la calidad de las postulaciones.
                </p>

                <div className="mt-4 grid gap-4">
                  <Field
                    label="Título"
                    required
                    hint="Ejemplo: Backend Java (Spring Boot) Senior — Remoto"
                    error={
                      form.formState.touchedFields.title && !computed.titleOk
                        ? 'Ingresa un título con al menos 4 caracteres.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(form.formState.touchedFields.title && !computed.titleOk)}
                      placeholder="Ej: Backend Java (Spring Boot) Senior — Remoto"
                      {...form.register('title')}
                    />
                  </Field>

                  <Field
                    label="Descripción"
                    required
                    hint="Incluye responsabilidades, requisitos, beneficios y rango salarial si aplica (mínimo 20 caracteres)."
                    error={
                      form.formState.touchedFields.description && !computed.descOk
                        ? 'Describe mejor la vacante (mínimo 20 caracteres).'
                        : undefined
                    }
                  >
                    <textarea
                      rows={7}
                      className={inputClass(form.formState.touchedFields.description && !computed.descOk)}
                      placeholder="Responsabilidades, requisitos, beneficios, detalles del proceso, etc."
                      {...form.register('description')}
                    />
                  </Field>

                  <div className="flex items-center gap-3">
                    <input
                      id="disabilityFriendly"
                      type="checkbox"
                      className="h-4 w-4"
                      {...form.register('disabilityFriendly')}
                    />
                    <label htmlFor="disabilityFriendly" className="text-sm text-slate-700">
                      Oferta inclusiva para personas con discapacidad
                    </label>
                  </div>

                  <section className="rounded-2xl border border-slate-100 bg-slate-50 p-4 sm:p-5">
                    <div className="flex items-start justify-between gap-4">
                      <div>
                        <h3 className="text-sm font-semibold text-slate-900">Salario</h3>
                        <p className="mt-1 text-xs text-slate-600">
                          Opcional. Puedes indicar un monto (mínimo) o un rango (mínimo y máximo). Solo números.
                        </p>
                      </div>
                    </div>

                    <div className="mt-4 grid gap-4 sm:grid-cols-2">
                      <Field
                        label="Mínimo (S/)"
                        hint="Opcional. Si ingresas un máximo, el mínimo es obligatorio."
                        error={form.formState.errors.salaryMin?.message as string | undefined}
                      >
                        <input
                          className={inputClass(!!form.formState.errors.salaryMin)}
                          inputMode="decimal"
                          placeholder="Ej: 4500 o 4500.50"
                          maxLength={12}
                          {...form.register('salaryMin', {
                            setValueAs: (v) => normalizeSalaryInput(String(v ?? '')),
                            validate: (v) => {
                              const raw = String(v ?? '').trim();
                              if (!raw) return true;

                              const n = toFiniteNumberOrNull(raw);
                              if (n == null) return 'Solo números, con hasta 2 decimales.';
                              if (n < 0) return 'No puede ser negativo.';
                              if (n > SALARY_MAX) return 'El salario mínimo es demasiado alto.';
                              return true;
                            },
                            onChange: async (e) => {
                              const next = normalizeSalaryInput(e.target.value);

                              form.setValue('salaryMin', next, {
                                shouldDirty: true,
                                shouldTouch: true,
                                shouldValidate: true,
                              });

                              await form.trigger('salaryMax');

                              const min = toFiniteNumberOrNull(next);
                              const maxRaw = form.getValues('salaryMax');
                              const max = toFiniteNumberOrNull(maxRaw);

                              if (min != null && max != null && max >= min) {
                                form.clearErrors('salaryMax');
                              }
                            },
                          })}
                          onBlur={() => form.trigger(['salaryMin', 'salaryMax'])}
                        />
                      </Field>

                      <Field
                        label="Máximo (S/)"
                        hint="Opcional."
                        error={form.formState.errors.salaryMax?.message as string | undefined}
                      >
                        <input
                          className={inputClass(!!form.formState.errors.salaryMax)}
                          inputMode="decimal"
                          placeholder="Ej: 6500 o 6500.50"
                          maxLength={12}
                          {...form.register('salaryMax', {
                            setValueAs: (v) => normalizeSalaryInput(String(v ?? '')),
                            validate: (v) => {
                              const raw = String(v ?? '').trim();
                              if (!raw) return true;

                              const max = toFiniteNumberOrNull(raw);
                              if (max == null) return 'Solo números, con hasta 2 decimales.';
                              if (max < 0) return 'No puede ser negativo.';
                              if (max > SALARY_MAX) return 'El salario máximo es demasiado alto.';

                              const minRaw = form.getValues('salaryMin');
                              const min = toFiniteNumberOrNull(minRaw);

                              if (min == null) return 'Ingresa el salario mínimo.';
                              if (max < min) return 'El máximo no puede ser menor que el mínimo.';

                              return true;
                            },
                            onChange: (e) => {
                              const next = normalizeSalaryInput(e.target.value);

                              form.setValue('salaryMax', next, {
                                shouldDirty: true,
                                shouldTouch: true,
                                shouldValidate: true,
                              });

                              const minRaw = form.getValues('salaryMin');
                              const min = toFiniteNumberOrNull(minRaw);
                              const max = toFiniteNumberOrNull(next);
                              if (min != null && max != null && max >= min) {
                                form.clearErrors('salaryMax');
                              }
                            },
                          })}
                          onBlur={() => form.trigger(['salaryMin', 'salaryMax'])}
                        />
                      </Field>
                    </div>
                  </section>
                </div>
              </section>

              <section>
                <h2 className="text-lg font-semibold text-slate-900">Ubicación</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Indicar la ubicación mejora la visibilidad de tu oferta y facilita que los postulantes encuentren tu vacante.
                </p>

                <div className="mt-4 grid gap-4 sm:grid-cols-3">
                  <Field
                    label="Departamento"
                    required
                    error={form.formState.errors.departmentId?.message as string | undefined}
                  >
                    <select
                      className={selectClass(false, !!form.formState.errors.departmentId)}
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
                      computed.geoErrors.province
                        ? computed.geoErrors.province
                        : (form.formState.errors.provinceId?.message as string | undefined)
                    }
                  >
                    <select
                      className={selectClass(!departmentId, !!form.formState.errors.provinceId)}
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
                      computed.geoErrors.district
                        ? computed.geoErrors.district
                        : (form.formState.errors.districtId?.message as string | undefined)
                    }
                  >
                    <select
                      className={selectClass(!provinceId, !!form.formState.errors.districtId)}
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

              <section>
                <h2 className="text-lg font-semibold text-slate-900">Tipo de empleo</h2>
                <p className="mt-1 text-sm text-slate-600">Opcional. Mejora la calidad de los filtros para postulantes.</p>

                <div className="mt-4 grid gap-4 sm:grid-cols-2">
                  <Field label="Tipo de empleo" hint="Ej: Tiempo completo, Part-time, Freelance.">
                    <select className={selectClass(false)} {...form.register('employmentTypeId')}>
                      <option value="">Selecciona…</option>
                      {(employmentTypesQuery.data ?? []).map((it) => (
                        <option key={it.id} value={it.id}>
                          {it.name}
                        </option>
                      ))}
                    </select>
                  </Field>

                  <Field label="Modalidad" hint="Ej: Remoto, Híbrido, Presencial.">
                    <select className={selectClass(false)} {...form.register('workModeId')}>
                      <option value="">Selecciona…</option>
                      {(workModesQuery.data ?? []).map((it) => (
                        <option key={it.id} value={it.id}>
                          {it.name}
                        </option>
                      ))}
                    </select>
                  </Field>
                </div>
              </section>

              <div className="pt-2 flex flex-col sm:flex-row gap-3 sm:items-center sm:justify-between border-t border-slate-100">
                <div className="text-sm text-slate-600">
                  {isSaving ? 'Publicando…' : catalogsLoading ? 'Cargando catálogos…' : 'Revisa antes de publicar.'}
                </div>

                <div className="flex gap-3">
                  <button
                    type="button"
                    disabled={isSaving}
                    onClick={() => guardedNavigate(routes.dashboard.company.home as Route)}
                    className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition disabled:opacity-60 disabled:cursor-not-allowed"
                  >
                    Cancelar
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
                    Publicar oferta
                  </button>
                </div>
              </div>
            </form>
          </div>
        </CompanyPublishGate>
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
