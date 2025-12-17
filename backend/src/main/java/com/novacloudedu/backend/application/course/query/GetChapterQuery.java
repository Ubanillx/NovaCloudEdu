package com.novacloudedu.backend.application.course.query;

import com.novacloudedu.backend.domain.course.entity.CourseChapter;
import com.novacloudedu.backend.domain.course.repository.CourseChapterRepository;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetChapterQuery {

    private final CourseChapterRepository chapterRepository;

    public Optional<CourseChapter> execute(Long chapterId) {
        return chapterRepository.findById(ChapterId.of(chapterId));
    }

    public List<CourseChapter> executeByCourseId(Long courseId) {
        return chapterRepository.findByCourseId(CourseId.of(courseId));
    }
}
