'use client';

import { Search, MapPin } from 'lucide-react';

type Props = {
  searchQuery: string;
  location: string;
  onChangeQuery: (v: string) => void;
  onChangeLocation: (v: string) => void;
  onSubmit: () => void;
};

export default function SearchBar({
  searchQuery,
  location,
  onChangeQuery,
  onChangeLocation,
  onSubmit,
}: Props) {
  function handleKey(e: React.KeyboardEvent<HTMLInputElement>) {
    if (e.key === 'Enter') onSubmit();
  }

  return (
    <div className="flex flex-col gap-3">
      {/* 1) Caja de búsqueda por título/keywords (h:50px) */}
      <div
        className="w-full bg-white flex items-center px-4 h-[50px] border border-slate-300 rounded-lg transition-shadow focus-within:ring-2 focus-within:ring-blue-500 focus-within:border-blue-500"
      >
        <Search className="w-5 h-5 mr-3 text-[#767676]" aria-hidden="true" />
        <input
          type="text"
          placeholder="Título del empleo, palabras clave..."
          value={searchQuery}
          onChange={(e) => onChangeQuery(e.target.value)}
          onKeyDown={handleKey}
          className="w-full text-sm focus:outline-none text-[#2d2d2d]"
          aria-label="Buscar por título o palabras clave"
        />
      </div>

      {/* 2) Ubicación (70%) + Botón (30%) (h:50px) */}
      <div className="w-full flex h-[50px]">
        <div
          className="flex-1 bg-white flex items-center px-4 border border-slate-300 rounded-l-lg border-r-0 transition-shadow focus-within:ring-2 focus-within:ring-blue-500 focus-within:border-blue-500"
        >
          <MapPin className="w-5 h-5 mr-3 text-[#767676]" aria-hidden="true" />
          <input
            type="text"
            placeholder="Lima"
            value={location}
            onChange={(e) => onChangeLocation(e.target.value)}
            onKeyDown={handleKey}
            className="w-full text-sm focus:outline-none text-[#2d2d2d]"
            aria-label="Ubicación"
          />
        </div>

        <button
          type="button"
          onClick={onSubmit}
          className="px-6 min-w-[30%] bg-[#2557a7] hover:bg-[#1a4a8a] text-white font-semibold text-sm transition-all rounded-r-lg"
          aria-label="Buscar empleos"
        >
          Buscar empleos
        </button>
      </div>
    </div>
  );
}
