package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Data;

import java.util.List;

/**
 * LLM大语言模型节点配置请求
 */
@Data
@Schema(description = "LLM大语言模型节点配置")
public class LlmNodeConfigRequest {

    @Schema(description = "模型名称", example = "qwen-max", 
            allowableValues = {"qwen-max", "qwen-plus", "qwen-turbo", "qwen-long", "qwen-vl-max", "qwen-vl-plus"})
    private String model;

    @Schema(description = "系统提示词", example = "你是一个专业的教育助手")
    private String systemPrompt;

    @Schema(description = "用户提示词模板，支持变量替换如 ${input}", example = "请回答以下问题：${userQuery}")
    private String userPromptTemplate;

    @Min(0) @Max(2)
    @Schema(description = "温度参数，控制输出随机性，0-2之间", example = "0.7")
    private Double temperature;

    @Min(1) @Max(4096)
    @Schema(description = "最大输出token数", example = "2048")
    private Integer maxTokens;

    @Min(0) @Max(1)
    @Schema(description = "Top P采样参数", example = "0.9")
    private Double topP;

    @Schema(description = "停止词列表")
    private List<String> stopSequences;

    @Schema(description = "是否启用流式输出", example = "false")
    private Boolean stream;

    @Schema(description = "输出变量名，用于存储LLM响应", example = "llmResponse")
    private String outputVariable;

    @Schema(description = "是否解析JSON输出", example = "false")
    private Boolean parseJsonOutput;

    @Schema(description = "JSON输出的Schema定义")
    private String jsonSchema;

    @Schema(description = "历史消息变量名，用于多轮对话", example = "chatHistory")
    private String historyVariable;

    @Schema(description = "保留的历史消息数量", example = "10")
    private Integer historyLimit;
}
