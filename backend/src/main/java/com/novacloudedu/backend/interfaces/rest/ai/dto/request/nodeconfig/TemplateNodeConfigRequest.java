package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Map;

/**
 * 模板渲染节点配置请求
 */
@Data
@Schema(description = "模板渲染节点配置")
public class TemplateNodeConfigRequest {

    @Schema(description = "模板引擎类型", example = "FREEMARKER", 
            allowableValues = {"FREEMARKER", "VELOCITY", "MUSTACHE", "SIMPLE"})
    private String templateEngine;

    @Schema(description = "模板内容", 
            example = "尊敬的${userName}，您的订单${orderId}已发货。")
    private String template;

    @Schema(description = "模板ID（使用预定义模板时）")
    private Long templateId;

    @Schema(description = "变量映射，将工作流变量映射到模板变量")
    private Map<String, String> variableMapping;

    @Schema(description = "输出变量名", example = "renderedText")
    private String outputVariable;

    @Schema(description = "输出格式", example = "TEXT", 
            allowableValues = {"TEXT", "HTML", "MARKDOWN", "JSON"})
    private String outputFormat;

    @Schema(description = "是否转义HTML", example = "true")
    private Boolean escapeHtml;

    @Schema(description = "缺失变量处理策略", example = "EMPTY", 
            allowableValues = {"EMPTY", "ERROR", "KEEP_PLACEHOLDER"})
    private String missingValueStrategy;
}
