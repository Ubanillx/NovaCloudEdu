package com.novacloudedu.backend.application.course.command;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseDifficulty;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;
import com.novacloudedu.backend.domain.teacher.repository.TeacherRepository;
import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CreateCourseCommand {

    private final CourseRepository courseRepository;
    private final TeacherRepository teacherRepository;

    @Transactional
    public Long execute(String title, String subtitle, String description, String coverImage,
                       BigDecimal price, CourseType courseType, CourseDifficulty difficulty,
                       Long teacherId, List<String> tags, UserId adminId) {
        
        teacherRepository.findById(TeacherId.of(teacherId))
                .orElseThrow(() -> new BusinessException(40400, "讲师不存在"));

        Course course = Course.create(
                title, subtitle, description, coverImage, price,
                courseType, difficulty, TeacherId.of(teacherId), tags, adminId
        );

        courseRepository.save(course);
        return course.getId().value();
    }
}
