package com.novacloudedu.backend.application.order.command;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class CreateOrderCommand {

    private final UserCourseRepository userCourseRepository;
    private final CourseRepository courseRepository;

    @Transactional
    public String execute(UserId userId, Long courseId) {
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        if (!course.canBeEnrolled()) {
            throw new BusinessException(40320, "课程未发布，无法购买");
        }

        if (userCourseRepository.existsByUserIdAndCourseId(userId, CourseId.of(courseId))) {
            throw new BusinessException(40321, "您已购买该课程");
        }

        String orderNo = generateOrderNo();
        UserCourse userCourse = UserCourse.create(userId, CourseId.of(courseId), orderNo, course.getPrice());
        userCourseRepository.save(userCourse);

        return orderNo;
    }

    private String generateOrderNo() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String timestamp = LocalDateTime.now().format(formatter);
        int random = new Random().nextInt(10000);
        return "ORDER" + timestamp + String.format("%04d", random);
    }
}
