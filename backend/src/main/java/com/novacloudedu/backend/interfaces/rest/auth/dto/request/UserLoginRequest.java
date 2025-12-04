package com.novacloudedu.backend.interfaces.rest.auth.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 用户登录请求DTO
 */
@Data
@Schema(description = "用户登录请求")
public class UserLoginRequest {

    @Schema(description = "用户账号", example = "testuser")
    @NotBlank(message = "账号不能为空")
    private String userAccount;

    @Schema(description = "用户密码", example = "123456")
    @NotBlank(message = "密码不能为空")
    private String userPassword;
}
