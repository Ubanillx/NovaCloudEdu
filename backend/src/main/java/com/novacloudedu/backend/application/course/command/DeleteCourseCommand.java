package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DeleteCourseCommand {

    private final CourseRepository courseRepository;

    @Transactional
    public void execute(Long courseId) {
        courseRepository.deleteById(CourseId.of(courseId));
    }
}
