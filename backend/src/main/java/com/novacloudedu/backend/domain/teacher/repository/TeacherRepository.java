package com.novacloudedu.backend.domain.teacher.repository;

import com.novacloudedu.backend.domain.teacher.entity.Teacher;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface TeacherRepository {

    Teacher save(Teacher teacher);

    Optional<Teacher> findById(TeacherId id);

    Optional<Teacher> findByUserId(UserId userId);

    List<Teacher> findAll(int page, int size);

    long count();

    void deleteById(TeacherId id);
}
