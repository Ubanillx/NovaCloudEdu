package com.novacloudedu.backend.domain.course.repository;

import com.novacloudedu.backend.domain.course.entity.CourseReview;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface CourseReviewRepository {

    CourseReview save(CourseReview review);

    Optional<CourseReview> findById(Long id);

    Optional<CourseReview> findByUserIdAndCourseId(UserId userId, CourseId courseId);

    List<CourseReview> findByCourseId(CourseId courseId, int page, int size);

    boolean existsByUserIdAndCourseId(UserId userId, CourseId courseId);

    BigDecimal calculateAverageRating(CourseId courseId);

    long countByCourseId(CourseId courseId);

    void deleteById(Long id);
}
