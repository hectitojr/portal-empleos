'use client';

import { useState } from 'react';
import SearchBar from '@/features/home/components/SearchBar';
import AuthHeader from '@/features/iam/components/AuthHeader';
import { useLandingState } from '@/app/home/hooks/useLandingState';
import { featuredJobs } from '@/features/home/lib/data';

export default function LandingPage() {
  const s = useLandingState();
  const jobs = featuredJobs;

  const [selectedJobId, setSelectedJobId] = useState<number | null>(
    jobs.length ? jobs[0].id : null
  );

  const currentPage: number = 2;  // ej. dummy
  const totalPages: number = 3;   // ej. dummy

  const selectedJob = jobs.find((job) => job.id === selectedJobId) ?? jobs[0];

  return (
    <section
      role="region"
      aria-label="Inicio"
      className="flex flex-col flex-1 min-h-0"
    >
      {/* Hero con buscador */}
      <section className="py-8 shrink-0">
        <div className="max-w-4xl mx-auto px-4 sm:px-6">
          <div className="mb-4">
            <AuthHeader
              title="Encuentra tu próximo trabajo"
              subtitle="Busca por título, palabra clave o ubicación"
            />
          </div>

          <SearchBar
            searchQuery={s.searchQuery}
            location={s.location}
            onChangeQuery={(v) => s.setSearchQuery(v)}
            onChangeLocation={(v) => s.setLocation(v)}
            onSubmit={s.submit}
          />
        </div>
      </section>

      {/* Listado + detalle tipo LinkedIn */}
      <section
        id="empleos"
        className="flex-1 bg-slate-50 py-8 flex flex-col min-h-0"
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex-1 min-h-0">
          <div className="grid gap-8 lg:grid-cols-[minmax(0,1.3fr)_minmax(0,2.2fr)] h-full min-h-0">
            {/* Columna izquierda: listado + paginador */}
            <div className="bg-white rounded-2xl shadow-sm border border-slate-100 flex flex-col overflow-hidden">
              <header className="px-6 py-4 border-b border-slate-100">
                <h2 className="text-base sm:text-lg font-semibold text-slate-900">
                  Empleos que te recomendamos
                </h2>
                <p className="text-sm sm:text-base text-slate-500">
                  Explora las oportunidades más recientes y relevantes.
                </p>
                <p className="mt-1 text-xs text-slate-400">
                  {jobs.length} resultados
                </p>
              </header>

              <div className="flex-1 overflow-y-auto">
                <ul className="divide-y divide-slate-100">
                  {jobs.map((job) => {
                    const isActive = job.id === selectedJob?.id;

                    return (
                      <li key={job.id}>
                        <button
                          type="button"
                          onClick={() => setSelectedJobId(job.id)}
                          className={`w-full text-left px-6 py-5 sm:py-6 text-[15px] transition-colors ${
                            isActive
                              ? 'bg-slate-50 border-l-4 border-l-blue-600'
                              : 'hover:bg-slate-50'
                          }`}
                          aria-current={isActive ? 'true' : 'false'}
                        >
                          <div className="flex items-start justify-between gap-3">
                            <div>
                              <h3 className="text-sm sm:text-base font-semibold text-slate-900">
                                {job.title}
                              </h3>
                              <p className="text-xs sm:text-sm text-slate-600">
                                {job.company}
                              </p>
                              {job.location && (
                                <p className="mt-1 text-xs text-slate-500">
                                  {job.location}
                                </p>
                              )}
                            </div>
                            {job.salary && (
                              <span className="text-xs sm:text-sm font-semibold text-blue-700">
                                {job.salary}
                              </span>
                            )}
                          </div>

                          {job.tags && job.tags.length > 0 && (
                            <div className="mt-2 flex flex-wrap gap-1.5">
                              {job.tags.slice(0, 4).map((tag) => (
                                <span
                                  key={tag}
                                  className="inline-flex items-center px-2.5 py-0.5 rounded-full bg-slate-100 text-[11px] font-medium text-slate-700"
                                >
                                  {tag}
                                </span>
                              ))}
                            </div>
                          )}

                          {job.posted && (
                            <p className="mt-2 text-[11px] text-slate-400">
                              Publicado {job.posted}
                            </p>
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
                    {[1, 2, 3].map((page) => {
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

            {/* Columna derecha: detalle */}
            <div className="bg-white rounded-2xl shadow-sm border border-slate-100 flex flex-col overflow-hidden">
              <div className="flex-1 overflow-y-auto p-8 sm:p-10 text-[15px] leading-relaxed">
                {selectedJob ? (
                  <>
                    <div className="flex flex-wrap items-start justify-between gap-3 mb-4">
                      <div>
                        <h3 className="text-2xl font-semibold text-slate-900 mb-1">
                          {selectedJob.title}
                        </h3>
                        <p className="text-sm text-slate-700">
                          {selectedJob.company}
                        </p>
                        {selectedJob.location && (
                          <p className="mt-1 text-sm text-slate-500">
                            {selectedJob.location}
                          </p>
                        )}
                      </div>

                      {selectedJob.salary && (
                        <div className="text-right">
                          <p className="text-xs text-slate-500 mb-1">
                            Rango salarial estimado
                          </p>
                          <p className="text-sm font-semibold text-blue-700">
                            {selectedJob.salary}
                          </p>
                        </div>
                      )}
                    </div>

                    {selectedJob.tags && selectedJob.tags.length > 0 && (
                      <div className="mb-4 flex flex-wrap gap-1.5">
                        {selectedJob.tags.map((tag) => (
                          <span
                            key={tag}
                            className="inline-flex items-center px-2.5 py-0.5 rounded-full bg-slate-100 text-[11px] font-medium text-slate-700"
                          >
                            {tag}
                          </span>
                        ))}
                      </div>
                    )}

                    <div className="mb-6 text-sm text-slate-700 space-y-3">
                      <p>
                        Aquí podrás añadir la descripción completa del puesto:
                        responsabilidades, requisitos, beneficios y cualquier
                        información relevante para el proceso de selección.
                      </p>
                    </div>

                    <div className="flex flex-wrap items-center gap-3">
                      <button
                        type="button"
                        className="inline-flex items-center justify-center rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-5 py-2.5 transition shadow-sm"
                      >
                        Postular ahora
                      </button>
                      <button
                        type="button"
                        className="inline-flex items-center justify-center rounded-xl border border-slate-300 hover:bg-slate-50 text-sm font-semibold px-4 py-2.5 text-slate-800 transition"
                      >
                        Guardar oferta
                      </button>
                    </div>
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
    </section>
  );
}
