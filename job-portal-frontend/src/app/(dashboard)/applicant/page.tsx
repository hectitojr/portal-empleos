'use client';

import SearchBar from '@/features/home/components/SearchBar';
import AuthHeader from '@/features/iam/components/AuthHeader';
import { useLandingState } from '@/features/home/hooks/useLandingState';
import { featuredJobs } from '@/features/home/lib/data';
import JobsMasterDetail from '@/features/jobs/components/JobsMasterDetail';

export default function ApplicantHomePage() {
  const s = useLandingState();
  const jobs = featuredJobs;

  return (
    <section
      role="region"
      aria-label="Inicio candidato"
      className="flex flex-col flex-1 min-h-0"
    >
      {/* Hero con buscador */}
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

      {/* ✅ LISTADO + DETALLE COMPARTIDO */}
      <JobsMasterDetail
        jobs={jobs}
        variant="applicant"
        listTitle="Empleos recomendados"
        listSubtitle="Basados en tus intereses y búsquedas recientes."
      />
    </section>
  );
}
