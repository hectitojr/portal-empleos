'use client';
import { User, Building2, CheckCircle } from 'lucide-react';

export default function RoleSelect({ onPick }: { onPick: (role: 'APPLICANT' | 'COMPANY') => void }) {
  const baseCard =
    'w-full bg-white rounded-2xl shadow-lg hover:shadow-2xl transition-all px-6 sm:px-8 lg:px-12 py-8 lg:py-10 text-left border border-slate-200 group flex flex-col focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500';

  const bullet = 'flex items-start';
  const iconBadge = 'w-14 h-14 sm:w-16 sm:h-16 rounded-2xl flex items-center justify-center mb-5 sm:mb-6 group-hover:scale-110 transition-transform';

  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 gap-5 sm:gap-6 lg:gap-8">
      {/* APPLICANT */}
      <button
        type="button"
        onClick={() => onPick('APPLICANT')}
        className={`${baseCard} hover:border-blue-500`}
        aria-label="Registrarme como postulante"
      >
        <div className={`${iconBadge} bg-gradient-to-br from-blue-500 to-blue-700`}>
          <User className="w-7 h-7 sm:w-8 sm:h-8 text-white" aria-hidden="true" />
        </div>
        <h3 className="text-xl sm:text-2xl font-bold text-slate-900 mb-2">Busco Empleo</h3>
        <p className="text-slate-600 mb-6 leading-relaxed">
          Crea tu perfil profesional, busca ofertas y postula a las mejores oportunidades laborales.
        </p>
        <ul className="space-y-3 text-sm text-slate-600 mt-auto">
          <li className={bullet}><CheckCircle className="w-5 h-5 text-green-500 mr-2" aria-hidden="true" /> Crea tu CV digital completo</li>
          <li className={bullet}><CheckCircle className="w-5 h-5 text-green-500 mr-2" aria-hidden="true" /> Postula a miles de ofertas</li>
          <li className={bullet}><CheckCircle className="w-5 h-5 text-green-500 mr-2" aria-hidden="true" /> Recibe notificaciones de nuevas oportunidades</li>
        </ul>
      </button>

      {/* COMPANY */}
      <button
        type="button"
        onClick={() => onPick('COMPANY')}
        className={`${baseCard} hover:border-purple-500`}
        aria-label="Registrarme como empresa"
      >
        <div className={`${iconBadge} bg-gradient-to-br from-purple-500 to-purple-700`}>
          <Building2 className="w-7 h-7 sm:w-8 sm:h-8 text-white" aria-hidden="true" />
        </div>
        <h3 className="text-xl sm:text-2xl font-bold text-slate-900 mb-2">Soy Empresa</h3>
        <p className="text-slate-600 mb-6 leading-relaxed">
          Publica ofertas laborales, gestiona postulaciones y encuentra talento ideal para tu empresa.
        </p>
        <ul className="space-y-3 text-sm text-slate-600 mt-auto">
          <li className={bullet}><CheckCircle className="w-5 h-5 text-green-500 mr-2" aria-hidden="true" /> Publica ofertas de empleo</li>
          <li className={bullet}><CheckCircle className="w-5 h-5 text-green-500 mr-2" aria-hidden="true" /> Gestiona postulaciones en un solo lugar</li>
          <li className={bullet}><CheckCircle className="w-5 h-5 text-green-500 mr-2" aria-hidden="true" /> Accede a perfiles verificados</li>
        </ul>
      </button>
    </div>
  );
}
