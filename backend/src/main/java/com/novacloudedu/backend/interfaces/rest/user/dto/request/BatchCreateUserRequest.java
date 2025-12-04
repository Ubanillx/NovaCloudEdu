package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;

import java.util.List;

/**
 * 批量创建用户请求
 */
public record BatchCreateUserRequest(
        @NotEmpty(message = "用户列表不能为空")
        @Valid
        List<CreateUserRequest> users
) {
}
