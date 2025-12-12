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

  const value = useMemo(() => {
    const districtsById = toMap(districtsQuery.data);
    const employmentTypesById = toMap(employmentTypesQuery.data);
    const workModesById = toMap(workModesQuery.data);

    const isLoading =
      districtsQuery.isLoading ||
      employmentTypesQuery.isLoading ||
      workModesQuery.isLoading;

    const error =
      districtsQuery.error ||
      employmentTypesQuery.error ||
      workModesQuery.error ||
      null;

    return {
      isLoading,
      error,
      districtsById,
      employmentTypesById,
      workModesById,
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
  ]);

  return value;
}
