package com.novacloudedu.backend.interfaces.rest.ppt.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@Schema(description = "生成PPT请求")
public class GeneratePptRequest {

    @Schema(description = "模板ID")
    private Long templateId;

    @Schema(description = "PPT标题")
    private String title;

    @Schema(description = "作者")
    private String author;

    @Schema(description = "每页幻灯片的克隆来源和填充内容")
    private List<Map<String, Object>> slides;
}
