'use client';

import SearchBar from '@/features/home/components/SearchBar';
import AuthHeader from '@/features/iam/components/AuthHeader';
import { useLandingState } from '@/features/home/hooks/useLandingState';
import JobsMasterDetail from '@/features/jobs/components/JobsMasterDetail';
import { useApplicantJobs } from '@/features/jobs/hooks/useJobs';

export default function ApplicantHomePage() {
  const s = useLandingState();

  const {
    data: jobs = [],
    isLoading,
    error,
  } = useApplicantJobs({
    page: 0,
    size: 20,
  });

  return (
    <section
      role="region"
      aria-label="Inicio candidato"
      className="flex flex-col flex-1 min-h-0"
    >
      <section className="py-8 shrink-0">
        <div className="max-w-4xl mx-auto px-4 sm:px-6">
          <div className="mb-4">
            <AuthHeader
              title="Encuentra mejores oportunidades"
              subtitle="Explora empleos recomendados para ti"
            />
          </div>

          <SearchBar
            searchQuery={s.searchQuery}
            location={s.location}
            onChangeQuery={s.setSearchQuery}
            onChangeLocation={s.setLocation}
            onSubmit={s.submit}
          />
        </div>
      </section>

      <section className="flex-1 min-h-0 flex flex-col">
        {isLoading && (
          <div className="flex-1 flex items-center justify-center text-sm text-slate-600">
            Cargando empleos recomendados...
          </div>
        )}

        {error && !isLoading && (
          <div className="flex-1 flex items-center justify-center">
            <p className="text-sm text-red-600">
              No se pudieron cargar las ofertas para tu perfil. Intenta nuevamente.
            </p>
          </div>
        )}

        {!isLoading && !error && jobs.length === 0 && (
          <div className="flex-1 flex items-center justify-center">
            <p className="text-sm text-slate-600">
              No hay ofertas disponibles en este momento. Vuelve a intentarlo más tarde.
            </p>
          </div>
        )}

        {!isLoading && !error && jobs.length > 0 && (
          <JobsMasterDetail
            jobs={jobs}
            variant="applicant"
            listTitle="Empleos recomendados"
            listSubtitle="Basados en tus intereses y búsquedas recientes."
            currentPage={1}
            totalPages={1}
          />
        )}
      </section>
    </section>
  );
}
