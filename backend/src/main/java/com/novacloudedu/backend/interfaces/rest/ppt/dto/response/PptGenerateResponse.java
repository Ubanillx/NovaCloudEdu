package com.novacloudedu.backend.interfaces.rest.ppt.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@Schema(description = "PPT生成结果")
public class PptGenerateResponse {

    @Schema(description = "生成的PPTX文件URL")
    private String fileUrl;

    @Schema(description = "文件名")
    private String fileName;

    @Schema(description = "页数")
    private int slideCount;
}
