'use client';

import { useMemo, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useQuery } from '@tanstack/react-query';
import { useForm, type SubmitHandler } from 'react-hook-form';
import type { Route } from 'next';

import { routes } from '@/lib/routes';
import { createCompanyJob } from '@/features/jobs/api/jobsClient';

type UUID = string;

type GeoItem = { id: UUID; name: string };
type CatalogItem = { id: UUID; name: string };

const DEPARTMENTS_ENDPOINT = '/api/catalogs/departments';
const PROVINCES_ENDPOINT = '/api/catalogs/provinces';
const DISTRICTS_ENDPOINT = '/api/catalogs/districts';
const EMPLOYMENT_TYPES_ENDPOINT = '/api/catalogs/employment-types';
const WORK_MODES_ENDPOINT = '/api/catalogs/work-modes';

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

type FormValues = {
  title: string;
  description: string;
  disabilityFriendly: boolean;
  salaryText: string;

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

  const form = useForm<FormValues>({
    mode: 'onChange',
    defaultValues: {
      title: '',
      description: '',
      disabilityFriendly: false,
      salaryText: '',
      departmentId: '',
      provinceId: '',
      districtId: '',
      employmentTypeId: '',
      workModeId: '',
    },
  });

  const watched = form.watch();
  const departmentId = watched.departmentId;
  const provinceId = watched.provinceId;

  const departmentsQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'departments'],
    queryFn: () => apiJson<GeoItem[]>(DEPARTMENTS_ENDPOINT),
    staleTime: 24 * 60 * 60 * 1000,
  });

  const provincesQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'provinces', departmentId],
    queryFn: () =>
      apiJson<GeoItem[]>(
        `${PROVINCES_ENDPOINT}?departmentId=${encodeURIComponent(departmentId)}`,
      ),
    enabled: !!departmentId,
    staleTime: 24 * 60 * 60 * 1000,
  });

  const districtsQuery = useQuery<GeoItem[]>({
    queryKey: ['catalogs', 'geo', 'districts', provinceId],
    queryFn: () =>
      apiJson<GeoItem[]>(
        `${DISTRICTS_ENDPOINT}?provinceId=${encodeURIComponent(provinceId)}`,
      ),
    enabled: !!provinceId,
    staleTime: 24 * 60 * 60 * 1000,
  });

  const employmentTypesQuery = useQuery<CatalogItem[]>({
    queryKey: ['catalogs', 'employment-types'],
    queryFn: () => apiJson<CatalogItem[]>(EMPLOYMENT_TYPES_ENDPOINT),
    staleTime: 24 * 60 * 60 * 1000,
  });

  const workModesQuery = useQuery<CatalogItem[]>({
    queryKey: ['catalogs', 'work-modes'],
    queryFn: () => apiJson<CatalogItem[]>(WORK_MODES_ENDPOINT),
    staleTime: 24 * 60 * 60 * 1000,
  });

  const computed = useMemo(() => {
    const titleOk = watched.title.trim().length >= 4;
    const descOk = watched.description.trim().length >= 20;
    const districtOk = watched.districtId.trim().length > 0;

    return { titleOk, descOk, districtOk };
  }, [watched]);

  const canSubmit = computed.titleOk && computed.descOk && computed.districtOk && !isSaving;

  const onSubmit: SubmitHandler<FormValues> = async (values) => {
    setServerError(null);
    setServerOk(null);
    setIsSaving(true);

    try {
      const res = await createCompanyJob({
        title: values.title.trim(),
        description: values.description.trim(),
        districtId: values.districtId || null,
        disabilityFriendly: !!values.disabilityFriendly,
        employmentTypeId: values.employmentTypeId ? values.employmentTypeId : null,
        workModeId: values.workModeId ? values.workModeId : null,
        salaryText: values.salaryText.trim() ? values.salaryText.trim() : null,
        areaId: null,
        sectorId: null,
      });

      if (!res.ok) {
        const msg =
          (typeof res.error?.message === 'string' && res.error.message) ||
          (typeof res.error?.error === 'string' && res.error.error) ||
          'No se pudo crear la oferta.';
        setServerError(msg);
        return;
      }

      setServerOk('Oferta creada correctamente.');
      router.push(routes.dashboard.company.home);
      router.refresh();
    } finally {
      setIsSaving(false);
    }
  };

  return (
    <section className="bg-slate-50 px-4 py-8">
      <div className="max-w-4xl mx-auto">
        <header className="mb-6">
          <div className="mb-3">
            <button
              type="button"
              onClick={() => router.push(routes.dashboard.company.home)}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
            >
              ← Volver al panel
            </button>
          </div>

          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900">
            Publicar nueva oferta
          </h1>
          <p className="mt-2 text-sm sm:text-base text-slate-600">
            Completa lo esencial para publicar tu vacante. (Área/Sector lo conectamos cuando
            agregues esos catálogos en el frontend).
          </p>
        </header>

        {serverError && (
          <div className="mb-4 rounded-2xl border border-red-200 bg-red-50 p-4">
            <p className="text-sm text-red-700 font-semibold">{serverError}</p>
          </div>
        )}

        {serverOk && (
          <div className="mb-4 rounded-2xl border border-emerald-200 bg-emerald-50 p-4">
            <p className="text-sm text-emerald-800 font-semibold">{serverOk}</p>
          </div>
        )}

        <div className="bg-white rounded-2xl shadow-sm border border-slate-100 p-6 sm:p-8">
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
            <section>
              <h2 className="text-lg font-semibold text-slate-900">Información de la oferta</h2>
              <p className="mt-1 text-sm text-slate-600">
                Título claro + descripción detallada ayudan a mejores postulaciones.
              </p>

              <div className="mt-4 grid gap-4">
                <Field
                  label="Título"
                  required
                  error={
                    form.formState.touchedFields.title && !computed.titleOk
                      ? 'Debe tener al menos 4 caracteres.'
                      : undefined
                  }
                >
                  <input
                    className={inputClass(
                      form.formState.touchedFields.title && !computed.titleOk,
                    )}
                    placeholder="Ej: Backend Java (Spring Boot) - Remoto"
                    {...form.register('title')}
                  />
                </Field>

                <Field
                  label="Descripción"
                  required
                  hint="Mínimo 20 caracteres (validación UX)."
                  error={
                    form.formState.touchedFields.description && !computed.descOk
                      ? 'Describe mejor la vacante (mínimo 20 caracteres).'
                      : undefined
                  }
                >
                  <textarea
                    rows={7}
                    className={inputClass(
                      form.formState.touchedFields.description && !computed.descOk,
                    )}
                    placeholder="Responsabilidades, requisitos, beneficios, etc."
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
                    Inclusiva para personas con discapacidad
                  </label>
                </div>

                <Field label="Salario (texto)" hint="Opcional. Ej: S/ 3,500 - S/ 4,500">
                  <input
                    className={inputClass(false)}
                    placeholder="Ej: S/ 3,500 - S/ 4,500"
                    {...form.register('salaryText')}
                  />
                </Field>
              </div>
            </section>

            <section>
              <h2 className="text-lg font-semibold text-slate-900">Ubicación</h2>
              <p className="mt-1 text-sm text-slate-600">
                Se usa para filtros y visibilidad en búsquedas.
              </p>

              <div className="mt-4 grid gap-4 sm:grid-cols-3">
                <Field label="Departamento" required>
                  <select
                    className={selectClass(false)}
                    value={watched.departmentId}
                    onChange={(e) => {
                      const next = e.target.value;
                      form.setValue('departmentId', next, { shouldDirty: true, shouldTouch: true });
                      form.setValue('provinceId', '', { shouldDirty: true, shouldTouch: true });
                      form.setValue('districtId', '', { shouldDirty: true, shouldTouch: true });
                    }}
                  >
                    <option value="">Selecciona…</option>
                    {(departmentsQuery.data ?? []).map((d) => (
                      <option key={d.id} value={d.id}>
                        {d.name}
                      </option>
                    ))}
                  </select>
                </Field>

                <Field label="Provincia" required>
                  <select
                    className={selectClass(!watched.departmentId)}
                    value={watched.provinceId}
                    disabled={!watched.departmentId || provincesQuery.isLoading}
                    onChange={(e) => {
                      const next = e.target.value;
                      form.setValue('provinceId', next, { shouldDirty: true, shouldTouch: true });
                      form.setValue('districtId', '', { shouldDirty: true, shouldTouch: true });
                    }}
                  >
                    <option value="">
                      {!watched.departmentId
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
                    form.formState.touchedFields.districtId && !computed.districtOk
                      ? 'Selecciona un distrito.'
                      : undefined
                  }
                >
                  <select
                    className={selectClass(!watched.provinceId)}
                    value={watched.districtId}
                    disabled={!watched.provinceId || districtsQuery.isLoading}
                    onChange={(e) =>
                      form.setValue('districtId', e.target.value, {
                        shouldDirty: true,
                        shouldTouch: true,
                      })
                    }
                    onBlur={() => form.trigger('districtId')}
                  >
                    <option value="">
                      {!watched.provinceId
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
              <div className="mt-4 grid gap-4 sm:grid-cols-2">
                <Field label="Tipo de empleo">
                  <select className={selectClass(false)} {...form.register('employmentTypeId')}>
                    <option value="">Selecciona…</option>
                    {(employmentTypesQuery.data ?? []).map((it) => (
                      <option key={it.id} value={it.id}>
                        {it.name}
                      </option>
                    ))}
                  </select>
                </Field>

                <Field label="Modalidad">
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
                {isSaving ? 'Publicando…' : 'Revisa antes de publicar.'}
              </div>

              <div className="flex gap-3">
                <button
                  type="button"
                  onClick={() => router.push(routes.dashboard.company.home as Route)}
                  className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition"
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

function selectClass(disabled?: boolean) {
  return [
    'w-full rounded-2xl border px-3 py-2.5 text-sm outline-none transition bg-white',
    disabled ? 'bg-slate-50 text-slate-500' : '',
    'border-slate-200 focus:border-blue-400 focus:ring-4 focus:ring-blue-100',
  ].join(' ');
}
