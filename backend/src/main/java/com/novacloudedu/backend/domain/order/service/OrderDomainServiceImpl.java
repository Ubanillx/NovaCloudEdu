package com.novacloudedu.backend.domain.order.service;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;
import java.util.Random;

/**
 * 订单领域服务实现
 */
@Component
public class OrderDomainServiceImpl implements OrderDomainService {

    @Override
    public String generateOrderNo() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String timestamp = LocalDateTime.now().format(formatter);
        int random = new Random().nextInt(10000);
        return "ORDER" + timestamp + String.format("%04d", random);
    }

    @Override
    public Optional<String> checkDuplicateOrder(UserId userId, CourseId courseId,
                                                 UserCourseRepository repository) {
        var latestOrder = repository.findLatestByUserIdAndCourseId(userId, courseId);
        if (latestOrder.isPresent()) {
            UserCourse existing = latestOrder.get();
            if (existing.isValid()) {
                throw new IllegalStateException("您已购买该课程");
            }
            if (existing.isUnpaid()) {
                return Optional.of(existing.getOrderNo());
            }
        }
        return Optional.empty();
    }

    @Override
    public boolean shouldAutoConfirmPayment(Course course, UserId userId,
                                             MembershipChecker membershipChecker) {
        if (course.getCourseType() == CourseType.FREE) {
            return true;
        }
        return course.getCourseType() == CourseType.MEMBER
                && membershipChecker.hasCourseMemberAccess(userId.value());
    }
}
