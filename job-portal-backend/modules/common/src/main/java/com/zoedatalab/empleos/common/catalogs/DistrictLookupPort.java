package com.zoedatalab.empleos.common.catalogs;

import java.util.UUID;

public interface DistrictLookupPort {
    boolean existsById(UUID districtId);
}
