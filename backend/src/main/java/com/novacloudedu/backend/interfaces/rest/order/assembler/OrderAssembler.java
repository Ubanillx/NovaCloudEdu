package com.novacloudedu.backend.interfaces.rest.order.assembler;

import com.novacloudedu.backend.domain.order.entity.UserCourse;
import com.novacloudedu.backend.interfaces.rest.order.dto.OrderResponse;
import org.springframework.stereotype.Component;

@Component
public class OrderAssembler {

    public OrderResponse toOrderResponse(UserCourse userCourse) {
        return OrderResponse.builder()
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
}
