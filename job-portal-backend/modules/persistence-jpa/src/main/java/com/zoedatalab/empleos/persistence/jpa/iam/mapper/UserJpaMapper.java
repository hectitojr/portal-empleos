package com.zoedatalab.empleos.persistence.jpa.iam.mapper;

import com.zoedatalab.empleos.iam.domain.User;
import com.zoedatalab.empleos.persistence.jpa.iam.entity.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserJpaMapper {

    @Mapping(target = "id", source = "id")
    @Mapping(target = "email", source = "email")
    @Mapping(target = "passwordHash", source = "passwordHash")
    @Mapping(target = "role", source = "role")
    @Mapping(target = "active", source = "active")
    @Mapping(target = "suspended", source = "suspended")
    @Mapping(target = "createdAt", source = "createdAt")
    @Mapping(target = "updatedAt", source = "updatedAt")
    @Mapping(target = "createdBy", source = "createdBy")
    @Mapping(target = "updatedBy", source = "updatedBy")
    @Mapping(target = "termsAcceptedAt", source = "termsAcceptedAt")
    @Mapping(target = "privacyAcceptedAt", source = "privacyAcceptedAt")
    UserEntity toEntity(User domain);

    @Mapping(target = "id", source = "id")
    @Mapping(target = "email", source = "email")
    @Mapping(target = "passwordHash", source = "passwordHash")
    @Mapping(target = "role", source = "role")
    @Mapping(target = "active", source = "active")
    @Mapping(target = "suspended", source = "suspended")
    @Mapping(target = "createdAt", source = "createdAt")
    @Mapping(target = "updatedAt", source = "updatedAt")
    @Mapping(target = "createdBy", source = "createdBy")
    @Mapping(target = "updatedBy", source = "updatedBy")
    @Mapping(target = "termsAcceptedAt", source = "termsAcceptedAt")
    @Mapping(target = "privacyAcceptedAt", source = "privacyAcceptedAt")
    User toDomain(UserEntity entity);
}
