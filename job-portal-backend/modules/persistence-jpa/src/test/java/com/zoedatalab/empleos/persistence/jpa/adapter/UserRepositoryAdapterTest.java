package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.iam.domain.User;
import com.zoedatalab.empleos.persistence.jpa.iam.adapter.UserRepositoryAdapter;
import com.zoedatalab.empleos.persistence.jpa.iam.entity.UserEntity;
import com.zoedatalab.empleos.persistence.jpa.iam.mapper.UserJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.iam.repository.JpaUserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InOrder;

import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.inOrder;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

class UserRepositoryAdapterTest {

    private JpaUserRepository repo;
    private UserJpaMapper mapper;
    private UserRepositoryAdapter sut;

    @BeforeEach
    void setUp() {
        repo = mock(JpaUserRepository.class);
        mapper = mock(UserJpaMapper.class);
        sut = new UserRepositoryAdapter(repo, mapper);
    }

    @Test
    void findByEmail_delegates_and_maps() {
        String email = "a@a.com";

        UserEntity entity = mock(UserEntity.class);
        User domain = mock(User.class);

        when(repo.findByEmail(email)).thenReturn(Optional.of(entity));
        when(mapper.toDomain(entity)).thenReturn(domain);

        Optional<User> out = sut.findByEmail(email);

        assertTrue(out.isPresent());
        assertSame(domain, out.get());

        verify(repo).findByEmail(email);
        verify(mapper).toDomain(entity);
        verifyNoMoreInteractions(repo, mapper);
    }

    @Test
    void findById_delegates_and_maps() {
        UUID id = UUID.randomUUID();

        UserEntity entity = mock(UserEntity.class);
        User domain = mock(User.class);

        when(repo.findById(id)).thenReturn(Optional.of(entity));
        when(mapper.toDomain(entity)).thenReturn(domain);

        Optional<User> out = sut.findById(id);

        assertTrue(out.isPresent());
        assertSame(domain, out.get());

        verify(repo).findById(id);
        verify(mapper).toDomain(entity);
        verifyNoMoreInteractions(repo, mapper);
    }

    @Test
    void save_maps_persists_and_maps_back() {
        User user = mock(User.class);

        UserEntity entity = mock(UserEntity.class);
        UserEntity savedEntity = mock(UserEntity.class);
        User savedDomain = mock(User.class);

        when(mapper.toEntity(user)).thenReturn(entity);
        when(repo.save(entity)).thenReturn(savedEntity);
        when(mapper.toDomain(savedEntity)).thenReturn(savedDomain);

        User out = sut.save(user);

        assertSame(savedDomain, out);

        InOrder inOrder = inOrder(mapper, repo);
        inOrder.verify(mapper).toEntity(user);
        inOrder.verify(repo).save(entity);
        inOrder.verify(mapper).toDomain(savedEntity);

        verifyNoMoreInteractions(repo, mapper);
    }
}
