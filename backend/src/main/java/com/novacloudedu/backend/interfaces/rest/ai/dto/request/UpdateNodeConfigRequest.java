package com.novacloudedu.backend.interfaces.rest.ai.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Map;

/**
 * 更新节点配置请求
 */
@Data
@Schema(description = "更新节点配置请求")
public class UpdateNodeConfigRequest {

    @NotNull(message = "配置参数不能为空")
    @Schema(description = "节点配置参数", requiredMode = Schema.RequiredMode.REQUIRED)
    private Map<String, Object> config;
}
