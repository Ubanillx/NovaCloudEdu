package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Map;

/**
 * 更新工作流节点请求
 */
@Data
@Schema(description = "更新工作流节点请求")
public class UpdateNodeRequest {

    @Schema(description = "节点类型", example = "LLM")
    private NodeType type;

    @Schema(description = "节点名称", example = "GPT问答节点V2")
    private String name;

    @Schema(description = "节点位置X坐标", example = "150")
    private Integer positionX;

    @Schema(description = "节点位置Y坐标", example = "250")
    private Integer positionY;

    @Schema(description = "节点配置参数")
    private Map<String, Object> config;

    @Schema(description = "错误处理配置")
    private AddNodeRequest.ErrorHandlingConfigDTO errorHandling;
}
