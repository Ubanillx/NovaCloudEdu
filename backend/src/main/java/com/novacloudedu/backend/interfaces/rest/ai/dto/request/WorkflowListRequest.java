package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Data;

/**
 * 工作流列表查询请求
 */
@Data
@Schema(description = "工作流列表查询请求")
public class WorkflowListRequest {

    @Schema(description = "用户ID（查询用户工作流时必填）", example = "1")
    private Long userId;

    @Min(value = 0, message = "页码不能小于0")
    @Schema(description = "页码，从0开始", defaultValue = "0", example = "0")
    private int page = 0;

    @Min(value = 1, message = "每页数量最小为1")
    @Max(value = 100, message = "每页数量最大为100")
    @Schema(description = "每页数量", defaultValue = "20", example = "20")
    private int size = 20;
}
