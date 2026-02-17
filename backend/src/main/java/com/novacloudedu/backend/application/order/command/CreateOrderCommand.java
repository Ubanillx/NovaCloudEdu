package com.novacloudedu.backend.application.order.command;

import com.novacloudedu.backend.application.membership.service.MembershipApplicationService;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.course.valueobject.CourseType;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.order.valueobject.OrderStatus;
import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.email.AdminEmailNotifier;
import com.novacloudedu.backend.infrastructure.email.UserEmailNotifier;
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
    private final MembershipApplicationService membershipApplicationService;
    private final UserRepository userRepository;
    private final AdminEmailNotifier adminEmailNotifier;
    private final UserEmailNotifier userEmailNotifier;

    @Transactional
    public String execute(UserId userId, Long courseId) {
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        if (!course.canBeEnrolled()) {
            throw new BusinessException(40320, "课程未发布，无法购买");
        }

        // 查找该用户该课程的最新订单（不限状态）
        var latestOrder = userCourseRepository.findLatestByUserIdAndCourseId(userId, CourseId.of(courseId));
        if (latestOrder.isPresent()) {
            UserCourse existing = latestOrder.get();
            // 已有有效的已支付订单 → 不可重复购买
            if (existing.isValid()) {
                throw new BusinessException(40321, "您已购买该课程");
            }
            // 已有未支付订单 → 直接返回已有订单号，避免重复创建
            if (existing.getStatus() == OrderStatus.UNPAID) {
                return existing.getOrderNo();
            }
        }

        String orderNo = generateOrderNo();
        UserCourse userCourse = UserCourse.create(userId, CourseId.of(courseId), orderNo, course.getPrice());
        userCourseRepository.save(userCourse);

        // 免费课程自动完成支付
        if (course.getCourseType() == CourseType.FREE) {
            userCourse.confirmPayment(PaymentMethod.MANUAL, null);
            userCourseRepository.save(userCourse);
            course.incrementStudentCount();
            courseRepository.save(course);
        }
        // 会员课：有效会员自动免费开通
        else if (course.getCourseType() == CourseType.MEMBER
                && membershipApplicationService.hasCourseMemberAccess(userId.value())) {
            userCourse.confirmPayment(PaymentMethod.MANUAL, null);
            userCourseRepository.save(userCourse);
            course.incrementStudentCount();
            courseRepository.save(course);
        }

        // 邮件通知
        String userName = userRepository.findById(userId)
                .map(User::getUserName).orElse("未知用户");
        adminEmailNotifier.notifyNewCourseOrder(orderNo, course.getTitle(),
                course.getPrice().toPlainString(), userName);
        userEmailNotifier.notifyOrderCreated(userId.value(), orderNo,
                course.getTitle(), course.getPrice().toPlainString());

        return orderNo;
    }

    private String generateOrderNo() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String timestamp = LocalDateTime.now().format(formatter);
        int random = new Random().nextInt(10000);
        return "ORDER" + timestamp + String.format("%04d", random);
    }
}
