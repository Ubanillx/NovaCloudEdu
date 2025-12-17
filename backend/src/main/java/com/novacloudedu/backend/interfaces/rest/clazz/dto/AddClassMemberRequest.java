package com.novacloudedu.backend.interfaces.rest.clazz.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "添加班级成员请求")
public class AddClassMemberRequest {

    @Schema(description = "用户ID", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @Schema(description = "角色(TEACHER/STUDENT)", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotNull(message = "角色不能为空")
    private String role;
}
