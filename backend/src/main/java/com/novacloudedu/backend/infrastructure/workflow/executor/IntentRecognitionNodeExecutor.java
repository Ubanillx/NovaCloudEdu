package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * 意图识别节点执行器
 * <p>
 * 使用 LLM 对输入文本进行意图分类。
 * 支持配置多个意图（name + description + examples），
 * 由 LLM 判断最匹配的意图并返回置信度。
 * <p>
 * 配置字段：
 * - model: LLM 模型 ID（如 dashscope/qwen-max），可选，留空使用默认模型
 * - inputVariable: 待分类文本的变量名
 * - intents[]: 意图列表，每项 {name, description, examples?}
 * - outputVariable: 输出变量名（默认 "intentResult"）
 * - confidenceThreshold: 最低置信度阈值（默认 0.6）
 * <p>
 * 输出：
 * - {outputVariable}: 匹配的意图名称
 * - confidence: 置信度 0-1
 * - allIntents: 所有意图及得分
 * - rawResponse: LLM 原始响应
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class IntentRecognitionNodeExecutor implements NodeExecutor {

    private final LangchainChatService langchainChatService;
    private static final ObjectMapper MAPPER = new ObjectMapper();

    @Override
    public NodeType getNodeType() {
        return NodeType.INTENT_RECOGNITION;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();

        // ===== 1. 读取配置 =====
        String model = (String) config.getOrDefault("model", "");
        String inputVariable = (String) config.getOrDefault("inputVariable",
                (String) config.getOrDefault("textVariable", "userInput")); // 兼容旧字段
        List<Map<String, Object>> intents = (List<Map<String, Object>>) config.get("intents");
        String outputVariable = (String) config.getOrDefault("outputVariable", "intentResult");
        double confidenceThreshold = getDouble(config, "confidenceThreshold", 0.6);

        // 模型参数（前端可配置）
        Double temperature = getDoubleOrNull(config, "temperature");
        Double topP = getDoubleOrNull(config, "topP");
        Integer maxTokens = getIntegerOrNull(config, "maxTokens");

        // ===== 2. 获取输入文本 =====
        Object rawText = input.get(inputVariable);
        String text = rawText != null ? String.valueOf(rawText).trim() : "";
        if (text.isEmpty()) {
            log.warn("意图识别节点: 输入文本为空, inputVariable={}", inputVariable);
            return buildResult(outputVariable, "default", 0.0, List.of(), "");
        }

        if (intents == null || intents.isEmpty()) {
            log.warn("意图识别节点: 未配置任何意图");
            return buildResult(outputVariable, "default", 0.0, List.of(), "");
        }

        // ===== 3. 构建意图描述 =====
        StringBuilder intentDesc = new StringBuilder();
        List<String> intentNames = new ArrayList<>();
        for (Map<String, Object> intent : intents) {
            String name = (String) intent.get("name");
            String description = (String) intent.getOrDefault("description", "");
            List<String> examples = (List<String>) intent.get("examples");
            intentNames.add(name);

            intentDesc.append("- ").append(name);
            if (!description.isEmpty()) {
                intentDesc.append(": ").append(description);
            }
            if (examples != null && !examples.isEmpty()) {
                intentDesc.append(" (示例: ").append(String.join("、", examples)).append(")");
            }
            intentDesc.append("\n");
        }

        // ===== 4. 构建提示词并调用 LLM =====
        String systemPrompt = """
                你是一个意图识别专家。根据用户输入文本，从以下意图列表中选择最匹配的意图。

                意图列表：
                %s
                严格以JSON格式返回结果（不要返回其他任何内容）：
                {"intent": "意图名称", "confidence": 0.95}

                如果无法确定意图，返回：
                {"intent": "default", "confidence": 0.0}
                """.formatted(intentDesc.toString());

        String userMessage = "用户输入：" + text;

        log.info("意图识别节点执行: nodeId={}, model={}, 意图数={}, 输入长度={}",
                node.getId(), model.isEmpty() ? "(默认)" : model, intents.size(), text.length());

        // 应用默认值：意图分类推荐低温度
        double finalTemp = temperature != null ? temperature : 0.1;
        int finalMaxTokens = maxTokens != null ? maxTokens : 500;

        String response;
        // 始终使用 streamChatWithParams 以传递模型参数
        // model 为空时使用默认模型
        String effectiveModel = model.isEmpty() ? null : model;
        StringBuilder sb = new StringBuilder();
        if (effectiveModel != null) {
            langchainChatService.streamChatWithParams(
                    effectiveModel,
                    List.of(
                            Map.of("role", "system", "content", systemPrompt),
                            Map.of("role", "user", "content", userMessage)
                    ),
                    finalTemp, topP, finalMaxTokens,
                    sb::append
            );
            response = sb.toString();
        } else {
            // 无指定模型时走默认 chat 接口
            response = langchainChatService.chat(null, systemPrompt, userMessage);
        }

        // ===== 5. 解析 LLM 响应 =====
        try {
            String jsonStr = extractJson(response);
            Map<String, Object> parsed = MAPPER.readValue(jsonStr, Map.class);

            String intent = (String) parsed.getOrDefault("intent", "default");
            double confidence = parsed.get("confidence") instanceof Number
                    ? ((Number) parsed.get("confidence")).doubleValue() : 0.0;

            // 验证意图名称是否在配置列表中
            if (!"default".equals(intent) && !intentNames.contains(intent)) {
                log.warn("意图识别: LLM 返回了未定义的意图 '{}', 回退到 default", intent);
                intent = "default";
                confidence = 0.0;
            }

            // 置信度过低时回退
            if (confidence < confidenceThreshold && !"default".equals(intent)) {
                log.info("意图识别: 置信度 {} 低于阈值 {}, 回退到 default", confidence, confidenceThreshold);
                intent = "default";
            }

            log.info("意图识别完成: nodeId={}, intent={}, confidence={}", node.getId(), intent, confidence);

            // 构建所有意图的得分列表
            List<Map<String, Object>> allIntents = new ArrayList<>();
            for (String name : intentNames) {
                Map<String, Object> item = new HashMap<>();
                item.put("name", name);
                item.put("score", name.equals(intent) ? confidence : 0.0);
                item.put("matched", name.equals(intent));
                allIntents.add(item);
            }

            return buildResult(outputVariable, intent, confidence, allIntents, response);

        } catch (Exception e) {
            log.error("意图识别解析失败: nodeId={}, response={}, error={}", node.getId(), response, e.getMessage());
            return buildResult(outputVariable, "UNKNOWN", 0.0, List.of(), response);
        }
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null) {
            throw new IllegalArgumentException("意图识别节点缺少配置");
        }
        // 兼容新旧字段名
        String inputVar = (String) config.get("inputVariable");
        String textVar = (String) config.get("textVariable");
        if ((inputVar == null || inputVar.isBlank()) && (textVar == null || textVar.isBlank())) {
            throw new IllegalArgumentException("意图识别节点缺少输入变量配置(inputVariable)");
        }
        Object intents = config.get("intents");
        if (intents == null || (intents instanceof List && ((List<?>) intents).isEmpty())) {
            throw new IllegalArgumentException("意图识别节点必须配置至少一个意图");
        }
    }

    private Map<String, Object> buildResult(String outputVariable, String intent, double confidence,
                                              List<Map<String, Object>> allIntents, String rawResponse) {
        Map<String, Object> output = new HashMap<>();
        output.put(outputVariable, intent);
        output.put("confidence", confidence);
        output.put("allIntents", allIntents);
        output.put("rawResponse", rawResponse);
        // 分支路由字段：引擎根据 branch/matchedBranch 匹配 edge.sourceHandle 决定下游节点
        output.put("branch", intent);
        output.put("matchedBranch", intent);
        return output;
    }

    private String extractJson(String text) {
        int start = text.indexOf("{");
        int end = text.lastIndexOf("}");
        if (start >= 0 && end > start) {
            return text.substring(start, end + 1);
        }
        return "{}";
    }

    private double getDouble(Map<String, Object> config, String key, double defaultValue) {
        Object value = config.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) return ((Number) value).doubleValue();
        return defaultValue;
    }

    private Double getDoubleOrNull(Map<String, Object> config, String key) {
        Object value = config.get(key);
        if (value instanceof Number) return ((Number) value).doubleValue();
        return null;
    }

    private Integer getIntegerOrNull(Map<String, Object> config, String key) {
        Object value = config.get(key);
        if (value instanceof Number) return ((Number) value).intValue();
        return null;
    }
}
