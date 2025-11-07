'use client';

import SearchBar from '../home/components/SearchBar';
import FeaturedJobs from '../home/components/FeaturedJobs';
import AuthHeader from './auth/components/AuthHeader'; // opcional: usamos el mismo header visual
import { useLandingState } from '../home/hooks/useLandingState';
import { featuredJobs } from '../home/lib/data';

export default function LandingPage() {
  const s = useLandingState();

  return (
    <section
      role="region"
      aria-label="Inicio"
      className="min-h-[calc(100vh-4rem)] flex flex-col"
    >
      {/* Hero de búsqueda (debajo del header) */}
      <section className="py-8">
        <div className="max-w-4xl mx-auto px-4 sm:px-6">
          {/* Si quieres, puedes mostrar un encabezado reutilizando AuthHeader */}
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

      {/* Featured Jobs (idéntico a tu diseño) */}
      <section id="empleos" className="py-20 bg-slate-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <h2 className="text-3xl sm:text-4xl font-bold text-slate-900 mb-4">
              Ofertas Destacadas
            </h2>
            <p className="text-lg text-slate-600">
              Explora las oportunidades más recientes y relevantes
            </p>
          </div>

          <FeaturedJobs jobs={featuredJobs} />

          <div className="text-center mt-12">
            <button
              type="button"
              onClick={s.goAllJobs}
              className="px-8 py-4 bg-slate-900 hover:bg-slate-800 text-white rounded-xl font-semibold transition-colors shadow-lg hover:shadow-xl"
            >
              Ver Todas las Ofertas
            </button>
          </div>
        </div>
      </section>
    </section>
  );
}
