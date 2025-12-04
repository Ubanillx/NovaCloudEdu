package com.novacloudedu.backend.domain.user.valueobject;

import com.novacloudedu.backend.domain.user.entity.User;

import java.util.Objects;

/**
 * 密码值对象
 * 封装密码的业务规则和加密逻辑
 */
public record Password(String encodedValue) {

    private static final int MIN_LENGTH = 6;
    private static final int MAX_LENGTH = 20;
    private static final String SALT = "nova_cloud_edu";

    public Password {
        Objects.requireNonNull(encodedValue, "密码不能为空");
    }

    /**
     * 校验原始密码格式
     */
    public static void validateRaw(String rawPassword) {
        if (rawPassword == null || rawPassword.isBlank()) {
            throw new IllegalArgumentException("密码不能为空");
        }
        if (rawPassword.length() < MIN_LENGTH || rawPassword.length() > MAX_LENGTH) {
            throw new IllegalArgumentException("密码长度为" + MIN_LENGTH + "-" + MAX_LENGTH + "个字符");
        }
    }

    /**
     * 校验两次密码是否一致
     */
    public static void validateConfirm(String password, String confirmPassword) {
        if (!Objects.equals(password, confirmPassword)) {
            throw new IllegalArgumentException("两次输入的密码不一致");
        }
    }

    /**
     * 从原始密码创建（加密）
     */
    public static Password fromRaw(String rawPassword, Encoder encoder) {
        validateRaw(rawPassword);
        String encoded = encoder.encode(SALT + rawPassword);
        return new Password(encoded);
    }

    /**
     * 从已加密密码重建
     */
    public static Password fromEncoded(String encodedValue) {
        return new Password(encodedValue);
    }

    /**
     * 验证密码是否匹配
     */
    public boolean matches(String rawPassword, User.PasswordEncoder encoder) {
        return encoder.matches(SALT + rawPassword, encodedValue);
    }

    /**
     * 密码编码器接口
     */
    public interface Encoder {
        String encode(String rawPassword);
    }

    @Override
    public String toString() {
        return "******";
    }
}
