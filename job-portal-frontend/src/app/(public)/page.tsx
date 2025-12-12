'use client';

import SearchBar from '@/features/home/components/SearchBar';
import AuthHeader from '@/features/iam/components/AuthHeader';
import { useLandingState } from '@/features/home/hooks/useLandingState';
import JobsMasterDetail from '@/features/jobs/components/JobsMasterDetail';
import { usePublicJobs } from '@/features/jobs/hooks/useJobs';

export default function LandingPage() {
  const s = useLandingState();

  const {
    data: jobs = [],
    isLoading,
    error,
  } = usePublicJobs({
    page: 0,
    size: 20,
  });

  return (
    <section role="region" aria-label="Inicio" className="flex flex-col flex-1 min-h-0">
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
            onChangeQuery={s.setSearchQuery}
            onChangeLocation={s.setLocation}
            onSubmit={s.submit}
          />
        </div>
      </section>

      <section className="flex-1 min-h-0 flex flex-col">
        {isLoading && (
          <div className="flex-1 flex items-center justify-center text-sm text-slate-600">
            Cargando ofertas...
          </div>
        )}

        {error && !isLoading && (
          <div className="flex-1 flex items-center justify-center">
            <p className="text-sm text-red-600">
              No se pudieron cargar las ofertas. Intenta nuevamente en unos minutos.
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
            variant="public"
            listTitle="Empleos que te recomendamos"
            listSubtitle="Explora las oportunidades más recientes y relevantes."
            currentPage={1}
            totalPages={1}
          />
        )}
      </section>
    </section>
  );
}
