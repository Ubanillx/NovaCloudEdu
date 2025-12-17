package com.novacloudedu.backend.domain.course.repository;

import com.novacloudedu.backend.domain.course.entity.CourseFavourite;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface CourseFavouriteRepository {

    CourseFavourite save(CourseFavourite favourite);

    Optional<CourseFavourite> findByUserIdAndCourseId(UserId userId, CourseId courseId);

    List<CourseFavourite> findByUserId(UserId userId, int page, int size);

    boolean existsByUserIdAndCourseId(UserId userId, CourseId courseId);

    void deleteByUserIdAndCourseId(UserId userId, CourseId courseId);

    long countByCourseId(CourseId courseId);
}
