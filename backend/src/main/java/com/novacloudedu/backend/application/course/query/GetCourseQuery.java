package com.novacloudedu.backend.application.course.query;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseStatus;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetCourseQuery {

    private final CourseRepository courseRepository;

    public Optional<Course> execute(Long courseId) {
        return courseRepository.findById(CourseId.of(courseId));
    }

    public List<Course> executeByTeacherId(Long teacherId, int page, int size) {
        return courseRepository.findByTeacherId(TeacherId.of(teacherId), page, size);
    }

    public List<Course> executeByStatus(CourseStatus status, int page, int size) {
        return courseRepository.findByStatus(status, page, size);
    }

    public List<Course> executeList(int page, int size) {
        return courseRepository.findAll(page, size);
    }

    public List<Course> searchByKeyword(String keyword, int page, int size) {
        return courseRepository.searchByKeyword(keyword, page, size);
    }

    public long count() {
        return courseRepository.count();
    }

    public long countByStatus(CourseStatus status) {
        return courseRepository.countByStatus(status);
    }
}
