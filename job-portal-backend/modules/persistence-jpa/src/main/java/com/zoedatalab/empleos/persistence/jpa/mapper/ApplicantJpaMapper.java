package com.zoedatalab.empleos.persistence.jpa.mapper;

import com.zoedatalab.empleos.applicants.domain.Applicant;
import com.zoedatalab.empleos.applicants.domain.Education;
import com.zoedatalab.empleos.applicants.domain.Experience;
import com.zoedatalab.empleos.applicants.domain.Skill;
import com.zoedatalab.empleos.persistence.jpa.entity.ApplicantEducationEntity;
import com.zoedatalab.empleos.persistence.jpa.entity.ApplicantEntity;
import com.zoedatalab.empleos.persistence.jpa.entity.ApplicantExperienceEntity;
import com.zoedatalab.empleos.persistence.jpa.entity.ApplicantSkillEntity;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ApplicantJpaMapper {

    ApplicantEntity toEntity(Applicant d);
    Applicant toDomain(ApplicantEntity e);

    @Mapping(target = "applicant", ignore = true)
    ApplicantExperienceEntity toEntity(Experience d);
    Experience toDomain(ApplicantExperienceEntity e);

    @Mapping(target = "applicant", ignore = true)
    ApplicantEducationEntity toEntity(Education d);
    Education toDomain(ApplicantEducationEntity e);

    @Mapping(target = "applicant", ignore = true)
    ApplicantSkillEntity toEntity(Skill d);
    Skill toDomain(ApplicantSkillEntity e);

    @AfterMapping
    default void ensureCollectionsAndBackrefs(@MappingTarget ApplicantEntity entity) {
        if (entity.getExperiences() == null) entity.setExperiences(new java.util.ArrayList<>());
        if (entity.getEducations()  == null) entity.setEducations(new java.util.ArrayList<>());
        if (entity.getSkills()      == null) entity.setSkills(new java.util.ArrayList<>());
        entity.getExperiences().forEach(ch -> ch.setApplicant(entity));
        entity.getEducations().forEach(ch -> ch.setApplicant(entity));
        entity.getSkills().forEach(ch -> ch.setApplicant(entity));
    }
}
