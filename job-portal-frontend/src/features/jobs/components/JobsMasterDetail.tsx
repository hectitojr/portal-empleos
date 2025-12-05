'use client';

import { useMemo, useState } from 'react';
import Link from 'next/link';
import type { Route } from 'next';
import { getTimeAgo } from '@/lib/dateUtils';
import type { Job } from '@/features/home/lib/types';
import {
  usePublicJobDetail,
  useApplicantJobDetail,
  useApplyToJob,
} from '@/features/jobs/hooks/useJobs';
import { humanize } from '@/lib/errors';

type Variant = 'public' | 'applicant';

type Props = {
  jobs: Job[];
  variant: Variant;

  listTitle: string;
  listSubtitle: string;

  currentPage?: number;
  totalPages?: number;

  initialSelectedId?: string | null;
};

export default function JobsMasterDetail({
  jobs,
  variant,
  listTitle,
  listSubtitle,
  currentPage = 1,
  totalPages = 1,
  initialSelectedId = null,
}: Props) {
  const firstId = jobs[0]?.id ?? null;
  const [selectedJobId, setSelectedJobId] = useState<string | null>(initialSelectedId ?? firstId);

  const selectedJob = useMemo(
    () => jobs.find((j) => j.id === selectedJobId) ?? jobs[0],
    [jobs, selectedJobId]
  );

  const { data: publicDetail, isLoading: loadingPublicDetail } = usePublicJobDetail(
    variant === 'public' ? selectedJobId : null
  );

  const {
    data: applicantDetail,
    isLoading: loadingApplicantDetail,
    error: applicantDetailError,
  } = useApplicantJobDetail(variant === 'applicant' ? selectedJobId : null);

  const detail = variant === 'public' ? publicDetail : applicantDetail;
  const isDetailLoading = variant === 'public' ? loadingPublicDetail : loadingApplicantDetail;

  const applyMutation = useApplyToJob();

  const handleSelectJob = (jobId: string) => {
    setSelectedJobId(jobId);
    // Para applicant, el detalle (hook) se encargará de marcar "viewed" en backend
  };

  const handleApply = (jobId: string) => {
    if (variant !== 'applicant') return;
    if (!jobId || applyMutation.isPending) return;
    applyMutation.mutate({ jobId });
  };

  const appliedErrorCode = (applyMutation.error as any)?.error?.code;

  return (
    <section id="empleos" className="flex-1 bg-slate-50 py-8 flex flex-col min-h-0">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex-1 min-h-0">
        <div className="grid gap-8 lg:grid-cols-[minmax(0,1.3fr)_minmax(0,2.2fr)] h-full min-h-0">
          {/* Lista de ofertas */}
          <div className="bg-white rounded-2xl shadow-sm border border-slate-100 flex flex-col overflow-hidden">
            <header className="px-6 py-4 border-b border-slate-100">
              <h2 className="text-base sm:text-lg font-semibold text-slate-900">{listTitle}</h2>
              <p className="text-sm sm:text-base text-slate-500">{listSubtitle}</p>
              <p className="mt-1 text-xs text-slate-400">{jobs.length} resultados</p>
            </header>

            <div className="flex-1 overflow-y-auto">
              <ul className="divide-y divide-slate-100">
                {jobs.map((job) => {
                  const isActiveRow = job.id === selectedJob?.id;
                  const isViewed = variant === 'applicant' ? job.viewed : false;
                  const hasApplied = variant === 'applicant' ? job.isApplied : false;

                  return (
                    <li key={job.id}>
                      <button
                        type="button"
                        onClick={() => handleSelectJob(job.id)}
                        className={`w-full text-left px-6 py-5 sm:py-6 text-[15px] transition-colors ${
                          isActiveRow
                            ? 'bg-slate-50 border-l-4 border-l-blue-600'
                            : 'hover:bg-slate-50'
                        }`}
                        aria-current={isActiveRow ? 'true' : 'false'}
                      >
                        <div className="flex items-start justify-between gap-3">
                          <div className="flex-1">
                            <h3 className="text-sm sm:text-base font-semibold text-slate-900 mb-1">
                              {job.title}
                            </h3>
                            <p className="text-xs sm:text-sm text-slate-600">{job.company}</p>

                            {job.location && (
                              <p className="mt-1 text-xs text-slate-500 flex items-center gap-1">
                                <svg
                                  className="w-3 h-3 text-red-500"
                                  fill="currentColor"
                                  viewBox="0 0 24 24"
                                >
                                  <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z" />
                                </svg>
                                {job.location}
                              </p>
                            )}
                          </div>

                          {job.salary && (
                            <span className="text-xs sm:text-sm font-semibold text-blue-700 whitespace-nowrap">
                              {job.salary}
                            </span>
                          )}
                        </div>

                        <div className="mt-3 flex flex-wrap gap-2">
                          {job.employmentType && (
                            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full bg-blue-50 text-[11px] font-medium text-blue-700">
                              {job.employmentType}
                            </span>
                          )}
                          {job.workMode && (
                            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full bg-green-50 text-[11px] font-medium text-green-700">
                              {job.workMode}
                            </span>
                          )}
                        </div>

                        {variant === 'applicant' ? (
                          <div className="mt-3 space-y-1">
                            {job.isActive ? (
                              hasApplied ? (
                                <p className="text-xs text-blue-600 font-semibold flex items-center gap-1.5">
                                  <svg
                                    className="w-3.5 h-3.5"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                    strokeWidth={2}
                                  >
                                    <path
                                      strokeLinecap="round"
                                      strokeLinejoin="round"
                                      d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                                    />
                                  </svg>
                                  Ya te postulaste a esta oferta
                                </p>
                              ) : (
                                <p className="text-xs text-emerald-700 font-semibold flex items-center gap-1.5">
                                  <svg
                                    className="w-3.5 h-3.5"
                                    fill="currentColor"
                                    viewBox="0 0 24 24"
                                  >
                                    <path d="M13 2L3 14h8l-1 8 10-12h-8l1-8z" />
                                  </svg>
                                  {job.quickApply}
                                </p>
                              )
                            ) : (
                              <p className="text-xs text-slate-500 font-medium flex items-center gap-1.5">
                                <svg
                                  className="w-3.5 h-3.5"
                                  fill="none"
                                  stroke="currentColor"
                                  viewBox="0 0 24 24"
                                  strokeWidth={2}
                                >
                                  <path
                                    strokeLinecap="round"
                                    strokeLinejoin="round"
                                    d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"
                                  />
                                </svg>
                                Ya no se aceptan postulaciones
                              </p>
                            )}

                            <p className="text-[10px] text-slate-400 pl-5">
                              Publicado {getTimeAgo(job.postedAt)}
                            </p>

                            {isViewed && (
                              <p className="text-[11px] text-slate-600 font-semibold pl-5">Visto</p>
                            )}
                          </div>
                        ) : (
                          <div className="mt-3">
                            <p className="text-[10px] text-slate-400">
                              Publicado {getTimeAgo(job.postedAt)}
                            </p>
                          </div>
                        )}
                      </button>
                    </li>
                  );
                })}
              </ul>
            </div>

            <footer className="border-t border-slate-100 px-6 py-4">
              <nav
                aria-label="Paginación de ofertas"
                className="flex items-center justify-between text-xs sm:text-sm text-slate-600"
              >
                <button
                  type="button"
                  disabled={currentPage === 1}
                  className={`inline-flex items-center gap-1 px-2 py-1 rounded-full
                    hover:bg-slate-100
                    ${
                      currentPage === 1
                        ? 'text-slate-300 hover:bg-transparent cursor-default'
                        : 'text-slate-600'
                    }`}
                >
                  <span aria-hidden="true">‹</span>
                  <span>Anterior</span>
                </button>

                <div className="flex items-center gap-2">
                  {Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => {
                    const isActive = page === currentPage;
                    return (
                      <button
                        key={page}
                        type="button"
                        className={`w-8 h-8 rounded-full text-sm font-medium
                            ${
                              isActive
                                ? 'bg-slate-900 text-white'
                                : 'text-slate-600 hover:bg-slate-100'
                            }`}
                      >
                        {page}
                      </button>
                    );
                  })}
                </div>

                <button
                  type="button"
                  disabled={currentPage === totalPages}
                  className={`inline-flex items-center gap-1 px-2 py-1 rounded-full
                    hover:bg-slate-100
                    ${
                      currentPage === totalPages
                        ? 'text-slate-300 hover:bg-transparent cursor-default'
                        : 'text-slate-600'
                    }`}
                >
                  <span>Siguiente</span>
                  <span aria-hidden="true">›</span>
                </button>
              </nav>
            </footer>
          </div>

          {/* Panel de detalle */}
          <div className="bg-white rounded-2xl shadow-sm border border-slate-100 flex flex-col overflow-hidden">
            <div className="flex-1 overflow-y-auto p-8 sm:p-10 text-[15px] leading-relaxed">
              {selectedJob ? (
                <>
                  <div className="mb-6">
                    <div className="flex items-start justify-between gap-4 mb-4">
                      <div className="flex-1">
                        <h3 className="text-2xl font-semibold text-slate-900 mb-2">
                          {selectedJob.title}
                        </h3>
                        <p className="text-base text-slate-700 font-medium mb-1">
                          {selectedJob.company}
                        </p>

                        {selectedJob.location && (
                          <p className="text-sm text-slate-500 flex items-center gap-1.5">
                            <svg
                              className="w-4 h-4 text-red-500"
                              fill="currentColor"
                              viewBox="0 0 24 24"
                            >
                              <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z" />
                            </svg>
                            {selectedJob.location}
                          </p>
                        )}

                        <p className="mt-1 text-xs text-slate-400">
                          Publicado {getTimeAgo(selectedJob.postedAt)}
                        </p>
                      </div>
                    </div>

                    <div className="flex flex-wrap gap-3 mb-6">
                      {selectedJob.workMode && (
                        <div className="flex items-center gap-2 px-4 py-2 bg-slate-50 rounded-lg">
                          <span className="text-xs text-slate-500">Modalidad:</span>
                          <span className="text-sm font-semibold text-slate-900">
                            {selectedJob.workMode}
                          </span>
                        </div>
                      )}

                      {selectedJob.employmentType && (
                        <div className="flex items-center gap-2 px-4 py-2 bg-slate-50 rounded-lg">
                          <span className="text-xs text-slate-500">Tipo:</span>
                          <span className="text-sm font-semibold text-slate-900">
                            {selectedJob.employmentType}
                          </span>
                        </div>
                      )}

                      {selectedJob.salary && (
                        <div className="flex items-center gap-2 px-4 py-2 bg-blue-50 rounded-lg">
                          <span className="text-xs text-blue-600">Salario:</span>
                          <span className="text-sm font-semibold text-blue-700">
                            {selectedJob.salary}
                          </span>
                        </div>
                      )}
                    </div>
                  </div>

                  <div className="mb-6 text-sm text-slate-700 space-y-3">
                    {isDetailLoading ? (
                      <p>Cargando descripción de la oferta...</p>
                    ) : detail?.description ? (
                      <p className="whitespace-pre-line">{detail.description}</p>
                    ) : (
                      <p>
                        Aquí podrás añadir la descripción completa del puesto: responsabilidades,
                        requisitos, beneficios y cualquier información relevante para el proceso de
                        selección.
                      </p>
                    )}

                    {variant === 'applicant' && applicantDetailError && (
                      <p className="text-xs text-red-600">
                        No se pudo cargar el detalle de la oferta.
                      </p>
                    )}
                  </div>

                  <div className="flex flex-wrap items-center gap-3">
                    {variant === 'applicant' ? (
                      (() => {
                        const active = applicantDetail?.active ?? selectedJob.isActive;
                        const applied = applicantDetail?.applied ?? selectedJob.isApplied;
                        const quickText = applicantDetail?.quickApplyText ?? selectedJob.quickApply;

                        if (!active) {
                          return (
                            <button
                              type="button"
                              disabled
                              className="inline-flex items-center justify-center rounded-xl bg-slate-300 text-slate-500 text-sm font-semibold px-6 py-3 cursor-not-allowed"
                            >
                              Ya no se aceptan postulaciones
                            </button>
                          );
                        }

                        if (applied) {
                          return (
                            <button
                              type="button"
                              disabled
                              className="inline-flex items-center justify-center rounded-xl bg-blue-100 text-blue-700 text-sm font-semibold px-6 py-3 cursor-not-allowed"
                            >
                              <svg
                                className="w-4 h-4 mr-2"
                                fill="none"
                                stroke="currentColor"
                                viewBox="0 0 24 24"
                                strokeWidth={2}
                              >
                                <path
                                  strokeLinecap="round"
                                  strokeLinejoin="round"
                                  d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                                />
                              </svg>
                              Ya te postulaste a esta oferta
                            </button>
                          );
                        }

                        return (
                          <button
                            type="button"
                            onClick={() => handleApply(selectedJob.id)}
                            disabled={applyMutation.isPending}
                            className="inline-flex items-center justify-center rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-6 py-3 transition shadow-sm disabled:opacity-70 disabled:cursor-not-allowed"
                          >
                            {applyMutation.isPending ? 'Postulando...' : quickText}
                          </button>
                        );
                      })()
                    ) : (
                      <Link
                        href={`/auth/login?next=/` as Route}
                        className="inline-flex items-center justify-center rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-6 py-3 transition shadow-sm"
                      >
                        Inicia sesión para postular
                      </Link>
                    )}

                    <button
                      type="button"
                      className="inline-flex items-center justify-center rounded-xl border border-slate-300 hover:bg-slate-50 text-sm font-semibold px-5 py-3 text-slate-800 transition"
                    >
                      Guardar oferta
                    </button>
                  </div>

                  {variant === 'applicant' && applyMutation.error && (
                    <p className="mt-3 text-xs text-red-600">
                      {humanize(appliedErrorCode) ||
                        'No se pudo completar la postulación. Intenta nuevamente.'}
                    </p>
                  )}
                </>
              ) : (
                <p className="text-sm text-slate-600">
                  Selecciona una oferta en la lista para ver los detalles.
                </p>
              )}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
