package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.McpServer;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.repository.McpServerRepository;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.domain.knowledge.service.KnowledgeSearchService;
import com.novacloudedu.backend.infrastructure.ai.ChatModelFactory;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.infrastructure.ai.McpClientService;
import com.novacloudedu.backend.infrastructure.ai.McpClientService.McpTool;
import dev.langchain4j.agent.tool.ToolSpecification;
import dev.langchain4j.data.message.*;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.chat.request.ChatRequest;
import dev.langchain4j.model.chat.request.json.JsonObjectSchema;
import dev.langchain4j.model.chat.response.ChatResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * LLM节点执行器
 *
 * 支持的配置项（与前端 LLMConfig 面板对应）：
 * - model: 模型ID（如 "dashscope/qwen-max"）
 * - systemPrompt: 系统提示词，支持 {{变量}} 占位符
 * - userPromptTemplate: 用户提示词模板，支持 {{变量}} 占位符
 * - temperature / topP / maxTokens: 模型参数
 * - inputMappings: 输入变量映射 [{variableName, mappedKey}]，将工作流变量映射为模板占位符
 * - outputVariable: 输出变量名（默认 "llmOutput"）
 * - knowledgeBaseIds: 关联的知识库ID列表，自动做 RAG 检索
 * - ragTopK / ragThreshold: RAG 检索参数
 * - enabledCapabilities: 可选 AI 能力列表 ["vision","text2image","webSearch"]
 * - historyVariable: 历史消息变量名（多轮对话）
 * - historyLimit: 保留历史消息数量
 * - parseJsonOutput / jsonSchema: JSON 输出解析
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class LlmNodeExecutor implements NodeExecutor {

    private final LangchainChatService langchainChatService;
    private final KnowledgeSearchService knowledgeSearchService;
    private final McpClientService mcpClientService;
    private final ChatModelFactory chatModelFactory;
    private final McpServerRepository mcpServerRepository;

    private static final int MAX_TOOL_CALL_ITERATIONS = 10;
    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    private static final Pattern VAR_PATTERN = Pattern.compile("\\{\\{([^}]+)}}");

    @Override
    public NodeType getNodeType() {
        return NodeType.LLM;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        if (config == null) config = Collections.emptyMap();

        // ===== 1. 读取模型配置 =====
        String model = (String) config.get("model");
        Double temperature = toDouble(config.get("temperature"));
        Double topP = toDouble(config.get("topP"));
        Integer maxTokens = toInteger(config.get("maxTokens"));

        // ===== 2. 构建输入变量上下文（合并 inputMappings + 工作流全量变量）=====
        Map<String, Object> varContext = new HashMap<>(input);
        List<Map<String, String>> inputMappings = (List<Map<String, String>>) config.get("inputMappings");
        if (inputMappings != null) {
            for (Map<String, String> mapping : inputMappings) {
                String variableName = mapping.get("variableName");
                String mappedKey = mapping.get("mappedKey");
                if (variableName != null && mappedKey != null && input.containsKey(variableName)) {
                    varContext.put(mappedKey, input.get(variableName));
                }
            }
        }

        // ===== 3. 解析提示词模板 =====
        String systemPrompt = replaceVariables(
                (String) config.getOrDefault("systemPrompt", ""), varContext);
        String userPromptTemplate = (String) config.getOrDefault("userPromptTemplate", "");
        // 兼容旧字段 userMessage
        if (userPromptTemplate.isEmpty()) {
            userPromptTemplate = (String) config.getOrDefault("userMessage", "");
        }
        String userMessage = replaceVariables(userPromptTemplate, varContext);

        // 如果用户消息仍为空，尝试从 input 获取
        if (userMessage.isEmpty()) {
            Object userInput = input.get("userInput");
            if (userInput != null && !String.valueOf(userInput).isEmpty()) {
                userMessage = String.valueOf(userInput);
            }
        }

        // 如果用户消息仍为空但有系统提示词，使用通用指令避免空消息导致 API 报错
        if (userMessage.isEmpty() && !systemPrompt.isEmpty()) {
            userMessage = "请根据以上系统提示词的要求进行回答。";
            log.info("LLM节点: userMessage为空，已使用默认用户消息");
        }
        // 如果两者都为空，直接报错
        if (userMessage.isEmpty() && systemPrompt.isEmpty()) {
            throw new IllegalArgumentException("LLM节点执行失败: 系统提示词和用户消息均为空，请至少配置其中一项");
        }

        // ===== 4. 知识库 RAG 检索 =====
        List<?> knowledgeBaseIds = (List<?>) config.get("knowledgeBaseIds");
        String ragContext = "";
        List<Map<String, Object>> ragReferences = new ArrayList<>();
        if (knowledgeBaseIds != null && !knowledgeBaseIds.isEmpty() && !userMessage.isEmpty()) {
            Integer ragTopK = toInteger(config.getOrDefault("ragTopK", 5));
            Double ragThreshold = toDouble(config.getOrDefault("ragThreshold", 0.5));
            ragContext = performRag(knowledgeBaseIds, userMessage, ragTopK, ragThreshold, ragReferences);
        } else if (knowledgeBaseIds != null && !knowledgeBaseIds.isEmpty()) {
            log.warn("LLM节点: 跳过RAG检索，因为用户消息为空");
        }

        // ===== 5. 构建消息列表 =====
        List<Map<String, String>> messages = new ArrayList<>();

        // 系统提示词（拼接 RAG 上下文）
        StringBuilder sysBuilder = new StringBuilder();
        if (!systemPrompt.isEmpty()) {
            sysBuilder.append(systemPrompt);
        }
        if (!ragContext.isEmpty()) {
            if (sysBuilder.length() > 0) sysBuilder.append("\n\n");
            sysBuilder.append(ragContext);
        }
        if (sysBuilder.length() > 0) {
            messages.add(Map.of("role", "system", "content", sysBuilder.toString()));
        }

        // 历史消息（多轮对话）
        String historyVariable = (String) config.get("historyVariable");
        Integer historyLimit = toInteger(config.getOrDefault("historyLimit", 10));
        if (historyVariable != null && !historyVariable.isEmpty()) {
            Object historyObj = input.get(historyVariable);
            if (historyObj instanceof List) {
                List<Map<String, String>> history = (List<Map<String, String>>) historyObj;
                int start = Math.max(0, history.size() - historyLimit);
                for (int i = start; i < history.size(); i++) {
                    messages.add(history.get(i));
                }
            }
        }

        // 用户消息
        messages.add(Map.of("role", "user", "content", userMessage));

        log.info("LLM节点执行: model={}, systemPrompt长度={}, userMessage长度={}, RAG上下文长度={}, 消息数={}",
                model, sysBuilder.length(), userMessage.length(), ragContext.length(), messages.size());

        // ===== 6. 解析 AI 能力开关 =====
        List<String> enabledCapabilities = (List<String>) config.get("enabledCapabilities");
        boolean enableSearch = enabledCapabilities != null && enabledCapabilities.contains("webSearch");

        // ===== 6.5 MCP 工具调用（通过 mcpServerIds 从数据库加载配置） =====
        List<?> mcpServerIdsRaw = (List<?>) config.get("mcpServerIds");
        List<Long> mcpServerIds = mcpServerIdsRaw != null
                ? mcpServerIdsRaw.stream().map(id -> Long.valueOf(String.valueOf(id))).toList()
                : List.of();
        boolean hasMcpTools = !mcpServerIds.isEmpty();

        // ===== 7. 调用 LLM =====
        String response;
        List<Map<String, Object>> toolCallLogs = new ArrayList<>();

        if (hasMcpTools) {
            // ===== MCP Tool Calling 模式：从DB加载服务器配置 =====
            List<McpServer> mcpServers = mcpServerRepository.findByIds(mcpServerIds);
            response = executeWithMcpTools(model, messages, mcpServers,
                    temperature, topP, maxTokens, toolCallLogs);
        } else if (temperature != null || topP != null || maxTokens != null || enableSearch) {
            // 使用自定义参数调用（同步收集）
            StringBuilder sb = new StringBuilder();
            langchainChatService.streamChatWithParams(
                    model, messages, temperature, topP, maxTokens, enableSearch, sb::append);
            response = sb.toString();
        } else {
            // 使用模型默认参数
            response = langchainChatService.chat(model,
                    sysBuilder.toString().isEmpty() ? null : sysBuilder.toString(),
                    userMessage);
        }

        // ===== 8. 构建输出 =====
        String outputVariable = (String) config.getOrDefault("outputVariable", "llmOutput");
        Map<String, Object> result = new HashMap<>();
        result.put("response", response);
        result.put(outputVariable, response);
        result.put("model", model != null ? model : "default");
        result.put("tokensUsed", response.length()); // 近似值

        // RAG 引用
        if (!ragReferences.isEmpty()) {
            result.put("ragReferences", ragReferences);
            result.put("ragReferenceCount", ragReferences.size());
        }

        // JSON 输出解析
        Boolean parseJsonOutput = (Boolean) config.get("parseJsonOutput");
        if (Boolean.TRUE.equals(parseJsonOutput)) {
            try {
                com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
                // 尝试从 response 中提取 JSON
                String jsonStr = extractJson(response);
                Object parsed = mapper.readValue(jsonStr, Object.class);
                result.put("parsedOutput", parsed);
            } catch (Exception e) {
                log.warn("LLM JSON输出解析失败: {}", e.getMessage());
                result.put("parsedOutput", null);
                result.put("parseError", e.getMessage());
            }
        }

        // 可选 AI 能力标记（前端可据此做后处理，如文生图触发等）
        if (enabledCapabilities != null && !enabledCapabilities.isEmpty()) {
            result.put("enabledCapabilities", enabledCapabilities);
        }

        // MCP 工具调用日志
        if (!toolCallLogs.isEmpty()) {
            result.put("toolCalls", toolCallLogs);
            result.put("toolCallCount", toolCallLogs.size());
        }

        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null) {
            throw new IllegalArgumentException("LLM节点缺少配置");
        }
    }

    /**
     * 执行 RAG 知识库检索
     */
    private String performRag(List<?> knowledgeBaseIds, String query,
                              int topK, double threshold,
                              List<Map<String, Object>> referencesOut) {
        try {
            List<Long> ids = knowledgeBaseIds.stream()
                    .map(v -> {
                        if (v instanceof Number n) return n.longValue();
                        return Long.parseLong(String.valueOf(v));
                    })
                    .toList();

            KnowledgeSearchService.SearchRequest request = KnowledgeSearchService.SearchRequest.builder()
                    .knowledgeBaseIds(ids)
                    .query(query)
                    .topK(topK)
                    .similarityThreshold(threshold)
                    .retrievalMode("hybrid")
                    .build();

            KnowledgeSearchService.SearchResult searchResult = knowledgeSearchService.search(request);

            if (searchResult.getDocuments() == null || searchResult.getDocuments().isEmpty()) {
                log.info("LLM节点 RAG 检索无结果: knowledgeBaseIds={}", ids);
                return "";
            }

            StringBuilder context = new StringBuilder("【知识库参考资料】\n\n");
            int idx = 1;
            for (KnowledgeSearchService.DocumentChunk doc : searchResult.getDocuments()) {
                context.append(String.format("参考 %d（相关度: %.2f）：\n%s\n\n",
                        idx, doc.getScore(), doc.getContent()));
                Map<String, Object> ref = new LinkedHashMap<>();
                ref.put("index", idx);
                ref.put("score", doc.getScore());
                ref.put("documentId", doc.getDocumentId());
                ref.put("documentName", doc.getDocumentName());
                ref.put("contentPreview", doc.getContent().substring(0, Math.min(100, doc.getContent().length())));
                referencesOut.add(ref);
                idx++;
            }

            log.info("LLM节点 RAG 检索完成: {}条参考, 上下文长度={}, 耗时{}ms",
                    searchResult.getDocuments().size(), context.length(), searchResult.getSearchTimeMs());
            return context.toString();

        } catch (Exception e) {
            log.error("LLM节点 RAG 检索异常", e);
            return "";
        }
    }

    // ==================== MCP Tool Calling ====================

    /**
     * 使用 MCP 工具调用模式执行 LLM 对话
     * <p>
     * 流程：
     * 1. 连接所有配置的 MCP 服务器，发现工具列表
     * 2. 将 MCP 工具转换为 langchain4j ToolSpecification
     * 3. 使用非流式 ChatLanguageModel 发送消息 + 工具规格
     * 4. 如果 LLM 返回工具调用请求，通过 MCP 执行工具
     * 5. 将工具结果反馈给 LLM，循环直到得到最终文本回复
     */
    private String executeWithMcpTools(String modelId, List<Map<String, String>> messages,
                                        List<McpServer> mcpServers,
                                        Double temperature, Double topP, Integer maxTokens,
                                        List<Map<String, Object>> toolCallLogs) {

        // 1. 发现所有 MCP 服务器的工具
        List<ToolSpecification> allToolSpecs = new ArrayList<>();
        // 工具名 -> 所属 McpServer（用于后续调用）
        Map<String, McpServer> toolToServer = new LinkedHashMap<>();

        for (McpServer server : mcpServers) {
            if (!Boolean.TRUE.equals(server.getEnabled())) {
                log.info("MCP服务器 [{}] 已禁用，跳过", server.getName());
                continue;
            }
            try {
                List<McpTool> tools = mcpClientService.listTools(server);
                for (McpTool tool : tools) {
                    ToolSpecification spec = convertMcpToolToSpec(tool);
                    allToolSpecs.add(spec);
                    toolToServer.put(tool.getName(), server);
                }
                log.info("MCP服务器 [{}] 发现 {} 个工具", server.getName(), tools.size());
            } catch (Exception e) {
                log.error("MCP服务器 [{}] 工具发现失败: {}", server.getName(), e.getMessage());
            }
        }

        if (allToolSpecs.isEmpty()) {
            log.warn("所有MCP服务器均未返回工具，回退到普通LLM调用");
            StringBuilder sb = new StringBuilder();
            langchainChatService.streamChatWithParams(modelId, messages, temperature, topP, maxTokens, false, sb::append);
            return sb.toString();
        }

        log.info("MCP工具发现完成: 共{}个工具, 工具名={}", allToolSpecs.size(),
                allToolSpecs.stream().map(ToolSpecification::name).toList());

        // 2. 创建非流式模型（tool calling 需要同步响应）
        ChatLanguageModel chatModel;
        if (temperature != null || topP != null || maxTokens != null) {
            chatModel = chatModelFactory.createChatModelWithParams(modelId, temperature, topP, maxTokens);
        } else {
            chatModel = chatModelFactory.getChatModel(modelId);
        }

        // 3. 构建初始消息列表
        List<ChatMessage> chatMessages = new ArrayList<>();
        for (Map<String, String> msg : messages) {
            String role = msg.get("role");
            String content = msg.get("content");
            if (role == null || content == null) continue;
            switch (role.toLowerCase()) {
                case "system" -> chatMessages.add(SystemMessage.from(content));
                case "assistant" -> chatMessages.add(AiMessage.from(content));
                default -> chatMessages.add(UserMessage.from(content));
            }
        }

        // 4. Tool calling 循环
        for (int iteration = 0; iteration < MAX_TOOL_CALL_ITERATIONS; iteration++) {
            ChatRequest request = ChatRequest.builder()
                    .messages(chatMessages)
                    .toolSpecifications(allToolSpecs)
                    .build();

            ChatResponse chatResponse = chatModel.chat(request);
            AiMessage aiMessage = chatResponse.aiMessage();
            chatMessages.add(aiMessage);

            // 如果 LLM 没有请求工具调用，返回最终文本
            if (!aiMessage.hasToolExecutionRequests()) {
                log.info("MCP tool calling 完成: 迭代{}次, 工具调用{}次",
                        iteration + 1, toolCallLogs.size());
                return aiMessage.text() != null ? aiMessage.text() : "";
            }

            // 执行工具调用
            for (var toolRequest : aiMessage.toolExecutionRequests()) {
                String toolName = toolRequest.name();
                String toolArgs = toolRequest.arguments();
                String toolId = toolRequest.id();

                log.info("MCP tool call [{}]: name={}, args={}", iteration + 1, toolName, toolArgs);

                // 查找工具所属的 MCP 服务器
                McpServer server = toolToServer.get(toolName);
                String toolResult;
                if (server == null) {
                    toolResult = "[错误: 未找到工具 " + toolName + " 所属的MCP服务器]";
                    log.warn("MCP工具未找到对应服务器: {}", toolName);
                } else {
                    Map<String, Object> argsMap = parseToolArguments(toolArgs);
                    toolResult = mcpClientService.callTool(server, toolName, argsMap);
                }

                // 记录工具调用日志
                Map<String, Object> logEntry = new LinkedHashMap<>();
                logEntry.put("iteration", iteration + 1);
                logEntry.put("toolName", toolName);
                logEntry.put("arguments", toolArgs);
                logEntry.put("result", toolResult.length() > 500
                        ? toolResult.substring(0, 500) + "...(截断)" : toolResult);
                toolCallLogs.add(logEntry);

                // 将工具结果添加到消息历史
                chatMessages.add(ToolExecutionResultMessage.from(
                        toolId != null ? toolId : toolName,
                        toolName,
                        toolResult
                ));
            }
        }

        // 超过最大迭代次数，收集最后的消息
        log.warn("MCP tool calling 达到最大迭代次数 {}", MAX_TOOL_CALL_ITERATIONS);
        ChatMessage lastMsg = chatMessages.get(chatMessages.size() - 1);
        if (lastMsg instanceof AiMessage ai && ai.text() != null) {
            return ai.text();
        }
        return "[MCP工具调用达到最大迭代次数，未获得最终回复]";
    }

    /**
     * 将 MCP 工具定义转换为 langchain4j ToolSpecification
     */
    private ToolSpecification convertMcpToolToSpec(McpTool mcpTool) {
        ToolSpecification.Builder builder = ToolSpecification.builder()
                .name(mcpTool.getName())
                .description(mcpTool.getDescription() != null ? mcpTool.getDescription() : "");

        // 解析 inputSchema 为 JsonObjectSchema
        JsonNode schema = mcpTool.getInputSchema();
        if (schema != null && schema.has("properties")) {
            try {
                JsonObjectSchema.Builder schemaBuilder = JsonObjectSchema.builder();
                JsonNode properties = schema.get("properties");
                Iterator<Map.Entry<String, JsonNode>> fields = properties.fields();
                while (fields.hasNext()) {
                    Map.Entry<String, JsonNode> field = fields.next();
                    String propName = field.getKey();
                    JsonNode propDef = field.getValue();
                    String description = propDef.has("description") ? propDef.get("description").asText() : "";
                    String type = propDef.has("type") ? propDef.get("type").asText() : "string";

                    switch (type) {
                        case "integer", "number" -> schemaBuilder.addNumberProperty(propName, description);
                        case "boolean" -> schemaBuilder.addBooleanProperty(propName, description);
                        case "array" -> schemaBuilder.addProperty(propName,
                                dev.langchain4j.model.chat.request.json.JsonArraySchema.builder()
                                        .description(description).build());
                        default -> schemaBuilder.addStringProperty(propName, description);
                    }
                }

                // 处理 required 字段
                if (schema.has("required") && schema.get("required").isArray()) {
                    List<String> required = new ArrayList<>();
                    for (JsonNode r : schema.get("required")) {
                        required.add(r.asText());
                    }
                    schemaBuilder.required(required);
                }

                builder.parameters(schemaBuilder.build());
            } catch (Exception e) {
                log.warn("MCP工具 [{}] inputSchema 解析失败，将不传递参数定义: {}",
                        mcpTool.getName(), e.getMessage());
            }
        }

        return builder.build();
    }

    /**
     * 解析工具调用的参数 JSON 字符串为 Map
     */
    private Map<String, Object> parseToolArguments(String argsJson) {
        if (argsJson == null || argsJson.isBlank()) {
            return Map.of();
        }
        try {
            @SuppressWarnings("unchecked")
            Map<String, Object> result = OBJECT_MAPPER.readValue(argsJson, Map.class);
            return result;
        } catch (Exception e) {
            log.warn("工具参数JSON解析失败: {}", e.getMessage());
            return Map.of();
        }
    }


    // ==================== 模板与工具方法 ====================

    /**
     * 替换模板中的 {{变量}} 占位符
     */
    private String replaceVariables(String template, Map<String, Object> variables) {
        if (template == null || template.isEmpty()) {
            return template != null ? template : "";
        }

        StringBuffer result = new StringBuffer();
        Matcher matcher = VAR_PATTERN.matcher(template);
        while (matcher.find()) {
            String varName = matcher.group(1).trim();
            Object value = variables.get(varName);
            String replacement = value != null ? String.valueOf(value) : "";
            matcher.appendReplacement(result, Matcher.quoteReplacement(replacement));
        }
        matcher.appendTail(result);
        return result.toString();
    }

    /**
     * 从 LLM 回复中提取 JSON 片段
     */
    private String extractJson(String text) {
        if (text == null) return "{}";
        // 尝试提取 ```json ... ``` 中的内容
        int jsonStart = text.indexOf("```json");
        if (jsonStart >= 0) {
            int contentStart = text.indexOf('\n', jsonStart) + 1;
            int jsonEnd = text.indexOf("```", contentStart);
            if (jsonEnd > contentStart) {
                return text.substring(contentStart, jsonEnd).trim();
            }
        }
        // 尝试提取 { ... } 或 [ ... ]
        int braceStart = text.indexOf('{');
        int bracketStart = text.indexOf('[');
        if (braceStart >= 0 || bracketStart >= 0) {
            int start = braceStart >= 0 && (bracketStart < 0 || braceStart < bracketStart) ? braceStart : bracketStart;
            char open = text.charAt(start);
            char close = open == '{' ? '}' : ']';
            int depth = 0;
            for (int i = start; i < text.length(); i++) {
                if (text.charAt(i) == open) depth++;
                else if (text.charAt(i) == close) depth--;
                if (depth == 0) return text.substring(start, i + 1);
            }
        }
        return text.trim();
    }

    private Double toDouble(Object value) {
        if (value == null) return null;
        if (value instanceof Number) return ((Number) value).doubleValue();
        try { return Double.parseDouble(String.valueOf(value)); } catch (Exception e) { return null; }
    }

    private Integer toInteger(Object value) {
        if (value == null) return null;
        if (value instanceof Number) return ((Number) value).intValue();
        try { return Integer.parseInt(String.valueOf(value)); } catch (Exception e) { return null; }
    }
}
