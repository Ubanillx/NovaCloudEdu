package com.novacloudedu.backend.interfaces.rest.auth.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 登录用户响应DTO
 */
@Data
@Schema(description = "登录用户信息")
public class LoginUserResponse {

    @Schema(description = "用户ID")
    private Long id;

    @Schema(description = "用户账号")
    private String userAccount;

    @Schema(description = "用户昵称")
    private String userName;

    @Schema(description = "用户头像")
    private String userAvatar;

    @Schema(description = "用户简介")
    private String userProfile;

    @Schema(description = "用户角色")
    private String userRole;

    @Schema(description = "用户性别")
    private Integer userGender;

    @Schema(description = "用户手机")
    private String userPhone;

    @Schema(description = "用户邮箱")
    private String userEmail;

    @Schema(description = "等级")
    private Integer level;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "JWT Token")
    private String token;
}
