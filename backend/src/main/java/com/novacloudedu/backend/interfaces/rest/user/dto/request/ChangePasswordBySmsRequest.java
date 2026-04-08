package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * 用户通过短信验证码修改密码请求
 */
@Schema(description = "用户通过短信验证码修改密码请求")
public record ChangePasswordBySmsRequest(
        @Schema(description = "短信验证码", example = "123456")
        @NotBlank(message = "验证码不能为空")
        String smsCode,

        @Schema(description = "新密码", example = "abc123456")
        @NotBlank(message = "新密码不能为空")
        @Size(min = 6, max = 20, message = "密码长度为6-20个字符")
        String newPassword,

        @Schema(description = "确认密码", example = "abc123456")
        @NotBlank(message = "确认密码不能为空")
        String confirmPassword
) {
}
