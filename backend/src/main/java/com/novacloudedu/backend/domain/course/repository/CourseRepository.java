package com.novacloudedu.backend.domain.course.repository;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseStatus;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;

import java.util.List;
import java.util.Optional;

public interface CourseRepository {

    Course save(Course course);

    Optional<Course> findById(CourseId id);

    List<Course> findByTeacherId(TeacherId teacherId, int page, int size);

    List<Course> findByStatus(CourseStatus status, int page, int size);

    List<Course> findAll(int page, int size);

    List<Course> searchByKeyword(String keyword, int page, int size);

    long count();

    long countByStatus(CourseStatus status);

    void deleteById(CourseId id);
}
