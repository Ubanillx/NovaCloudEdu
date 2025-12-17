package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseDifficulty;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UpdateCourseCommand {

    private final CourseRepository courseRepository;

    @Transactional
    public void execute(Long courseId, String title, String subtitle, String description,
                       String coverImage, BigDecimal price, CourseType courseType,
                       CourseDifficulty difficulty, List<String> tags) {
        
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        course.updateBasicInfo(title, subtitle, description, coverImage, price,
                courseType, difficulty, tags);
        
        courseRepository.save(course);
    }
}
