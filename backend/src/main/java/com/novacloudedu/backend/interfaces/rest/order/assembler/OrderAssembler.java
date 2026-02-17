package com.novacloudedu.backend.interfaces.rest.order.assembler;

import com.novacloudedu.backend.domain.membership.entity.MembershipPlan;
import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.interfaces.rest.order.dto.OrderResponse;
import org.springframework.stereotype.Component;

@Component
public class OrderAssembler {

    public OrderResponse toOrderResponse(UserCourse userCourse) {
        return OrderResponse.builder()
                .orderType("COURSE")
                .id(userCourse.getId())
                .userId(userCourse.getUserId().value())
                .courseId(userCourse.getCourseId().value())
                .orderNo(userCourse.getOrderNo())
                .price(userCourse.getPrice())
                .paymentMethod(userCourse.getPaymentMethod() != null ? userCourse.getPaymentMethod().getCode() : null)
                .paymentMethodDesc(userCourse.getPaymentMethod() != null ? userCourse.getPaymentMethod().getDescription() : null)
                .paymentTime(userCourse.getPaymentTime())
                .expireTime(userCourse.getExpireTime())
                .status(userCourse.getStatus().getCode())
                .statusDesc(userCourse.getStatus().getDescription())
                .isValid(userCourse.isValid())
                .createTime(userCourse.getCreateTime())
                .updateTime(userCourse.getUpdateTime())
                .build();
    }

    public OrderResponse toOrderResponse(UserMembership membership, MembershipPlan plan) {
        return OrderResponse.builder()
                .orderType("MEMBERSHIP")
                .productName(plan != null ? plan.getName() : "会员订单")
                .id(membership.getId())
                .userId(membership.getUserId().value())
                .orderNo(membership.getOrderNo())
                .price(plan != null ? plan.getPrice() : null)
                .expireTime(membership.getExpireTime())
                .status(membership.getStatus().getCode())
                .statusDesc(membership.getStatus().getDescription())
                .isValid(membership.isActive())
                .createTime(membership.getCreateTime())
                .updateTime(membership.getUpdateTime())
                .build();
    }
}
