package com.novacloudedu.backend.application.service.workflow;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 节点配置验证器
 */
@Slf4j
@Component
public class NodeConfigValidator {

    private static final Set<String> SUPPORTED_EMBEDDING_MODELS = Set.of(
            "text-embedding-v2", "text-embedding-v1"
    );

    /**
     * 验证节点配置
     */
    public ValidationResult validate(NodeType nodeType, Map<String, Object> config) {
        return switch (nodeType) {
            case LLM -> validateLlmConfig(config);
            case KNOWLEDGE_RETRIEVAL -> validateKnowledgeRetrievalConfig(config);
            case TEXT_EMBEDDING -> validateTextEmbeddingConfig(config);
            case CONDITION -> validateConditionConfig(config);
            case SWITCH -> validateSwitchConfig(config);
            case LOOP -> validateLoopConfig(config);
            case HTTP_REQUEST -> validateHttpRequestConfig(config);
            case DATABASE_QUERY -> validateDatabaseQueryConfig(config);
            case CODE -> validateCodeConfig(config);
            case TEMPLATE -> validateTemplateConfig(config);
            case VARIABLE_SET, VARIABLE_GET -> validateVariableConfig(config);
            case JSON_PARSE -> validateJsonParseConfig(config);
            case INTENT_RECOGNITION -> validateIntentRecognitionConfig(config);
            case ENTITY_EXTRACTION -> validateEntityExtractionConfig(config);
            case PARALLEL -> validateParallelConfig(config);
            case RESPONSE -> validateResponseConfig(config);
            case START -> validateStartConfig(config);
            case WEBHOOK -> validateWebhookConfig(config);
            case SCHEDULE -> validateScheduleConfig(config);
            case FILE_READ, FILE_WRITE -> validateFileConfig(config);
            case END, MERGE, LOOP_START, LOOP_END -> ValidationResult.success();
        };
    }

    @SuppressWarnings("unchecked")
    private ValidationResult validateLlmConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        // 模型验证：支持 "provider/model" 格式（如 dashscope/qwen-max），不再硬编码模型列表
        String model = (String) config.get("model");
        if (model == null || model.isBlank()) {
            errors.add("LLM节点必须指定模型");
        }

        // 用户提示词模板（兼容旧字段 userMessage）
        String userPromptTemplate = (String) config.get("userPromptTemplate");
        String userMessage = (String) config.get("userMessage");
        if ((userPromptTemplate == null || userPromptTemplate.isBlank())
                && (userMessage == null || userMessage.isBlank())) {
            errors.add("LLM节点必须指定用户提示词模板(userPromptTemplate)或用户消息(userMessage)");
        }

        Double temperature = getDouble(config, "temperature");
        if (temperature != null && (temperature < 0 || temperature > 2)) {
            errors.add("温度参数必须在0-2之间");
        }

        Integer maxTokens = getInteger(config, "maxTokens");
        if (maxTokens != null && (maxTokens < 1 || maxTokens > 128000)) {
            errors.add("最大token数必须在1-128000之间");
        }

        Double topP = getDouble(config, "topP");
        if (topP != null && (topP < 0 || topP > 1)) {
            errors.add("topP参数必须在0-1之间");
        }

        // 输入变量映射验证
        Object inputMappingsObj = config.get("inputMappings");
        if (inputMappingsObj instanceof List) {
            List<Map<String, String>> mappings = (List<Map<String, String>>) inputMappingsObj;
            for (int i = 0; i < mappings.size(); i++) {
                Map<String, String> m = mappings.get(i);
                if (m.get("variableName") == null || m.get("variableName").isBlank()) {
                    errors.add("输入变量映射[" + i + "]的variableName不能为空");
                }
                if (m.get("mappedKey") == null || m.get("mappedKey").isBlank()) {
                    errors.add("输入变量映射[" + i + "]的mappedKey不能为空");
                }
            }
        }

