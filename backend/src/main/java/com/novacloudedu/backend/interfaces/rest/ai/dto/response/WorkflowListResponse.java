package com.novacloudedu.backend.interfaces.rest.ai.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 工作流列表响应
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "工作流列表响应")
public class WorkflowListResponse {

    @Schema(description = "工作流列表")
    private List<WorkflowResponse> workflows;

    @Schema(description = "总数量", example = "100")
    private long total;

    @Schema(description = "当前页码", example = "0")
    private int page;

    @Schema(description = "每页数量", example = "20")
    private int size;
}
