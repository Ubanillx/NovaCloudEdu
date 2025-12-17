package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.course.valueobject.CourseId;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.domain.order.valueobject.OrderStatus;
import com.novacloudedu.backend.domain.order.valueobject.PaymentMethod;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.UserCoursePO;
import org.springframework.stereotype.Component;

@Component
public class UserCourseConverter {

    public UserCoursePO toUserCoursePO(UserCourse userCourse) {
        UserCoursePO po = new UserCoursePO();
        if (userCourse.getId() != null) {
            po.setId(userCourse.getId());
        }
        po.setUserId(userCourse.getUserId().value());
        po.setCourseId(userCourse.getCourseId().value());
        po.setOrderNo(userCourse.getOrderNo());
        po.setPrice(userCourse.getPrice());
        po.setPaymentMethod(userCourse.getPaymentMethod() != null ? userCourse.getPaymentMethod().getCode() : null);
        po.setPaymentTime(userCourse.getPaymentTime());
        po.setExpireTime(userCourse.getExpireTime());
        po.setStatus(userCourse.getStatus().getCode());
        po.setCreateTime(userCourse.getCreateTime());
        po.setUpdateTime(userCourse.getUpdateTime());
        return po;
    }

    public UserCourse toUserCourse(UserCoursePO po) {
        return UserCourse.reconstruct(
                po.getId(),
                UserId.of(po.getUserId()),
                CourseId.of(po.getCourseId()),
                po.getOrderNo(),
                po.getPrice(),
                po.getPaymentMethod() != null ? PaymentMethod.fromCode(po.getPaymentMethod()) : null,
                po.getPaymentTime(),
                po.getExpireTime(),
                OrderStatus.fromCode(po.getStatus()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
