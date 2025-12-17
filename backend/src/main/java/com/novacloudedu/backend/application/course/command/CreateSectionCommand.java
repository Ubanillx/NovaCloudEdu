package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.repository.CourseChapterRepository;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CreateSectionCommand {

    private final CourseSectionRepository sectionRepository;
    private final CourseChapterRepository chapterRepository;

    @Transactional
    public Long execute(Long courseId, Long chapterId, String title, String description,
                       String videoUrl, Integer duration, Integer sort, Boolean isFree,
                       String resourceUrl, UserId adminId) {
        
        chapterRepository.findById(ChapterId.of(chapterId))
                .orElseThrow(() -> new BusinessException(40400, "章节不存在"));

        CourseSection section = CourseSection.create(
                CourseId.of(courseId), ChapterId.of(chapterId), title, description,
                videoUrl, duration, sort, isFree, resourceUrl, adminId
        );

        sectionRepository.save(section);
        return section.getId().value();
    }
}