        // 知识库 RAG 参数验证
        Integer ragTopK = getInteger(config, "ragTopK");
        if (ragTopK != null && (ragTopK < 1 || ragTopK > 50)) {
            errors.add("RAG检索数量必须在1-50之间");
        }
        Double ragThreshold = getDouble(config, "ragThreshold");
        if (ragThreshold != null && (ragThreshold < 0 || ragThreshold > 1)) {
            errors.add("RAG相似度阈值必须在0-1之间");
        }

        // 历史消息数量验证
        Integer historyLimit = getInteger(config, "historyLimit");
        if (historyLimit != null && (historyLimit < 1 || historyLimit > 100)) {
            errors.add("历史消息数量必须在1-100之间");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateKnowledgeRetrievalConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        Object knowledgeBaseIds = config.get("knowledgeBaseIds");
        if (knowledgeBaseIds == null || (knowledgeBaseIds instanceof List && ((List<?>) knowledgeBaseIds).isEmpty())) {
            errors.add("知识库检索节点必须指定至少一个知识库ID");
        }

        String queryVariable = (String) config.get("queryVariable");
        if (queryVariable == null || queryVariable.isBlank()) {
            errors.add("知识库检索节点必须指定查询变量名");
        }

        Integer topK = getInteger(config, "topK");
        if (topK != null && (topK < 1 || topK > 50)) {
            errors.add("返回结果数量必须在1-50之间");
        }

        Double similarityThreshold = getDouble(config, "similarityThreshold");
        if (similarityThreshold != null && (similarityThreshold < 0 || similarityThreshold > 1)) {
            errors.add("相似度阈值必须在0-1之间");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateTextEmbeddingConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String model = (String) config.get("model");
        if (model == null || model.isBlank()) {
            errors.add("文本向量化节点必须指定模型");
        } else if (!SUPPORTED_EMBEDDING_MODELS.contains(model)) {
            errors.add("不支持的向量化模型: " + model + "，当前仅支持: " + SUPPORTED_EMBEDDING_MODELS);
        }

        String inputVariable = (String) config.get("inputVariable");
        String inputListVariable = (String) config.get("inputListVariable");
        if ((inputVariable == null || inputVariable.isBlank()) && 
            (inputListVariable == null || inputListVariable.isBlank())) {
            errors.add("文本向量化节点必须指定输入变量名或输入列表变量名");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateConditionConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        Object conditions = config.get("conditions");
        if (conditions == null || (conditions instanceof List && ((List<?>) conditions).isEmpty())) {
            errors.add("条件分支节点必须指定至少一个条件");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateSwitchConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String switchVariable = (String) config.get("switchVariable");
        if (switchVariable == null || switchVariable.isBlank()) {
            errors.add("多路分支节点必须指定判断变量名");
        }

        Object cases = config.get("cases");
        if (cases == null || (cases instanceof List && ((List<?>) cases).isEmpty())) {
            errors.add("多路分支节点必须指定至少一个case");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateLoopConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String loopType = (String) config.get("loopType");
        if (loopType == null || loopType.isBlank()) {
            errors.add("循环节点必须指定循环类型");
        } else {
            switch (loopType) {
                case "FOR_EACH" -> {
                    String iterableVariable = (String) config.get("iterableVariable");
                    if (iterableVariable == null || iterableVariable.isBlank()) {
                        errors.add("FOR_EACH循环必须指定遍历变量名");
                    }
                }
                case "WHILE" -> {
                    String whileCondition = (String) config.get("whileCondition");
                    if (whileCondition == null || whileCondition.isBlank()) {
                        errors.add("WHILE循环必须指定循环条件");
                    }
                }
                case "FOR_COUNT" -> {
                    Integer loopCount = getInteger(config, "loopCount");
                    if (loopCount == null || loopCount < 1) {
                        errors.add("FOR_COUNT循环必须指定有效的循环次数");
                    }
                }
            }
        }

        Integer maxIterations = getInteger(config, "maxIterations");
        if (maxIterations != null && maxIterations > 1000) {
            errors.add("最大循环次数不能超过1000");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateHttpRequestConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String url = (String) config.get("url");
        if (url == null || url.isBlank()) {
            errors.add("HTTP请求节点必须指定URL");
        }

        String method = (String) config.get("method");
        if (method == null || method.isBlank()) {
            errors.add("HTTP请求节点必须指定HTTP方法");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateDatabaseQueryConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String sql = (String) config.get("sql");
        if (sql == null || sql.isBlank()) {
            errors.add("数据库查询节点必须指定SQL语句");
        } else {
            // 检查是否包含危险操作关键字
            if (sql.matches("(?i).*\\b(INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE|GRANT|REVOKE|EXECUTE|EXEC)\\b.*")) {
                errors.add("数据库查询节点禁止执行修改操作（INSERT/UPDATE/DELETE/DROP等）");
            }
        }

        Integer maxRows = getInteger(config, "maxRows");
        if (maxRows != null && (maxRows < 1 || maxRows > 1000)) {
            errors.add("最大返回行数必须在1-1000之间");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    @SuppressWarnings("unchecked")
    private ValidationResult validateCodeConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String language = (String) config.get("language");
        if (language == null || language.isBlank()) {
            errors.add("代码执行节点必须指定编程语言");
        } else if (!Set.of("JAVASCRIPT", "JS", "PYTHON", "PY").contains(language.toUpperCase())) {
            errors.add("不支持的编程语言: " + language + "，当前支持: JAVASCRIPT, PYTHON");
        }

        String code = (String) config.get("code");
        if (code == null || code.isBlank()) {
            errors.add("代码执行节点必须指定代码内容");
        } else if ("PYTHON".equalsIgnoreCase(language) || "PY".equalsIgnoreCase(language)) {
            // Python 代码必须包含 main 函数
            if (!code.contains("def main")) {
                errors.add("Python 代码必须定义 def main(args) 函数作为入口");
            }
        }

        // 验证输入变量映射
        Object inputVars = config.get("inputVariables");
        if (inputVars instanceof List) {
            List<Map<String, Object>> inputList = (List<Map<String, Object>>) inputVars;
            for (int i = 0; i < inputList.size(); i++) {
                Map<String, Object> v = inputList.get(i);
                if (v.get("name") == null || ((String) v.get("name")).isBlank()) {
                    errors.add("输入变量[" + i + "]的脚本变量名(name)不能为空");
                }
                if (v.get("source") == null || ((String) v.get("source")).isBlank()) {
                    errors.add("输入变量[" + i + "]的来源变量(source)不能为空");
                }
            }
        }

        // 验证输出变量声明
        Object outputVars = config.get("outputVariables");
        if (outputVars instanceof List) {
            List<Map<String, Object>> outputList = (List<Map<String, Object>>) outputVars;
            for (int i = 0; i < outputList.size(); i++) {
                Map<String, Object> v = outputList.get(i);
                if (v.get("name") == null || ((String) v.get("name")).isBlank()) {
                    errors.add("输出变量[" + i + "]的变量名(name)不能为空");
                }
            }
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateTemplateConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String template = (String) config.get("template");
        Long templateId = getLong(config, "templateId");
        if ((template == null || template.isBlank()) && templateId == null) {
            errors.add("模板渲染节点必须指定模板内容或模板ID");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateVariableConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String operation = (String) config.get("operation");
        if (operation == null || operation.isBlank()) {
            errors.add("变量操作节点必须指定操作类型");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateJsonParseConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        // 兼容新旧字段名：inputVariable（新） / sourceVariable（旧）
        String inputVariable = (String) config.get("inputVariable");
        String sourceVariable = (String) config.get("sourceVariable");
        if ((inputVariable == null || inputVariable.isBlank()) && (sourceVariable == null || sourceVariable.isBlank())) {
            errors.add("JSON解析节点必须指定输入变量名（inputVariable 或 sourceVariable）");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    @SuppressWarnings("unchecked")
    private ValidationResult validateIntentRecognitionConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        // 兼容新旧字段名
        String inputVariable = (String) config.get("inputVariable");
        String textVariable = (String) config.get("textVariable");
        if ((inputVariable == null || inputVariable.isBlank()) && (textVariable == null || textVariable.isBlank())) {
            errors.add("意图识别节点必须指定输入变量名(inputVariable)");
        }

        Object intents = config.get("intents");
        if (intents == null || (intents instanceof List && ((List<?>) intents).isEmpty())) {
            errors.add("意图识别节点必须配置至少一个意图");
        } else if (intents instanceof List) {
            List<Map<String, Object>> intentList = (List<Map<String, Object>>) intents;
            for (int i = 0; i < intentList.size(); i++) {
                Map<String, Object> intent = intentList.get(i);
                String name = (String) intent.get("name");
                if (name == null || name.isBlank()) {
                    errors.add("意图[" + i + "]的名称(name)不能为空");
                }
            }
        }

        Double threshold = getDouble(config, "confidenceThreshold");
        if (threshold != null && (threshold < 0 || threshold > 1)) {
            errors.add("置信度阈值必须在0-1之间");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateEntityExtractionConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        // 兼容新旧字段名
        String inputVariable = (String) config.get("inputVariable");
        String textVariable = (String) config.get("textVariable");
        if ((inputVariable == null || inputVariable.isBlank()) && (textVariable == null || textVariable.isBlank())) {
            errors.add("实体抽取节点必须指定输入变量名(inputVariable)");
        }

        Object entityTypes = config.get("entityTypes");
        if (entityTypes == null || (entityTypes instanceof List && ((List<?>) entityTypes).isEmpty())) {
            errors.add("实体抽取节点必须指定至少一个实体类型(entityTypes)");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateParallelConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        Object branches = config.get("branches");
        if (branches == null || (branches instanceof List && ((List<?>) branches).isEmpty())) {
            errors.add("并行执行节点必须指定至少一个分支");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateResponseConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String responseType = (String) config.get("responseType");
        if (responseType == null || responseType.isBlank()) {
            errors.add("响应输出节点必须指定响应类型");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateStartConfig(Map<String, Object> config) {
        // 开始节点配置可选
        return ValidationResult.success();
    }

    private ValidationResult validateWebhookConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String path = (String) config.get("path");
        if (path == null || path.isBlank()) {
            errors.add("Webhook节点必须指定路径");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateScheduleConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String scheduleType = (String) config.get("scheduleType");
        if (scheduleType == null || scheduleType.isBlank()) {
            errors.add("定时触发节点必须指定调度类型");
        } else if ("CRON".equals(scheduleType)) {
            String cronExpression = (String) config.get("cronExpression");
            if (cronExpression == null || cronExpression.isBlank()) {
                errors.add("CRON调度必须指定Cron表达式");
            }
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateFileConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String operation = (String) config.get("operation");
        if (operation == null || operation.isBlank()) {
            errors.add("文件操作节点必须指定操作类型");
        }

        String filePath = (String) config.get("filePath");
        String filePathVariable = (String) config.get("filePathVariable");
        if ((filePath == null || filePath.isBlank()) && (filePathVariable == null || filePathVariable.isBlank())) {
            errors.add("文件操作节点必须指定文件路径或文件路径变量");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private Integer getInteger(Map<String, Object> config, String key) {
        Object value = config.get(key);
        if (value == null) return null;
        if (value instanceof Integer) return (Integer) value;
        if (value instanceof Number) return ((Number) value).intValue();
        return null;
    }

    private Long getLong(Map<String, Object> config, String key) {
        Object value = config.get(key);
        if (value == null) return null;
        if (value instanceof Long) return (Long) value;
        if (value instanceof Number) return ((Number) value).longValue();
        return null;
    }

    private Double getDouble(Map<String, Object> config, String key) {
        Object value = config.get(key);
        if (value == null) return null;
        if (value instanceof Double) return (Double) value;
        if (value instanceof Number) return ((Number) value).doubleValue();
        return null;
    }

    /**
     * 验证结果
     */
    public record ValidationResult(boolean valid, List<String> errors) {
        public static ValidationResult success() {
            return new ValidationResult(true, List.of());
        }

        public static ValidationResult failure(List<String> errors) {
            return new ValidationResult(false, errors);
        }

        public static ValidationResult failure(String error) {
            return new ValidationResult(false, List.of(error));
        }
    }
}
