package com.novacloudedu.backend.application.course.query;

import com.novacloudedu.backend.domain.course.entity.CourseSection;
import com.novacloudedu.backend.domain.course.repository.CourseSectionRepository;
import com.novacloudedu.backend.domain.course.valueobject.ChapterId;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.SectionId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetSectionQuery {

    private final CourseSectionRepository sectionRepository;

    public Optional<CourseSection> execute(Long sectionId) {
        return sectionRepository.findById(SectionId.of(sectionId));
    }

    public List<CourseSection> executeByChapterId(Long chapterId) {
        return sectionRepository.findByChapterId(ChapterId.of(chapterId));
    }

    public List<CourseSection> executeByCourseId(Long courseId) {
        return sectionRepository.findByCourseId(CourseId.of(courseId));
    }
}
