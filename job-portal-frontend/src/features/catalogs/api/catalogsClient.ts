export type CatalogItem = {
  id: string;
  name: string;
  active: boolean;
};

async function fetchCatalog(path: string): Promise<CatalogItem[]> {
  const res = await fetch(`/api/catalogs/${path}`, {
    method: 'GET',
    cache: 'no-store',
  });

  if (!res.ok) {
    throw new Error(`Error al cargar catálogo ${path} (HTTP ${res.status})`);
  }

  return res.json();
}

export const catalogsClient = {
  districts: () => fetchCatalog('districts'),
  employmentTypes: () => fetchCatalog('employment-types'),
  workModes: () => fetchCatalog('work-modes'),
  disabilityTypes: () => fetchCatalog('disability-types'),
};
