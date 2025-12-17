package com.novacloudedu.backend.domain.progress.repository;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import com.novacloudedu.backend.domain.progress.entity.UserCourseProgress;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface UserCourseProgressRepository {

    UserCourseProgress save(UserCourseProgress progress);

    Optional<UserCourseProgress> findById(Long id);

    Optional<UserCourseProgress> findByUserIdAndSectionId(UserId userId, SectionId sectionId);

    List<UserCourseProgress> findByUserIdAndCourseId(UserId userId, CourseId courseId);

    List<UserCourseProgress> findByCourseId(CourseId courseId, int page, int size);

    long countCompletedSectionsByUserIdAndCourseId(UserId userId, CourseId courseId);

    long countTotalSectionsByCourseId(CourseId courseId);

    int calculateCourseProgress(UserId userId, CourseId courseId);

    void deleteById(Long id);
}
