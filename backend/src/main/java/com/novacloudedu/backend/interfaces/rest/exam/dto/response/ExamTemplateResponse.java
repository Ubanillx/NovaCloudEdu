package com.novacloudedu.backend.interfaces.rest.exam.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 试卷模板响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "试卷模板响应")
public class ExamTemplateResponse {

    @Schema(description = "模板ID")
    private Long id;

    @Schema(description = "模板名称")
    private String name;

    @Schema(description = "模板描述")
    private String description;

    @Schema(description = "模板文件URL")
    private String templateUrl;

    @Schema(description = "预览封面URL")
    private String coverUrl;

    @Schema(description = "是否系统内置")
    private Boolean isSystem;

    @Schema(description = "是否启用")
    private Boolean isEnabled;

    @Schema(description = "创建者ID")
    private Long creatorId;

    @Schema(description = "创建时间")
    private String createTime;

    @Schema(description = "更新时间")
    private String updateTime;
}
