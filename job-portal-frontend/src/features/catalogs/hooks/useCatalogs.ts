'use client';

import { useMemo } from 'react';
import { useQuery } from '@tanstack/react-query';
import { catalogsClient, type CatalogItem } from '../api/catalogsClient';

type CatalogMap = Record<string, CatalogItem>;

function toMap(items?: CatalogItem[]): CatalogMap {
  if (!items) return {};
  return items.reduce<CatalogMap>((acc, item) => {
    acc[item.id] = item;
    return acc;
  }, {});
}

function byNameAsc(a: CatalogItem, b: CatalogItem) {
  return a.name.localeCompare(b.name, 'es', { sensitivity: 'base' });
}

export function useJobCatalogs() {
  const districtsQuery = useQuery<CatalogItem[]>({
    queryKey: ['catalogs', 'districts'],
    queryFn: catalogsClient.districts,
    staleTime: 60 * 60 * 1000,
  });

  const employmentTypesQuery = useQuery<CatalogItem[]>({
    queryKey: ['catalogs', 'employment-types'],
    queryFn: catalogsClient.employmentTypes,
    staleTime: 60 * 60 * 1000,
  });

  const workModesQuery = useQuery<CatalogItem[]>({
    queryKey: ['catalogs', 'work-modes'],
    queryFn: catalogsClient.workModes,
    staleTime: 60 * 60 * 1000,
  });

  const disabilityTypesQuery = useQuery<CatalogItem[]>({
    queryKey: ['catalogs', 'disability-types'],
    queryFn: catalogsClient.disabilityTypes,
    staleTime: 60 * 60 * 1000,
  });

  const value = useMemo(() => {
    const districts = (districtsQuery.data ?? []).slice().sort(byNameAsc);
    const employmentTypes = (employmentTypesQuery.data ?? []).slice().sort(byNameAsc);
    const workModes = (workModesQuery.data ?? []).slice().sort(byNameAsc);
    const disabilityTypes = (disabilityTypesQuery.data ?? []).slice().sort(byNameAsc);

    const districtsById = toMap(districts);
    const employmentTypesById = toMap(employmentTypes);
    const workModesById = toMap(workModes);
    const disabilityTypesById = toMap(disabilityTypes);

    const isLoading =
      districtsQuery.isLoading ||
      employmentTypesQuery.isLoading ||
      workModesQuery.isLoading ||
      disabilityTypesQuery.isLoading;

    const error =
      districtsQuery.error ||
      employmentTypesQuery.error ||
      workModesQuery.error ||
      disabilityTypesQuery.error ||
      null;

    return {
      isLoading,
      error,
      districts,
      employmentTypes,
      workModes,
      disabilityTypes,
      districtsById,
      employmentTypesById,
      workModesById,
      disabilityTypesById,
    };
  }, [
    districtsQuery.data,
    districtsQuery.isLoading,
    districtsQuery.error,
    employmentTypesQuery.data,
    employmentTypesQuery.isLoading,
    employmentTypesQuery.error,
    workModesQuery.data,
    workModesQuery.isLoading,
    workModesQuery.error,
    disabilityTypesQuery.data,
    disabilityTypesQuery.isLoading,
    disabilityTypesQuery.error,
  ]);

  return value;
}
