package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * 用户修改密码请求
 */
public record ChangePasswordRequest(
        @NotBlank(message = "旧密码不能为空")
        String oldPassword,

        @NotBlank(message = "新密码不能为空")
        @Size(min = 6, max = 20, message = "密码长度为6-20个字符")
        String newPassword,

        @NotBlank(message = "确认密码不能为空")
        String confirmPassword
) {
}
