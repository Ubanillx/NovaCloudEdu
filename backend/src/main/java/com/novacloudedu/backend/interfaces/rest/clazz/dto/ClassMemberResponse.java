package com.novacloudedu.backend.interfaces.rest.clazz.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(description = "班级成员响应")
public class ClassMemberResponse {

    @Schema(description = "成员ID")
    private String id;

    @Schema(description = "班级ID")
    private String classId;

    @Schema(description = "用户ID")
    private String userId;

    @Schema(description = "角色")
    private String role;

    @Schema(description = "加入时间")
    private LocalDateTime joinTime;
}
