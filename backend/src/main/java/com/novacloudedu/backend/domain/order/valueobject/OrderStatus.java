package com.novacloudedu.backend.domain.order.valueobject;

import lombok.Getter;

@Getter
public enum OrderStatus {

    UNPAID(0, "未支付"),
    PAID(1, "已支付"),
    EXPIRED(2, "已过期"),
    REFUNDED(3, "已退款");

    private final Integer code;
    private final String description;

    OrderStatus(Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    public static OrderStatus fromCode(Integer code) {
        for (OrderStatus status : values()) {
            if (status.code.equals(code)) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的订单状态: " + code);
    }
}
