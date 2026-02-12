package com.novacloudedu.backend.interfaces.rest.ppt.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@Schema(description = "PPT模板详情")
public class PptTemplateDetailResponse {

    @Schema(description = "模板ID")
    private Long id;

    @Schema(description = "模板名称")
    private String name;

    @Schema(description = "模板描述")
    private String description;

    @Schema(description = "封面图URL")
    private String coverUrl;

    @Schema(description = "模板文件URL")
    private String templateUrl;

    @Schema(description = "页数")
    private int slideCount;

    @Schema(description = "模板结构JSON（含每页槽位信息）")
    private String structureJson;

    @Schema(description = "是否启用")
    private boolean enabled;
}
