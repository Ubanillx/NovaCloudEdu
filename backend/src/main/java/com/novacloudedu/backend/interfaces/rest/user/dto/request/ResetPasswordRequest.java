package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/**
 * 管理员重置用户密码请求
 */
public record ResetPasswordRequest(
        @NotNull(message = "用户ID不能为空")
        Long userId,

        @NotBlank(message = "新密码不能为空")
        @Size(min = 6, max = 20, message = "密码长度为6-20个字符")
        String newPassword
) {
}
