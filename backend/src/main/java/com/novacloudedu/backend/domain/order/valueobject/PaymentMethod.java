package com.novacloudedu.backend.domain.order.valueobject;

import lombok.Getter;

@Getter
public enum PaymentMethod {

    MANUAL(0, "手动确认"),
    ALIPAY(1, "支付宝"),
    WECHAT(2, "微信支付"),
    UNION_PAY(3, "银联支付");

    private final Integer code;
    private final String description;

    PaymentMethod(Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    public static PaymentMethod fromCode(Integer code) {
        for (PaymentMethod method : values()) {
            if (method.code.equals(code)) {
                return method;
            }
        }
        throw new IllegalArgumentException("未知的支付方式: " + code);
    }
}
