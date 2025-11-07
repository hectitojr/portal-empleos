'use client';

import JobCard from './JobCard';
import type { Job } from '../lib/types';

export default function FeaturedJobs({ jobs }: { jobs: Job[] }) {
  return (
    <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
      {jobs.map((job) => (
        <JobCard key={job.id} job={job} />
      ))}
    </div>
  );
}
