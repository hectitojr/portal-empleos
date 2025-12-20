import { useQuery } from '@tanstack/react-query';
import { getMyCompany } from '@/features/companies/api/companiesClient';

export function useCompanyMe() {
  return useQuery({
    queryKey: ['company', 'me'],
    queryFn: getMyCompany,
    staleTime: 30_000,
  });
}
