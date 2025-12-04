package com.novacloudedu.backend.interfaces.rest.auth.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

/**
 * 发送验证码请求
 */
@Schema(description = "发送验证码请求")
public record SendCodeRequest(
        @Schema(description = "手机号", example = "18612345678")
        @NotBlank(message = "手机号不能为空")
        @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
        String phone
) {
}
