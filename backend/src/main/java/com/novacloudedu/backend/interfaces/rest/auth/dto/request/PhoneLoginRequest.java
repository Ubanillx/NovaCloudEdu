package com.novacloudedu.backend.interfaces.rest.auth.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

/**
 * 手机验证码登录请求
 */
@Schema(description = "手机验证码登录请求")
public record PhoneLoginRequest(
        @Schema(description = "手机号", example = "18612345678")
        @NotBlank(message = "手机号不能为空")
        @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
        String phone,

        @Schema(description = "短信验证码", example = "123456")
        @NotBlank(message = "验证码不能为空")
        @Pattern(regexp = "^\\d{6}$", message = "验证码格式不正确")
        String smsCode
) {
}
