package com.novacloudedu.backend.domain.course.repository;

import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;

import java.util.List;
import java.util.Optional;

public interface CourseChapterRepository {

    CourseChapter save(CourseChapter chapter);

    Optional<CourseChapter> findById(ChapterId id);

    List<CourseChapter> findByCourseId(CourseId courseId);

    long countByCourseId(CourseId courseId);

    void deleteById(ChapterId id);
}
