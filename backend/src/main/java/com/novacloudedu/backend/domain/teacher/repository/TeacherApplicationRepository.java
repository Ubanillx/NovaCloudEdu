package com.novacloudedu.backend.domain.teacher.repository;

import com.novacloudedu.backend.domain.teacher.entity.TeacherApplication;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface TeacherApplicationRepository {

    TeacherApplication save(TeacherApplication application);

    Optional<TeacherApplication> findById(Long id);

    Optional<TeacherApplication> findByUserId(UserId userId);

    List<TeacherApplication> findByStatus(TeacherStatus status, int page, int size);

    List<TeacherApplication> findAll(int page, int size);

    long countByStatus(TeacherStatus status);

    boolean existsPendingByUserId(UserId userId);
}
