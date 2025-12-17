package com.novacloudedu.backend.domain.course.repository;

import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;

import java.util.List;
import java.util.Optional;

public interface CourseSectionRepository {

    CourseSection save(CourseSection section);

    Optional<CourseSection> findById(SectionId id);

    List<CourseSection> findByChapterId(ChapterId chapterId);

    List<CourseSection> findByCourseId(CourseId courseId);

    long countByChapterId(ChapterId chapterId);

    long countByCourseId(CourseId courseId);

    int sumDurationByCourseId(CourseId courseId);

    void deleteById(SectionId id);

    void deleteByChapterId(ChapterId chapterId);
}
