package com.novacloudedu.backend.domain.social.valueobject;

/**
 * 群申请状态枚举
 */
public enum JoinRequestStatus {
    /**
     * 待审批
     */
    PENDING(0),

    /**
     * 已通过
     */
    APPROVED(1),

    /**
     * 已拒绝
     */
    REJECTED(2);

    private final int code;

    JoinRequestStatus(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static JoinRequestStatus fromCode(int code) {
        for (JoinRequestStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("Unknown JoinRequestStatus code: " + code);
    }
}
