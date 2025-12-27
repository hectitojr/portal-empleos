'use client';

import { useEffect, useMemo, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useForm, useFieldArray, type SubmitHandler } from 'react-hook-form';
import { Info, Plus, Trash2 } from 'lucide-react';

import FlashBanner from '@/app/components/ui/FlashBanner';
import { useDismissOnDirty } from '@/app/components/ui/useDismissOnDirty';

import { routes } from '@/lib/routes';
import { applyApiErrorToForm, tryParseApiError } from '@/lib/apiError';

import {
  type ApplicantMeResponse,
  type ApplicantUpsertRequest,
} from '@/features/applicants/api/applicantsClient';
import { computeApplicantProfileProgress } from '@/features/applicants/lib/profileProgress';

import { useJobCatalogs } from '@/features/catalogs/hooks/useCatalogs';

type UUID = string;

const APPLICANT_ME_ENDPOINT = '/api/applicants/me';

const DEPARTMENTS_ENDPOINT = '/api/catalogs/departments';
const PROVINCES_ENDPOINT = '/api/catalogs/provinces';
const DISTRICTS_ENDPOINT = '/api/catalogs/districts';
const DISTRICT_RESOLVE_ENDPOINT = (id: string) => `/api/catalogs/districts/${id}`;

type GeoItem = { id: UUID; name: string };
type DistrictResolveResponse = { id: UUID; name: string; provinceId: UUID; departmentId: UUID };

async function apiJson<T>(path: string): Promise<T> {
  const res = await fetch(path, { method: 'GET' });
  if (!res.ok) {
    const text = await res.text().catch(() => '');
    const err: any = new Error('Error consultando catálogos.');
    err.status = res.status;
    err.body = text;
    throw err;
  }
  return res.json();
}

async function apiGetMe(): Promise<ApplicantMeResponse> {
  const res = await fetch(APPLICANT_ME_ENDPOINT, { method: 'GET' });
  if (!res.ok) {
    const text = await res.text().catch(() => '');
    const err: any = new Error('No se pudo cargar tu perfil de postulante.');
    err.status = res.status;
    err.body = text;
    throw err;
  }
  return res.json();
}

async function apiUpsertMe(payload: ApplicantUpsertRequest): Promise<ApplicantMeResponse> {
  const res = await fetch(APPLICANT_ME_ENDPOINT, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
  });

  if (!res.ok) {
    const text = await res.text().catch(() => '');
    const err: any = new Error('No se pudo guardar tu perfil.');
    err.status = res.status;
    err.body = text;
    throw err;
  }
  return res.json();
}

type FormExperience = {
  company: string;
  role: string;
  startDate: string;
  endDate: string;
  description: string;
};

type FormEducation = {
  institution: string;
  degree: string;
  startDate: string;
  endDate: string;
  description: string;
};

type FormSkill = {
  name: string;
  level: string;
};

type FormValues = {
  fullName: string;
  contactEmail: string;
  contactPhone: string;
  profileSummary: string;

  departmentId: string;
  provinceId: string;
  districtId: string;

  disabilityIds: string[];

  experiences: FormExperience[];
  educations: FormEducation[];
  skills: FormSkill[];
};

function toIsoDateOrEmpty(v: any) {
  if (!v) return '';
  return String(v);
}

function normalizeArrayFieldPath(field: string) {
  return field.replace(/\[(\d+)\]/g, '.$1');
}

function uniqueStrings(xs: string[]) {
  return Array.from(new Set(xs));
}

function lcTrim(s: string) {
  return (s ?? '').trim().toLowerCase();
}

function findDuplicateSkillIndices(skills: Array<{ name: string }>) {
  const firstIndexByKey = new Map<string, number>();
  const dupIndices: number[] = [];

  for (let i = 0; i < (skills ?? []).length; i++) {
    const key = lcTrim(skills[i]?.name ?? '');
    if (!key) continue;

    if (firstIndexByKey.has(key)) {
      dupIndices.push(i);
    } else {
      firstIndexByKey.set(key, i);
    }
  }

  return dupIndices;
}

