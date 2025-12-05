package com.zoedatalab.empleos.persistence.jpa.iam.mapper;

import com.zoedatalab.empleos.iam.domain.RefreshToken;
import com.zoedatalab.empleos.persistence.jpa.iam.entity.RefreshTokenEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface RefreshTokenJpaMapper {

    @Mapping(target = "id", source = "id")
    @Mapping(target = "userId", source = "userId")
    @Mapping(target = "token", source = "token")
    @Mapping(target = "expiresAt", source = "expiresAt")
    @Mapping(target = "revoked", source = "revoked")
    @Mapping(target = "createdAt", source = "createdAt")
    RefreshTokenEntity toEntity(RefreshToken domain);

    @Mapping(target = "id", source = "id")
    @Mapping(target = "userId", source = "userId")
    @Mapping(target = "token", source = "token")
    @Mapping(target = "expiresAt", source = "expiresAt")
    @Mapping(target = "revoked", source = "revoked")
    @Mapping(target = "createdAt", source = "createdAt")
    RefreshToken toDomain(RefreshTokenEntity entity);
}
