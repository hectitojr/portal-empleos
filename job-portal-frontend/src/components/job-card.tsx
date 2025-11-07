import type { JobOffer } from '@/lib/types';
import Link from 'next/link';

export function JobCard({ job }: { job: JobOffer }) {
  return (
    <div className="rounded-xl border p-4">
      <Link href={`/jobs/${job.id}`} className="block">
        <h2 className="font-medium">{job.title}</h2>
        <p className="text-sm text-muted-foreground">{job.company.legalName}</p>
      </Link>
    </div>
  );
}
