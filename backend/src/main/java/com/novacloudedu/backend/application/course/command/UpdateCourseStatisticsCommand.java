package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseChapterRepository;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UpdateCourseStatisticsCommand {

    private final CourseRepository courseRepository;
    private final CourseChapterRepository chapterRepository;
    private final CourseSectionRepository sectionRepository;

    @Transactional
    public void execute(Long courseId) {
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        long chapterCount = chapterRepository.countByCourseId(CourseId.of(courseId));
        long sectionCount = sectionRepository.countByCourseId(CourseId.of(courseId));
        int totalDuration = sectionRepository.sumDurationByCourseId(CourseId.of(courseId));

        course.updateStatistics((int) chapterCount, (int) sectionCount, totalDuration / 60);
        courseRepository.save(course);
    }
}
