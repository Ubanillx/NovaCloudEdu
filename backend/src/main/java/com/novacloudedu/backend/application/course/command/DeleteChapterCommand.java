package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.repository.CourseChapterRepository;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DeleteChapterCommand {

    private final CourseChapterRepository chapterRepository;
    private final CourseSectionRepository sectionRepository;

    @Transactional
    public void execute(Long chapterId) {
        ChapterId id = ChapterId.of(chapterId);
        sectionRepository.deleteByChapterId(id);
        chapterRepository.deleteById(id);
    }
}
