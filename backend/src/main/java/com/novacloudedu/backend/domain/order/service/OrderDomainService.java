package com.novacloudedu.backend.domain.order.service;

import com.novacloudedu.backend.domain.course.entity.Course;
import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.order.repository.UserCourseRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.Optional;

/**
 * 订单领域服务
 * 封装跨实体的订单业务规则
 */
public interface OrderDomainService {

    /**
     * 生成订单号（领域规则）
     */
    String generateOrderNo();

    /**
     * 检查重复下单
     * @return 已存在的未支付订单号，如果没有返回 empty
     * @throws IllegalStateException 如果用户已购买该课程
     */
    Optional<String> checkDuplicateOrder(UserId userId, CourseId courseId,
                                         UserCourseRepository repository);

    /**
     * 判断课程是否应自动完成支付（免费课/会员课）
     */
    boolean shouldAutoConfirmPayment(Course course, UserId userId,
                                     MembershipChecker membershipChecker);

    /**
     * 会员权限检查接口（依赖倒置：领域层定义，应用层/基础设施层实现）
     */
    interface MembershipChecker {
        boolean hasCourseMemberAccess(Long userId);
    }
}
