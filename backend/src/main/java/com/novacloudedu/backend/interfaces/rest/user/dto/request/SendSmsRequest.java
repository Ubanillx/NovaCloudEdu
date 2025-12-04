package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

/**
 * 发送短信验证码请求
 */
public record SendSmsRequest(
        @NotBlank(message = "手机号不能为空")
        @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
        String phone,

        String code,           // 验证码，不传则自动生成

        Integer expireMinutes  // 有效期（分钟），不传则使用默认值
) {
}
