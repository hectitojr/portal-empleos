export type Job = {
  id: string;             
  title: string;
  company: string;          
  location?: string;       
  salary?: string | null;    
  employmentType?: string;   
  workMode?: string;        
  viewed: boolean;         
  quickApply: string;      
  isActive: boolean;      
  isApplied: boolean;      
  postedAt: string;    
};