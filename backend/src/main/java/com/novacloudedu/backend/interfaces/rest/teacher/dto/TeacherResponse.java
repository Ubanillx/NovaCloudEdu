package com.novacloudedu.backend.interfaces.rest.teacher.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "讲师信息响应")
public class TeacherResponse {

    @Schema(description = "讲师ID")
    private Long id;

    @Schema(description = "讲师姓名")
    private String name;

    @Schema(description = "讲师简介")
    private String introduction;

    @Schema(description = "专业领域")
    private List<String> expertise;

    @Schema(description = "关联用户ID")
    private Long userId;

    @Schema(description = "创建时间")
    private LocalDateTime createTime;

    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
}
