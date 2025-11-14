'use client';

import { MapPin, Briefcase, Calendar, ArrowRight } from 'lucide-react';
import type { Job } from '../lib/types';

export default function JobCard({ job }: { job: Job }) {
  return (
    <article className="bg-white rounded-xl shadow-md hover:shadow-xl transition-shadow p-6 border border-slate-100">
      <div className="flex items-start justify-between mb-4">
        <div className="flex-1">
          <h3 className="text-xl font-semibold text-slate-900 mb-2 hover:text-blue-600 cursor-pointer">
            {job.title}
          </h3>
          <p className="text-slate-600 font-medium mb-1">{job.company}</p>
        </div>
        <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center text-white font-bold text-lg">
          {job.company.charAt(0)}
        </div>
      </div>

      <div className="space-y-2 mb-4">
        <div className="flex items-center text-slate-600 text-sm">
          <MapPin className="w-4 h-4 mr-2" aria-hidden="true" />
          {job.location}
        </div>
        <div className="flex items-center text-slate-600 text-sm">
          <Briefcase className="w-4 h-4 mr-2" aria-hidden="true" />
          {job.type}
        </div>
        <div className="flex items-center text-slate-600 text-sm">
          <Calendar className="w-4 h-4 mr-2" aria-hidden="true" />
          {job.posted}
        </div>
      </div>

      <div className="flex flex-wrap gap-2 mb-4">
        {job.tags.map((tag) => (
          <span
            key={tag}
            className="px-3 py-1 bg-blue-50 text-blue-700 rounded-full text-xs font-medium"
          >
            {tag}
          </span>
        ))}
      </div>

      <div className="flex items-center justify-between pt-4 border-t border-slate-100">
        <span className="text-lg font-bold text-blue-600">{job.salary}</span>
        <button
          type="button"
          className="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg text-sm font-medium transition-colors flex items-center gap-2"
        >
          Ver detalles
          <ArrowRight className="w-4 h-4" aria-hidden="true" />
        </button>
      </div>
    </article>
  );
}
