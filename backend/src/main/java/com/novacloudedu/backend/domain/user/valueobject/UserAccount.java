package com.novacloudedu.backend.domain.user.valueobject;

import java.util.Objects;
import java.util.regex.Pattern;

/**
 * 用户账号值对象
 * 封装账号的业务规则
 */
public record UserAccount(String value) {

    private static final Pattern ACCOUNT_PATTERN = Pattern.compile("^[a-zA-Z0-9_]+$");
    private static final int MIN_LENGTH = 4;
    private static final int MAX_LENGTH = 20;

    public UserAccount {
        Objects.requireNonNull(value, "账号不能为空");
        validate(value);
    }

    private static void validate(String value) {
        if (value.isBlank()) {
            throw new IllegalArgumentException("账号不能为空");
        }
        if (value.length() < MIN_LENGTH || value.length() > MAX_LENGTH) {
            throw new IllegalArgumentException("账号长度为" + MIN_LENGTH + "-" + MAX_LENGTH + "个字符");
        }
        if (!ACCOUNT_PATTERN.matcher(value).matches()) {
            throw new IllegalArgumentException("账号只能包含字母、数字、下划线");
        }
    }

    public static UserAccount of(String value) {
        return new UserAccount(value);
    }

    @Override
    public String toString() {
        return value;
    }
}
