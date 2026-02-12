package com.novacloudedu.backend.interfaces.rest.ppt.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "上传PPT模板请求")
public class UploadPptTemplateRequest {

    @Schema(description = "模板名称", requiredMode = Schema.RequiredMode.REQUIRED)
    private String name;

    @Schema(description = "模板描述")
    private String description;
}
