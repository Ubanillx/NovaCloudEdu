package com.novacloudedu.backend.common;

import lombok.Getter;

/**
 * 错误码枚举
 */
@Getter
public enum ErrorCode {

    SUCCESS(0, "ok"),
    PARAMS_ERROR(40000, "请求参数错误"),
    NOT_LOGIN_ERROR(40100, "未登录"),
    NO_AUTH_ERROR(40101, "无权限"),
    ACCOUNT_BANNED(40102, "账号已被封禁"),
    NOT_FOUND_ERROR(40400, "请求数据不存在"),
    FORBIDDEN_ERROR(40300, "禁止访问"),
    SYSTEM_ERROR(50000, "系统内部异常"),
    OPERATION_ERROR(50001, "操作失败"),
    
    // 用户相关错误码
    USER_ACCOUNT_EXIST(40200, "账号已存在"),
    USER_PASSWORD_ERROR(40201, "密码错误"),
    USER_NOT_EXIST(40202, "用户不存在"),

    // 好友相关错误码
    FRIEND_REQUEST_EXIST(40310, "已有待处理的好友申请"),
    FRIEND_REQUEST_NOT_FOUND(40311, "好友申请不存在"),
    FRIEND_REQUEST_HANDLED(40312, "该申请已被处理"),
    ALREADY_FRIENDS(40313, "已经是好友关系"),
    FRIEND_NOT_FOUND(40314, "好友关系不存在"),
    CANNOT_ADD_SELF(40315, "不能添加自己为好友");

    /**
     * 状态码
     */
    private final int code;

    /**
     * 信息
     */
    private final String message;

    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
}
