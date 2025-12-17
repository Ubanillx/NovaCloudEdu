package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.repository.CourseChapterRepository;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CreateChapterCommand {

    private final CourseChapterRepository chapterRepository;
    private final CourseRepository courseRepository;

    @Transactional
    public Long execute(Long courseId, String title, String description, Integer sort, UserId adminId) {
        courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        CourseChapter chapter = CourseChapter.create(
                CourseId.of(courseId), title, description, sort, adminId
        );

        chapterRepository.save(chapter);
        return chapter.getId().value();
    }
}
