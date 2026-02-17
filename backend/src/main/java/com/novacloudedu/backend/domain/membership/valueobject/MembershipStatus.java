package com.novacloudedu.backend.domain.membership.valueobject;

import lombok.Getter;

@Getter
public enum MembershipStatus {

    PENDING(0, "待支付"),
    ACTIVE(1, "生效中"),
    EXPIRED(2, "已过期"),
    CANCELLED(3, "已取消");

    private final Integer code;
    private final String description;

    MembershipStatus(Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    public static MembershipStatus fromCode(Integer code) {
        for (MembershipStatus status : values()) {
            if (status.code.equals(code)) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的会员状态: " + code);
    }
}
