package com.novacloudedu.backend.interfaces.rest.clazz.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Schema(description = "班级响应")
public class ClassResponse {

    @Schema(description = "班级ID")
    private String id;

    @Schema(description = "班级名称")
    private String className;

    @Schema(description = "班级描述")
    private String description;

    @Schema(description = "创建者ID")
    private String creatorId;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
