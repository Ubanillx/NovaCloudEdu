package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.repository.CourseChapterRepository;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UpdateChapterCommand {

    private final CourseChapterRepository chapterRepository;

    @Transactional
    public void execute(Long chapterId, String title, String description, Integer sort) {
        CourseChapter chapter = chapterRepository.findById(ChapterId.of(chapterId))
                .orElseThrow(() -> new BusinessException(40400, "章节不存在"));

        chapter.updateInfo(title, description, sort);
        chapterRepository.save(chapter);
    }
}
