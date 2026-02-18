package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.application.membership.service.MembershipApplicationService;
import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.repository.CourseRepository;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.order.service.OrderDomainService;
import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.domain.payment.service.PaymentGateway;
import com.novacloudedu.backend.domain.payment.valueobject.RefundResult;
import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.repository.UserRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.email.AdminEmailNotifier;
import com.novacloudedu.backend.infrastructure.email.UserEmailNotifier;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;

/**
 * 订单应用服务
 * 负责订单创建、支付确认、退款等用例编排
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class OrderApplicationService {

    private final UserCourseRepository userCourseRepository;
    private final CourseRepository courseRepository;
    private final OrderDomainService orderDomainService;
    private final MembershipApplicationService membershipApplicationService;
    private final UserRepository userRepository;
    private final PaymentGateway paymentGateway;
    private final AdminEmailNotifier adminEmailNotifier;
    private final UserEmailNotifier userEmailNotifier;

    @Transactional
    public String createOrder(UserId userId, Long courseId) {
        Course course = courseRepository.findById(CourseId.of(courseId))
                .orElseThrow(() -> new BusinessException(40400, "课程不存在"));

        if (!course.canBeEnrolled()) {
            throw new BusinessException(40320, "课程未发布，无法购买");
        }

        // 领域服务：检查重复下单
        try {
            Optional<String> existingOrderNo = orderDomainService.checkDuplicateOrder(
                    userId, CourseId.of(courseId), userCourseRepository);
            if (existingOrderNo.isPresent()) {
                return existingOrderNo.get();
            }
        } catch (IllegalStateException e) {
            throw new BusinessException(40321, e.getMessage());
        }

        // 领域服务：生成订单号
        String orderNo = orderDomainService.generateOrderNo();
        UserCourse userCourse = UserCourse.create(userId, CourseId.of(courseId), orderNo, course.getPrice());
        userCourseRepository.save(userCourse);

        // 领域服务：判断是否自动完成支付（免费课/会员课）
        if (orderDomainService.shouldAutoConfirmPayment(course, userId,
                membershipApplicationService::hasCourseMemberAccess)) {
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

        log.info("订单创建成功: orderNo={}, userId={}, courseId={}", orderNo, userId.value(), courseId);
        return orderNo;
    }

    @Transactional
    public void confirmPayment(String orderNo, PaymentMethod paymentMethod, Integer validityDays) {
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

        // 邮件通知
        adminEmailNotifier.notifyPaymentSuccess(orderNo, course.getTitle(), userCourse.getPrice().toPlainString());
        userEmailNotifier.notifyPaymentConfirmed(userCourse.getUserId().value(), orderNo,
                course.getTitle(), userCourse.getPrice().toPlainString());

        log.info("支付确认成功: orderNo={}", orderNo);
    }

    @Transactional
    public void refundOrder(String orderNo) {
        UserCourse userCourse = userCourseRepository.findByOrderNo(orderNo)
                .orElseThrow(() -> new BusinessException(40400, "订单不存在"));

        RefundResult result = paymentGateway.refund(orderNo, userCourse.getPrice());

        if (!result.isSuccess()) {
            throw new BusinessException(50000, "退款失败: " + result.getMessage());
        }

        userCourse.refund();
        userCourseRepository.save(userCourse);

        // 邮件通知用户
        userEmailNotifier.notifyRefundCompleted(userCourse.getUserId().value(),
                orderNo, userCourse.getPrice().toPlainString());

        log.info("订单退款成功: orderNo={}", orderNo);
    }

}
