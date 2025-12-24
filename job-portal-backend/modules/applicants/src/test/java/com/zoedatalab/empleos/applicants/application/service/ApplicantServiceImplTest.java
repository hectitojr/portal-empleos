package com.zoedatalab.empleos.applicants.application.service;

import com.zoedatalab.empleos.applicants.application.dto.ApplicantView;
import com.zoedatalab.empleos.applicants.application.dto.UpsertMyApplicantCommand;
import com.zoedatalab.empleos.applicants.application.ports.out.ApplicantRepositoryPort;
import com.zoedatalab.empleos.applicants.domain.Applicant;
import com.zoedatalab.empleos.applicants.domain.Skill;
import com.zoedatalab.empleos.applicants.domain.exception.ApplicantNotFoundException;
import com.zoedatalab.empleos.catalogs.application.ports.out.CatalogQueryPort;
import com.zoedatalab.empleos.catalogs.domain.CatalogItem;
import com.zoedatalab.empleos.common.catalogs.DistrictLookupPort;
import com.zoedatalab.empleos.common.catalogs.exception.DistrictNotFoundException;
import com.zoedatalab.empleos.common.time.ClockPort;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.lenient;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ApplicantServiceImplTest {

    final Instant FIXED_NOW = Instant.parse("2025-01-02T03:04:05Z");
    final UUID USER_ID = UUID.fromString("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee");
    final UUID DISTRICT_ID = UUID.fromString("00000000-0000-0000-0000-000000000001");

    @Mock
    ApplicantRepositoryPort repo;

    @Mock
    ClockPort clock;

    @Mock
    DistrictLookupPort districtLookup;

    @Mock
    CatalogQueryPort catalogQuery;

    @Captor
    ArgumentCaptor<Applicant> applicantCaptor;

    ApplicantServiceImpl service;

    @BeforeEach
    void setup() {
        lenient().when(catalogQuery.findActiveDisabilityTypes()).thenReturn(List.of());

        service = new ApplicantServiceImpl(repo, clock, districtLookup, catalogQuery);
    }

    @Test
    void getMyProfile_whenNotFound_shouldThrow() {
        when(repo.findByUserId(USER_ID)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> service.getMyProfile(USER_ID))
                .isInstanceOf(ApplicantNotFoundException.class);
    }

    @Test
    void getMyProfile_whenFound_shouldReturnView() {
        var domain = minimalExisting();
        when(repo.findByUserId(USER_ID)).thenReturn(Optional.of(domain));

        ApplicantView v = service.getMyProfile(USER_ID);

        assertThat(v.id()).isEqualTo(domain.getId());
        assertThat(v.fullName()).isEqualTo(domain.getFullName());
        assertThat(v.profileComplete()).isEqualTo(domain.isProfileComplete());
    }

    @Test
    void upsertMyProfile_whenDistrictDoesNotExist_shouldThrow_andNotSave() {
        when(districtLookup.existsById(DISTRICT_ID)).thenReturn(false);

        var cmd = new UpsertMyApplicantCommand(
                "John Doe",
                "john@mail.com",
                null,
                DISTRICT_ID,
                null,
                List.of(), List.of(), List.of(),
                Set.of()
        );

        assertThatThrownBy(() -> service.upsertMyProfile(USER_ID, cmd))
                .isInstanceOf(DistrictNotFoundException.class);

        verify(districtLookup).existsById(DISTRICT_ID);

        verifyNoInteractions(repo);
        verifyNoInteractions(clock);
    }

    @Test
    void upsertMyProfile_whenDistrictIsNull_shouldNotValidateDistrict() {
        when(clock.now()).thenReturn(FIXED_NOW);
        when(repo.findByUserId(USER_ID)).thenReturn(Optional.empty());
        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));

        var cmd = new UpsertMyApplicantCommand(
                "Jane",
                "jane@mail.com",
                null,
                null,
                null,
                List.of(), List.of(), List.of(),
                Set.of()
        );

        service.upsertMyProfile(USER_ID, cmd);

        verify(districtLookup, never()).existsById(any());
        verify(repo).save(any());
        verify(clock).now();
    }

    @Test
    void upsertMyProfile_whenFirstTime_createsNew_withNormalization_andProfileCompleteness() {
        when(clock.now()).thenReturn(FIXED_NOW);
        when(repo.findByUserId(USER_ID)).thenReturn(Optional.empty());
        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));
        when(districtLookup.existsById(DISTRICT_ID)).thenReturn(true);

        UUID disabilityId = UUID.fromString("00000000-0000-0000-0000-000000000099");
        when(catalogQuery.findActiveDisabilityTypes())
                .thenReturn(List.of(new CatalogItem(disabilityId, "Disability", true)));

        var cmd = new UpsertMyApplicantCommand(
                "  John Doe  ",
                "  JOHN@MAIL.com  ",
                "  999999999  ",
                DISTRICT_ID,
                "  summary  ",
                List.of(new UpsertMyApplicantCommand.ExperienceItem(
                        "  Foo Inc ", "  Dev  ",
                        LocalDate.of(2020, 1, 1), LocalDate.of(2021, 1, 1),
                        "  did things  "
                )),
                List.of(new UpsertMyApplicantCommand.EducationItem(
                        "  Uni  ", "  BSc  ",
                        LocalDate.of(2015, 1, 1), LocalDate.of(2019, 1, 1),
                        "  desc  "
                )),
                List.of(new UpsertMyApplicantCommand.SkillItem("  Java  ", "  Senior  ")),
                Set.of(disabilityId)
        );

        var view = service.upsertMyProfile(USER_ID, cmd);

        verify(repo).save(applicantCaptor.capture());
        var saved = applicantCaptor.getValue();

        assertThat(saved.getFullName()).isEqualTo("John Doe");
        assertThat(saved.getContactEmail()).isEqualTo("john@mail.com");
        assertThat(saved.getContactPhone()).isEqualTo("999999999");
        assertThat(saved.getProfileSummary()).isEqualTo("summary");
        assertThat(saved.getDistrictId()).isEqualTo(DISTRICT_ID);

        assertThat(saved.getExperiences()).hasSize(1);
        assertThat(saved.getExperiences().getFirst().getCompany()).isEqualTo("Foo Inc");
        assertThat(saved.getExperiences().getFirst().getRole()).isEqualTo("Dev");
        assertThat(saved.getExperiences().getFirst().getDescription()).isEqualTo("did things");
        assertThat(saved.getExperiences().getFirst().getId()).isNotNull();

        assertThat(saved.getEducations()).hasSize(1);
        assertThat(saved.getEducations().getFirst().getInstitution()).isEqualTo("Uni");
        assertThat(saved.getEducations().getFirst().getDegree()).isEqualTo("BSc");
        assertThat(saved.getEducations().getFirst().getDescription()).isEqualTo("desc");
        assertThat(saved.getEducations().getFirst().getId()).isNotNull();

        assertThat(saved.getSkills()).hasSize(1);
        assertThat(saved.getSkills().getFirst().getName()).isEqualTo("Java");
        assertThat(saved.getSkills().getFirst().getLevel()).isEqualTo("Senior");
        assertThat(saved.getSkills().getFirst().getId()).isNotNull();

        assertThat(saved.getDisabilityIds()).containsExactlyInAnyOrderElementsOf(cmd.disabilityIds());

        assertThat(saved.isProfileComplete()).isTrue();

        assertThat(saved.isActive()).isTrue();
        assertThat(saved.isSuspended()).isFalse();
        assertThat(saved.getCreatedAt()).isEqualTo(FIXED_NOW);
        assertThat(saved.getUpdatedAt()).isEqualTo(FIXED_NOW);
        assertThat(saved.getCreatedBy()).isEqualTo(USER_ID);
        assertThat(saved.getUpdatedBy()).isEqualTo(USER_ID);

        assertThat(view.id()).isNotNull();
        assertThat(view.fullName()).isEqualTo("John Doe");
        assertThat(view.profileComplete()).isTrue();

        verify(districtLookup).existsById(DISTRICT_ID);
        verify(catalogQuery).findActiveDisabilityTypes();
    }

    @Test
    void upsertMyProfile_whenPartialData_shouldSetProfileCompleteFalse() {
        when(clock.now()).thenReturn(FIXED_NOW);
        when(repo.findByUserId(USER_ID)).thenReturn(Optional.empty());
        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));

        var cmd = new UpsertMyApplicantCommand(
                "Jane", "jane@mail.com", null, null, null,
                List.of(), List.of(), List.of(), null
        );

        var view = service.upsertMyProfile(USER_ID, cmd);

        verify(repo).save(applicantCaptor.capture());
        var saved = applicantCaptor.getValue();
        assertThat(saved.isProfileComplete()).isFalse();
        assertThat(view.profileComplete()).isFalse();

        verify(districtLookup, never()).existsById(any());
        verify(catalogQuery, never()).findActiveDisabilityTypes();
    }

    @Test
    void upsertMyProfile_whenExists_updatesKeepingCreatedAudit_andMergesFields() {
        when(clock.now()).thenReturn(FIXED_NOW);
        var existing = minimalExisting();
        when(repo.findByUserId(USER_ID)).thenReturn(Optional.of(existing));
        when(repo.save(any())).thenAnswer(inv -> inv.getArgument(0));
        when(districtLookup.existsById(DISTRICT_ID)).thenReturn(true);

        var cmd = new UpsertMyApplicantCommand(
                "  New Name ", "  NEW@MAIL.com ", "  111 ",
                DISTRICT_ID, "  new summary ",
                List.of(),
                List.of(),
                List.of(new UpsertMyApplicantCommand.SkillItem("  Kotlin ", "  Mid ")),
                Set.of()
        );

        var view = service.upsertMyProfile(USER_ID, cmd);

        verify(repo).save(applicantCaptor.capture());
        var saved = applicantCaptor.getValue();

        assertThat(saved.getId()).isEqualTo(existing.getId());
        assertThat(saved.getUserId()).isEqualTo(existing.getUserId());
        assertThat(saved.getCreatedAt()).isEqualTo(existing.getCreatedAt());
        assertThat(saved.getCreatedBy()).isEqualTo(existing.getCreatedBy());

        assertThat(saved.getFullName()).isEqualTo("New Name");
        assertThat(saved.getContactEmail()).isEqualTo("new@mail.com");
        assertThat(saved.getContactPhone()).isEqualTo("111");
        assertThat(saved.getProfileSummary()).isEqualTo("new summary");
        assertThat(saved.getDistrictId()).isEqualTo(DISTRICT_ID);
        assertThat(saved.getSkills()).extracting(Skill::getName).containsExactly("Kotlin");

        assertThat(saved.isProfileComplete()).isFalse();
        assertThat(saved.getUpdatedAt()).isEqualTo(FIXED_NOW);
        assertThat(saved.getUpdatedBy()).isEqualTo(USER_ID);

        assertThat(view.profileComplete()).isFalse();
        assertThat(view.skills()).hasSize(1);

        verify(districtLookup).existsById(DISTRICT_ID);
        verify(catalogQuery, never()).findActiveDisabilityTypes();
    }

    // ===== helpers =====
    private Applicant minimalExisting() {
        return Applicant.builder()
                .id(UUID.fromString("11111111-2222-3333-4444-555555555555"))
                .userId(USER_ID)
                .fullName("Existing")
                .contactEmail("existing@mail.com")
                .contactPhone("000")
                .districtId(null)
                .experiences(List.of())
                .educations(List.of())
                .skills(List.of())
                .disabilityIds(Set.of())
                .profileSummary("sum")
                .profileComplete(true)
                .active(true)
                .suspended(false)
                .createdAt(Instant.parse("2024-01-01T00:00:00Z"))
                .updatedAt(Instant.parse("2024-01-02T00:00:00Z"))
                .createdBy(USER_ID)
                .updatedBy(USER_ID)
                .build();
    }
}