export default function ApplicantProfileSetupPage() {
  const router = useRouter();
  const qc = useQueryClient();

  const [serverError, setServerError] = useState<string | null>(null);
  const [serverOk, setServerOk] = useState<string | null>(null);

  const [okVisible, setOkVisible] = useState(false);
  const okAnimateMs = 900;

  const catalogs = useJobCatalogs();

  const [showDisabilityOptions, setShowDisabilityOptions] = useState(false);

  const meQuery = useQuery({
    queryKey: ['applicant', 'me'],
    queryFn: apiGetMe,
    staleTime: 30_000,
  });

  const me = meQuery.data;

  const form = useForm<FormValues>({
    mode: 'onChange',
    defaultValues: {
      fullName: '',
      contactEmail: '',
      contactPhone: '',
      profileSummary: '',
      departmentId: '',
      provinceId: '',
      districtId: '',
      disabilityIds: [],
      experiences: [],
      educations: [],
      skills: [],
    },
  });

  const expFA = useFieldArray({ control: form.control, name: 'experiences' });
  const eduFA = useFieldArray({ control: form.control, name: 'educations' });
  const skillFA = useFieldArray({ control: form.control, name: 'skills' });

  const watched = form.watch();
  const departmentId = watched.departmentId;
  const provinceId = watched.provinceId;
  const districtId = watched.districtId;
  const selectedDisabilityIds = watched.disabilityIds ?? [];

  const departmentsQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'departments'],
    queryFn: () => apiJson<GeoItem[]>(DEPARTMENTS_ENDPOINT),
    staleTime: 24 * 60 * 60 * 1000,
  });

  const provincesQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'provinces', departmentId],
    queryFn: () =>
      apiJson<GeoItem[]>(`${PROVINCES_ENDPOINT}?departmentId=${encodeURIComponent(departmentId)}`),
    enabled: !!departmentId,
    staleTime: 24 * 60 * 60 * 1000,
  });

  const districtsQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'districts', provinceId],
    queryFn: () =>
      apiJson<GeoItem[]>(`${DISTRICTS_ENDPOINT}?provinceId=${encodeURIComponent(provinceId)}`),
    enabled: !!provinceId,
    staleTime: 24 * 60 * 60 * 1000,
  });

  const resolveQuery = useQuery<DistrictResolveResponse>({
    queryKey: ['catalogs', 'geo', 'district-resolve', me?.districtId ?? null],
    queryFn: () => apiJson<DistrictResolveResponse>(DISTRICT_RESOLVE_ENDPOINT(me!.districtId!)),
    enabled: !!me?.districtId,
    staleTime: 5 * 60 * 1000,
  });

  useEffect(() => {
    if (!me) return;

    const r = resolveQuery.data;

    form.reset(
      {
        fullName: me.fullName ?? '',
        contactEmail: me.contactEmail ?? '',
        contactPhone: me.contactPhone ?? '',
        profileSummary: me.profileSummary ?? '',
        departmentId: r?.departmentId ?? '',
        provinceId: r?.provinceId ?? '',
        districtId: me.districtId ?? '',

        disabilityIds: (me.disabilityIds ?? []).map(String),

        experiences: (me.experiences ?? []).map((e) => ({
          company: e.company ?? '',
          role: e.role ?? '',
          startDate: toIsoDateOrEmpty(e.startDate),
          endDate: toIsoDateOrEmpty(e.endDate),
          description: e.description ?? '',
        })),
        educations: (me.educations ?? []).map((e) => ({
          institution: e.institution ?? '',
          degree: e.degree ?? '',
          startDate: toIsoDateOrEmpty(e.startDate),
          endDate: toIsoDateOrEmpty(e.endDate),
          description: e.description ?? '',
        })),
        skills: (me.skills ?? []).map((s) => ({
          name: s.name ?? '',
          level: s.level ?? '',
        })),
      },
      { keepTouched: false, keepDirty: false }
    );

    setShowDisabilityOptions((me.disabilityIds ?? []).length > 0);
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
    mutationFn: apiUpsertMe,
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

      await qc.invalidateQueries({ queryKey: ['applicant', 'me'] });
    },
    onError: (err: unknown) => {
      const msg = applyApiErrorToForm<FormValues>({
        err,
        setError: form.setError,
      });

      const e: any = err as any;
      const api = tryParseApiError(e?.body);

      if (api?.error === 'APPLICANT_SKILL_ALREADY_EXISTS') {
        const friendly =
          api?.message ||
          'Ya existe una habilidad con ese nombre en tu perfil. Revisa y elimina duplicados.';
        form.setError('skills' as any, { type: 'server', message: friendly });
        setServerError(friendly);
        return;
      }

      const fieldErrors = api?.fieldErrors ?? [];
      for (const fe of fieldErrors) {
        const rawField = String(fe?.field ?? '').trim();
        if (!rawField) continue;

        const path = normalizeArrayFieldPath(rawField);

        if (path === 'skills') {
          form.setError('skills' as any, {
            type: 'server',
            message: fe.message || 'Hay un problema con tus habilidades.',
          });
          continue;
        }

        form.setError(path as any, {
          type: 'server',
          message: fe.message || 'Valor inválido.',
        });
      }

      const violations = api?.violations ?? [];
      if (Array.isArray(violations) && violations.length > 0) {
        for (const v of violations) {
          const param = String(v?.param ?? '').trim();
          if (!param) continue;

          const path = normalizeArrayFieldPath(param);
          form.setError(path as any, {
            type: 'server',
            message: v?.message || 'Parámetro inválido.',
          });
        }
      }

      setServerError(msg);
    },
  });

  const computed = useMemo(() => {
    const fullName = watched.fullName.trim();
    const email = watched.contactEmail.trim();
    const phone = watched.contactPhone.trim();

    const fullNameOk = fullName.length >= 2;
    const emailOk = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    const phoneOk = phone.length === 0 || /^[0-9+()\s-]{6,20}$/.test(phone);

    const departmentOk = watched.departmentId.trim().length > 0;
    const provinceOk = watched.provinceId.trim().length > 0;
    const districtOk = watched.districtId.trim().length > 0;

    const experiencesCount =
      watched.experiences?.filter((e) => e.company.trim() && e.role.trim() && e.startDate)
        ?.length ?? 0;
    const educationsCount =
      watched.educations?.filter((e) => e.institution.trim() && e.degree.trim() && e.startDate)
        ?.length ?? 0;

    const progressState = computeApplicantProfileProgress({
      fullName: watched.fullName,
      contactEmail: watched.contactEmail,
      districtId: watched.districtId,
      experiencesCount,
      educationsCount,
    });

    return {
      fullNameOk,
      emailOk,
      phoneOk,
      departmentOk,
      provinceOk,
      districtOk,

      experiencesCount,
      educationsCount,

      missing: progressState.missing,
      progress: progressState.progress,
      recommendedComplete: progressState.profileComplete,
    };
  }, [watched]);

  const canSubmit =
    computed.fullNameOk &&
    computed.emailOk &&
    computed.phoneOk &&
    computed.departmentOk &&
    computed.provinceOk &&
    computed.districtOk &&
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

    if (!values.departmentId || !values.provinceId || !values.districtId) {
      setServerError('Selecciona departamento, provincia y distrito.');
      return;
    }

    form.clearErrors(['skills']);

    const dupSkillIdx = findDuplicateSkillIndices(values.skills ?? []);
    if (dupSkillIdx.length > 0) {
      for (const i of dupSkillIdx) {
        form.setError(`skills.${i}.name` as any, {
          type: 'validate',
          message: 'Habilidad duplicada. Cambia el nombre o elimina una.',
        });
      }
      setServerError('Tienes habilidades duplicadas. Elimina duplicados antes de guardar.');
      return;
    }

    const experiences = (values.experiences ?? [])
      .map((e) => ({
        company: e.company.trim(),
        role: e.role.trim(),
        startDate: e.startDate,
        endDate: e.endDate?.trim() ? e.endDate : null,
        description: e.description.trim() ? e.description.trim() : null,
      }))
      .filter((e) => e.company && e.role && e.startDate);

    const educations = (values.educations ?? [])
      .map((e) => ({
        institution: e.institution.trim(),
        degree: e.degree.trim(),
        startDate: e.startDate,
        endDate: e.endDate?.trim() ? e.endDate : null,
        description: e.description.trim() ? e.description.trim() : null,
      }))
      .filter((e) => e.institution && e.degree && e.startDate);

    const skills = (values.skills ?? [])
      .map((s) => ({
        name: s.name.trim(),
        level: s.level.trim() ? s.level.trim() : null,
      }))
      .filter((s) => s.name);

    const disabilityIds = showDisabilityOptions
      ? uniqueStrings((values.disabilityIds ?? []).filter(Boolean))
      : [];

    const payload: ApplicantUpsertRequest = {
      fullName: values.fullName.trim(),
      contactEmail: values.contactEmail.trim(),
      contactPhone: values.contactPhone.trim() ? values.contactPhone.trim() : null,
      districtId: values.districtId ? values.districtId : null,
      profileSummary: values.profileSummary.trim() ? values.profileSummary.trim() : null,
      experiences,
      educations,
      skills,
      disabilityIds,
    };

    await updateMutation.mutateAsync(payload);
  };

  const isLoading = meQuery.isLoading;
  const loadError = meQuery.error as any;

  const depsLoading =
    departmentsQuery.isLoading || (resolveQuery.isLoading && !!me?.districtId) || false;
  const geoError = (departmentsQuery.error as any) || (resolveQuery.error as any) || null;

  const disabilityList = useMemo(() => {
    const items = Object.values(catalogs.disabilityTypesById ?? {});
    return items.sort((a, b) => String(a.name ?? '').localeCompare(String(b.name ?? ''), 'es'));
  }, [catalogs.disabilityTypesById]);

  return (
    <section className="flex-1 min-h-0 bg-slate-50 px-4 py-8">
      <div className="max-w-4xl mx-auto">
        <header className="mb-6">
          <div className="mb-3">
            <button
              type="button"
              onClick={() => router.push(routes.dashboard.applicant.home)}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              ← Volver al inicio
            </button>
          </div>

          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
            Configura tu perfil de postulante
          </h1>
          <p className="mt-2 text-sm sm:text-base text-slate-600">
            Completa tus datos para postular con confianza y sin contratiempos: experiencia,
            educación y habilidades.
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
                    Completa lo esencial para postular sin inconvenientes.
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
                        ? 'Tu cuenta está habilitada para usar el portal.'
                        : 'Tu cuenta está deshabilitada; contacta soporte si no reconoces este estado.'
                    }
                  />

                  <StatusPill
                    label={me?.suspended ? 'Suspendida' : 'Sin suspensión'}
                    tone={me?.suspended ? 'danger' : 'ok'}
                    help={
                      me?.suspended
                        ? 'Tu cuenta tiene un bloqueo por moderación o revisión.'
                        : 'Tu cuenta no tiene bloqueos por moderación.'
                    }
                  />
                </div>
              </div>

              <div className="mt-3">
                <div className="flex items-center justify-between text-xs text-slate-600">
                  <span>{computed.progress}%</span>
                  <span>Recomendado para postular</span>
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

            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
              {/* Identidad */}
              <section>
                <h2 className="text-lg font-semibold text-slate-900">Datos personales</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Estos datos se usan para tu perfil y contacto.
                </p>

                <div className="mt-4 grid gap-4 sm:grid-cols-2">
                  <Field
                    label="Nombre completo"
                    required
                    error={
                      form.formState.touchedFields.fullName && !computed.fullNameOk
                        ? 'Debe tener al menos 2 caracteres.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(
                        form.formState.touchedFields.fullName && !computed.fullNameOk
                      )}
                      placeholder="Ej: Ronald Urbano"
                      {...form.register('fullName')}
                    />
                  </Field>

                  <Field
                    label="Correo de contacto"
                    required
                    error={
                      form.formState.touchedFields.contactEmail && !computed.emailOk
                        ? 'Ingresa un correo válido.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(
                        form.formState.touchedFields.contactEmail && !computed.emailOk
                      )}
                      placeholder="ejemplo@correo.com"
                      autoComplete="email"
                      {...form.register('contactEmail')}
                    />
                  </Field>

                  <Field
                    label="Teléfono"
                    hint="Opcional. Ej: +51 999 999 999"
                    error={
                      form.formState.touchedFields.contactPhone && !computed.phoneOk
                        ? 'Teléfono inválido.'
                        : undefined
                    }
                  >
                    <input
                      className={inputClass(
                        form.formState.touchedFields.contactPhone && !computed.phoneOk
                      )}
                      placeholder="+51 999 999 999"
                      autoComplete="tel"
                      {...form.register('contactPhone')}
                    />
                  </Field>

                  <Field label="Resumen profesional" hint="Opcional. 1–3 líneas sobre tu perfil.">
                    <textarea
                      className={textareaClass()}
                      rows={3}
                      placeholder="Ej: Backend Java con experiencia en microservicios, Spring Boot, DDD…"
                      {...form.register('profileSummary')}
                    />
                  </Field>
                </div>
              </section>

              {/* Ubicación */}
              <section>
                <h2 className="text-lg font-semibold text-slate-900">Ubicación</h2>
                <p className="mt-1 text-sm text-slate-600">
                  Selecciona tu distrito para mejorar recomendaciones y filtros.
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
                      form.formState.touchedFields.departmentId && !computed.departmentOk
                        ? 'Selecciona un departamento.'
                        : undefined
                    }
                  >
                    <select
                      className={selectClass(
                        false,
                        form.formState.touchedFields.departmentId && !computed.departmentOk
                      )}
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
                      !!departmentId &&
                      form.formState.touchedFields.provinceId &&
                      !computed.provinceOk
                        ? 'Selecciona una provincia.'
                        : undefined
                    }
                  >
                    <select
                      className={selectClass(
                        !departmentId,
                        !!departmentId &&
                          form.formState.touchedFields.provinceId &&
                          !computed.provinceOk
                      )}
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
                      !!provinceId &&
                      form.formState.touchedFields.districtId &&
                      !computed.districtOk
                        ? 'Selecciona un distrito.'
                        : undefined
                    }
                  >
                    <select
                      className={selectClass(
                        !provinceId,
                        !!provinceId &&
                          form.formState.touchedFields.districtId &&
                          !computed.districtOk
                      )}
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

              <section>
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <h2 className="text-lg font-semibold text-slate-900">Discapacidad</h2>
                    <p className="mt-1 text-sm text-slate-600">
                      Opcional. Activa si deseas indicar un tipo de discapacidad (puedes marcar más
                      de una).
                    </p>
                  </div>

                  <div className="flex items-center gap-3">
                    <span className="text-sm font-semibold text-slate-900">Indicar</span>

                    <button
                      type="button"
                      role="switch"
                      aria-checked={showDisabilityOptions}
                      onClick={() => {
                        const next = !showDisabilityOptions;
                        setShowDisabilityOptions(next);

                        if (!next) {
                          form.setValue('disabilityIds', [], {
                            shouldDirty: true,
                            shouldTouch: true,
                          });
                        }
                      }}
                      className={[
                        'relative inline-flex h-7 w-12 items-center rounded-full transition',
                        'border border-slate-200 shadow-sm',
                        showDisabilityOptions ? 'bg-blue-700' : 'bg-slate-200',
                        'focus:outline-none focus:ring-4 focus:ring-blue-100',
                      ].join(' ')}
                    >
                      <span
                        className={[
                          'inline-block h-6 w-6 transform rounded-full bg-white shadow transition',
                          showDisabilityOptions ? 'translate-x-5' : 'translate-x-1',
                        ].join(' ')}
                      />
                    </button>
                  </div>
                </div>

                {showDisabilityOptions && (
                  <>
                    {catalogs.isLoading && (
                      <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
                        <p className="text-sm text-slate-600">
                          Cargando catálogo de discapacidades…
                        </p>
                      </div>
                    )}

                    {catalogs.error && (
                      <div className="mt-4 rounded-2xl border border-amber-200 bg-amber-50 p-4">
                        <p className="text-sm text-amber-900 font-semibold">
                          No se pudo cargar el catálogo de discapacidades.
                        </p>
                      </div>
                    )}

                    {!catalogs.isLoading && !catalogs.error && disabilityList.length === 0 && (
                      <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
                        <p className="text-sm text-slate-600">
                          No hay tipos de discapacidad disponibles en este momento.
                        </p>
                      </div>
                    )}

                    <div className="mt-4 grid gap-3 sm:grid-cols-2">
                      {disabilityList.map((d) => {
                        const selected = selectedDisabilityIds.includes(d.id);
                        const disabled = d.active === false;

                        return (
                          <label
                            key={d.id}
                            className={[
                              'flex items-start gap-3 rounded-2xl border p-4 transition',
                              disabled
                                ? 'border-slate-200 bg-slate-50 opacity-70 cursor-not-allowed'
                                : 'border-slate-200 bg-white hover:bg-slate-50 cursor-pointer',
                            ].join(' ')}
                          >
                            <input
                              type="checkbox"
                              className="mt-1 h-4 w-4"
                              checked={selected}
                              disabled={disabled}
                              onChange={(e) => {
                                if (disabled) return;

                                const current = form.getValues('disabilityIds') ?? [];
                                const next = e.target.checked
                                  ? uniqueStrings([...current, d.id])
                                  : current.filter((x) => x !== d.id);

                                form.setValue('disabilityIds', next, {
                                  shouldDirty: true,
                                  shouldTouch: true,
                                });
                              }}
                            />
                            <div>
                              <p className="text-sm font-semibold text-slate-900">{d.name}</p>
                              {disabled && <p className="text-xs text-slate-500">No disponible</p>}
                            </div>
                          </label>
                        );
                      })}
                    </div>
                  </>
                )}
              </section>

              {/* Experiencia */}
              <section>
                <div className="flex items-center justify-between gap-3">
                  <div>
                    <h2 className="text-lg font-semibold text-slate-900">Experiencia</h2>
                    <p className="mt-1 text-sm text-slate-600">
                      Agrega al menos una experiencia o una educación para completar tu perfil.
                    </p>
                  </div>

                  <button
                    type="button"
                    onClick={() =>
                      expFA.append({
                        company: '',
                        role: '',
                        startDate: '',
                        endDate: '',
                        description: '',
                      })
                    }
                    className="inline-flex items-center gap-2 rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
                  >
                    <Plus className="w-4 h-4" aria-hidden="true" />
                    Agregar
                  </button>
                </div>

                {expFA.fields.length === 0 && (
                  <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
                    <p className="text-sm text-slate-600">
                      Aún no registras experiencia. Puedes agregar una ahora.
                    </p>
                  </div>
                )}

                <div className="mt-4 space-y-4">
                  {expFA.fields.map((f, idx) => (
                    <div key={f.id} className="rounded-2xl border border-slate-100 p-4">
                      <div className="flex items-center justify-between gap-3">
                        <p className="text-sm font-semibold text-slate-900">
                          Experiencia #{idx + 1}
                        </p>
                        <button
                          type="button"
                          onClick={() => expFA.remove(idx)}
                          className="inline-flex items-center gap-2 rounded-2xl bg-white px-3 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
                        >
                          <Trash2 className="w-4 h-4" aria-hidden="true" />
                          Quitar
                        </button>
                      </div>

                      <div className="mt-4 grid gap-4 sm:grid-cols-2">
                        <Field label="Empresa" required>
                          <input
                            className={inputClass()}
                            placeholder="Ej: ACME SAC"
                            {...form.register(`experiences.${idx}.company` as const)}
                          />
                        </Field>

                        <Field label="Rol / Cargo" required>
                          <input
                            className={inputClass()}
                            placeholder="Ej: Backend Developer"
                            {...form.register(`experiences.${idx}.role` as const)}
                          />
                        </Field>

                        <Field label="Fecha inicio" required>
                          <input
                            className={inputClass()}
                            type="date"
                            {...form.register(`experiences.${idx}.startDate` as const)}
                          />
                        </Field>

                        <Field
                          label="Fecha fin"
                          hint="Opcional. Deja vacío si es tu trabajo actual."
                        >
                          <input
                            className={inputClass()}
                            type="date"
                            {...form.register(`experiences.${idx}.endDate` as const)}
                          />
                        </Field>

                        <div className="sm:col-span-2">
                          <Field label="Descripción" hint="Opcional. Logros y responsabilidades.">
                            <textarea
                              className={textareaClass()}
                              rows={3}
                              {...form.register(`experiences.${idx}.description` as const)}
                            />
                          </Field>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </section>

              {/* Educación */}
              <section>
                <div className="flex items-center justify-between gap-3">
                  <div>
                    <h2 className="text-lg font-semibold text-slate-900">Educación</h2>
                    <p className="mt-1 text-sm text-slate-600">
                      Puedes registrar estudios, certificaciones o formación técnica.
                    </p>
                  </div>

                  <button
                    type="button"
                    onClick={() =>
                      eduFA.append({
                        institution: '',
                        degree: '',
                        startDate: '',
                        endDate: '',
                        description: '',
                      })
                    }
                    className="inline-flex items-center gap-2 rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
                  >
                    <Plus className="w-4 h-4" aria-hidden="true" />
                    Agregar
                  </button>
                </div>

                {eduFA.fields.length === 0 && (
                  <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
                    <p className="text-sm text-slate-600">
                      Aún no registras educación. Puedes agregar una ahora.
                    </p>
                  </div>
                )}

                <div className="mt-4 space-y-4">
                  {eduFA.fields.map((f, idx) => (
                    <div key={f.id} className="rounded-2xl border border-slate-100 p-4">
                      <div className="flex items-center justify-between gap-3">
                        <p className="text-sm font-semibold text-slate-900">Educación #{idx + 1}</p>
                        <button
                          type="button"
                          onClick={() => eduFA.remove(idx)}
                          className="inline-flex items-center gap-2 rounded-2xl bg-white px-3 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
                        >
                          <Trash2 className="w-4 h-4" aria-hidden="true" />
                          Quitar
                        </button>
                      </div>

                      <div className="mt-4 grid gap-4 sm:grid-cols-2">
                        <Field label="Institución" required>
                          <input
                            className={inputClass()}
                            placeholder="Ej: Instituto / Universidad"
                            {...form.register(`educations.${idx}.institution` as const)}
                          />
                        </Field>

                        <Field label="Grado / Programa" required>
                          <input
                            className={inputClass()}
                            placeholder="Ej: Ingeniería / Bootcamp / Certificación"
                            {...form.register(`educations.${idx}.degree` as const)}
                          />
                        </Field>

                        <Field label="Fecha inicio" required>
                          <input
                            className={inputClass()}
                            type="date"
                            {...form.register(`educations.${idx}.startDate` as const)}
                          />
                        </Field>

                        <Field label="Fecha fin" hint="Opcional.">
                          <input
                            className={inputClass()}
                            type="date"
                            {...form.register(`educations.${idx}.endDate` as const)}
                          />
                        </Field>

                        <div className="sm:col-span-2">
                          <Field label="Descripción" hint="Opcional.">
                            <textarea
                              className={textareaClass()}
                              rows={3}
                              {...form.register(`educations.${idx}.description` as const)}
                            />
                          </Field>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </section>

              {/* Habilidades */}
              <section>
                <div className="flex items-center justify-between gap-3">
                  <div>
                    <h2 className="text-lg font-semibold text-slate-900">Habilidades</h2>
                    <p className="mt-1 text-sm text-slate-600">
                      Agrega tecnologías o habilidades relevantes (opcional).
                    </p>
                  </div>

                  <button
                    type="button"
                    onClick={() => skillFA.append({ name: '', level: '' })}
                    className="inline-flex items-center gap-2 rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
                  >
                    <Plus className="w-4 h-4" aria-hidden="true" />
                    Agregar
                  </button>
                </div>

                {skillFA.fields.length === 0 && (
                  <div className="mt-4 rounded-2xl border border-slate-100 bg-slate-50 p-4">
                    <p className="text-sm text-slate-600">
                      No tienes habilidades registradas. Puedes agregar algunas para mejorar tu
                      perfil.
                    </p>
                  </div>
                )}

                <div className="mt-4 space-y-3">
                  {skillFA.fields.map((f, idx) => (
                    <div key={f.id} className="rounded-2xl border border-slate-100 p-4">
                      <div className="flex items-center justify-between gap-3">
                        <p className="text-sm font-semibold text-slate-900">Habilidad #{idx + 1}</p>
                        <button
                          type="button"
                          onClick={() => skillFA.remove(idx)}
                          className="inline-flex items-center gap-2 rounded-2xl bg-white px-3 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
                        >
                          <Trash2 className="w-4 h-4" aria-hidden="true" />
                          Quitar
                        </button>
                      </div>

                      <div className="mt-4 grid gap-4 sm:grid-cols-2">
                        <Field
                          label="Nombre"
                          required
                          error={
                            (form.formState.errors.skills as any)?.[idx]?.name?.message as
                              | string
                              | undefined
                          }
                        >
                          <input
                            className={inputClass(
                              !!(form.formState.errors.skills as any)?.[idx]?.name
                            )}
                            placeholder="Ej: Spring Boot"
                            {...form.register(`skills.${idx}.name` as const)}
                          />
                        </Field>

                        <Field label="Nivel" hint="Opcional. Ej: Beginner/Intermediate/Advanced">
                          <input
                            className={inputClass()}
                            placeholder="Ej: Advanced"
                            {...form.register(`skills.${idx}.level` as const)}
                          />
                        </Field>
                      </div>
                    </div>
                  ))}
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
                  Luego vuelve a{' '}
                  <a
                    className="text-blue-700 hover:text-blue-800 font-semibold"
                    href={routes.dashboard.applicant.home}
                  >
                    Inicio
                  </a>{' '}
                  y postula a una oferta.
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

function textareaClass(hasError?: boolean) {
  return [
    'w-full rounded-2xl border px-3 py-2.5 text-sm outline-none transition',
    'bg-white resize-none',
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
