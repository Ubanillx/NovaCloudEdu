package com.novacloudedu.backend.interfaces.rest.auth.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

/**
 * 用户注册请求DTO
 */
@Data
@Schema(description = "用户注册请求")
public class UserRegisterRequest {

    @Schema(description = "用户账号", example = "testuser")
    @NotBlank(message = "账号不能为空")
    private String userAccount;

    @Schema(description = "用户密码", example = "123456")
    @NotBlank(message = "密码不能为空")
    private String userPassword;

    @Schema(description = "确认密码", example = "123456")
    @NotBlank(message = "确认密码不能为空")
    private String checkPassword;

    @Schema(description = "手机号", example = "18612345678")
    @NotBlank(message = "手机号不能为空")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String phone;

    @Schema(description = "短信验证码", example = "123456")
    @NotBlank(message = "验证码不能为空")
    private String smsCode;
}
