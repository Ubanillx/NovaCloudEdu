package com.novacloudedu.backend.interfaces.rest.membership.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "管理员为用户开通会员请求")
public class GrantMembershipRequest {

    @NotNull(message = "用户ID不能为空")
    @Schema(description = "用户ID")
    private Long userId;

    @NotNull(message = "计划ID不能为空")
    @Schema(description = "会员计划ID")
    private Long planId;
}
