package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Data;

import java.util.List;

/**
 * LLM大语言模型节点配置请求
 *
 * 与前端 LLMConfig 面板一一对应，涵盖：
 * - 模型选择与参数
 * - 提示词模板（支持 {{变量}} 占位符）
 * - 输入变量映射（从工作流导入数据）
 * - 输出变量配置（将AI输出导出到工作流）
 * - 知识库 RAG 配置
 * - 可选 AI 能力（文生图、视觉理解、联网搜索等）
 * - 多轮对话与 JSON 输出解析
 */
@Data
@Schema(description = "LLM大语言模型节点配置")
public class LlmNodeConfigRequest {

    // ===== 模型配置 =====

    @Schema(description = "模型ID（如 dashscope/qwen-max）", example = "dashscope/qwen-max")
    private String model;

    @Min(0) @Max(2)
    @Schema(description = "温度参数，控制输出随机性，0-2之间", example = "0.7")
    private Double temperature;

    @Min(1) @Max(128000)
    @Schema(description = "最大输出token数", example = "4096")
    private Integer maxTokens;

    @Min(0) @Max(1)
    @Schema(description = "Top P采样参数", example = "0.9")
    private Double topP;

    @Schema(description = "停止词列表")
    private List<String> stopSequences;

    // ===== 提示词配置 =====

    @Schema(description = "系统提示词，支持 {{变量}} 占位符", example = "你是一个专业的教育助手")
    private String systemPrompt;

    @Schema(description = "用户提示词模板，支持 {{变量}} 占位符", example = "请回答以下问题：{{userQuery}}")
    private String userPromptTemplate;

    // ===== 输入变量映射（从工作流导入数据到AI） =====

    @Schema(description = "输入变量映射列表，将工作流变量映射为模板占位符。variableName: 工作流变量名, mappedKey: 模板中的占位符名")
    private List<InputMapping> inputMappings;

    @Data
    @Schema(description = "输入变量映射项")
    public static class InputMapping {
        @Schema(description = "工作流中的变量名（上游节点输出的变量）", example = "userQuery")
        private String variableName;

        @Schema(description = "映射后的键名（在提示词模板中用 {{mappedKey}} 引用）", example = "question")
        private String mappedKey;
    }

    // ===== 输出配置（将AI输出导出到工作流） =====

    @Schema(description = "输出变量名，LLM的响应将存储为该变量供下游节点使用", example = "llmOutput")
    private String outputVariable;

    @Schema(description = "是否解析JSON输出", example = "false")
    private Boolean parseJsonOutput;

    @Schema(description = "JSON输出的Schema定义，指导LLM按结构输出")
    private String jsonSchema;

    // ===== 知识库 RAG 配置 =====

    @Schema(description = "关联的知识库ID列表，LLM会自动从这些知识库做RAG检索")
    private List<Long> knowledgeBaseIds;

    @Min(1) @Max(50)
    @Schema(description = "RAG检索返回的结果数量", example = "5")
    private Integer ragTopK;

    @Min(0) @Max(1)
    @Schema(description = "RAG检索的相似度阈值", example = "0.5")
    private Double ragThreshold;

    // ===== 可选 AI 能力 =====

    @Schema(description = "启用的AI能力列表。可选值: vision(视觉理解), text2image(文生图), webSearch(联网搜索), codeInterpreter(代码解释器)",
            example = "[\"vision\", \"text2image\"]")
    private List<String> enabledCapabilities;

    // ===== 多轮对话 =====

    @Schema(description = "历史消息变量名，用于多轮对话", example = "chatHistory")
    private String historyVariable;

    @Min(1) @Max(100)
    @Schema(description = "保留的历史消息数量", example = "10")
    private Integer historyLimit;

    // ===== 流式输出 =====

    @Schema(description = "是否启用流式输出（异步执行时有效）", example = "false")
    private Boolean stream;
}
