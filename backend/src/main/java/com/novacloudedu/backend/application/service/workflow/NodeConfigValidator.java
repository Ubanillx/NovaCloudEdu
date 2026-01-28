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

    private static final Set<String> SUPPORTED_LLM_MODELS = Set.of(
            "qwen-max", "qwen-plus", "qwen-turbo", "qwen-long", "qwen-vl-max", "qwen-vl-plus"
    );

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
            case END, MERGE -> ValidationResult.success();
        };
    }

    private ValidationResult validateLlmConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String model = (String) config.get("model");
        if (model == null || model.isBlank()) {
            errors.add("LLM节点必须指定模型");
        } else if (!SUPPORTED_LLM_MODELS.contains(model)) {
            errors.add("不支持的模型: " + model + "，当前仅支持千问系列: " + SUPPORTED_LLM_MODELS);
        }

        String userPromptTemplate = (String) config.get("userPromptTemplate");
        if (userPromptTemplate == null || userPromptTemplate.isBlank()) {
            errors.add("LLM节点必须指定用户提示词模板");
        }

        Double temperature = getDouble(config, "temperature");
        if (temperature != null && (temperature < 0 || temperature > 2)) {
            errors.add("温度参数必须在0-2之间");
        }

        Integer maxTokens = getInteger(config, "maxTokens");
        if (maxTokens != null && (maxTokens < 1 || maxTokens > 8192)) {
            errors.add("最大token数必须在1-8192之间");
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
        }

        Long dataSourceId = getLong(config, "dataSourceId");
        String dataSourceName = (String) config.get("dataSourceName");
        if (dataSourceId == null && (dataSourceName == null || dataSourceName.isBlank())) {
            errors.add("数据库查询节点必须指定数据源ID或数据源名称");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateCodeConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String language = (String) config.get("language");
        if (language == null || language.isBlank()) {
            errors.add("代码执行节点必须指定编程语言");
        } else if (!Set.of("JAVASCRIPT", "PYTHON", "GROOVY").contains(language)) {
            errors.add("不支持的编程语言: " + language);
        }

        String code = (String) config.get("code");
        if (code == null || code.isBlank()) {
            errors.add("代码执行节点必须指定代码内容");
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

        String inputVariable = (String) config.get("inputVariable");
        if (inputVariable == null || inputVariable.isBlank()) {
            errors.add("JSON解析节点必须指定输入变量名");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateIntentRecognitionConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String inputVariable = (String) config.get("inputVariable");
        if (inputVariable == null || inputVariable.isBlank()) {
            errors.add("意图识别节点必须指定输入变量名");
        }

        return errors.isEmpty() ? ValidationResult.success() : ValidationResult.failure(errors);
    }

    private ValidationResult validateEntityExtractionConfig(Map<String, Object> config) {
        List<String> errors = new ArrayList<>();

        String inputVariable = (String) config.get("inputVariable");
        if (inputVariable == null || inputVariable.isBlank()) {
            errors.add("实体抽取节点必须指定输入变量名");
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
