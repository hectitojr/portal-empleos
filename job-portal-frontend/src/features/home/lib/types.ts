export type Job = {
  id: string;
  title: string;
  company: string;

  location?: string | null;
  salary?: string | null;
  employmentType?: string | null;
  workMode?: string | null;

  viewed: boolean;
  quickApply: string;
  isActive: boolean;
  isApplied: boolean;

  postedAt: string;
};
