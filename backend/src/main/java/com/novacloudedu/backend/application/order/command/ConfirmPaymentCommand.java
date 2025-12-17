package com.novacloudedu.backend.application.order.command;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class ConfirmPaymentCommand {

    private final UserCourseRepository userCourseRepository;
    private final CourseRepository courseRepository;

    @Transactional
    public void execute(String orderNo, PaymentMethod paymentMethod, Integer validityDays) {
        UserCourse userCourse = userCourseRepository.findByOrderNo(orderNo)
                .orElseThrow(() -> new BusinessException(40400, "订单不存在"));

        LocalDateTime expireTime = validityDays != null && validityDays > 0 
                ? LocalDateTime.now().plusDays(validityDays) 
                : null;

        userCourse.confirmPayment(paymentMethod, expireTime);
        userCourseRepository.save(userCourse);

        Course course = courseRepository.findById(userCourse.getCourseId())
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));
        course.incrementStudentCount();
        courseRepository.save(course);
    }
}
