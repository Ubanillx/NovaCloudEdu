package com.novacloudedu.backend.interfaces.rest.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDate;

/**
 * 创建用户请求
 */
public record CreateUserRequest(
        @NotBlank(message = "账号不能为空")
        @Size(min = 4, max = 20, message = "账号长度为4-20个字符")
        String userAccount,

        @NotBlank(message = "密码不能为空")
        @Size(min = 6, max = 20, message = "密码长度为6-20个字符")
        String userPassword,

        String userName,
        String role,
        Integer userGender,
        String userPhone,
        String userEmail,
        String userAddress,
        LocalDate birthday
) {
}
