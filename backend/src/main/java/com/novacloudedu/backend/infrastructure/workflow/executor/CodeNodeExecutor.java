package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import java.util.HashMap;
import java.util.Map;

/**
 * 代码执行节点执行器（支持JavaScript）
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class CodeNodeExecutor implements NodeExecutor {

    private final ObjectMapper objectMapper;

    @Override
    public NodeType getNodeType() {
        return NodeType.CODE;
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String code = (String) config.getOrDefault("code", "");
        String language = (String) config.getOrDefault("language", "javascript");
        
        if (code.isEmpty()) {
            log.warn("代码节点: 代码为空");
            return new HashMap<>();
        }

        log.info("代码节点执行: language={}, code长度={}", language, code.length());

        try {
            if ("javascript".equalsIgnoreCase(language) || "js".equalsIgnoreCase(language)) {
                return executeJavaScript(code, input);
            } else {
                throw new UnsupportedOperationException("不支持的脚本语言: " + language);
            }
        } catch (Exception e) {
            log.error("代码执行失败", e);
            throw new RuntimeException("代码执行失败: " + e.getMessage(), e);
        }
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null || !node.getConfig().containsKey("code")) {
            throw new IllegalArgumentException("代码节点缺少code配置");
        }
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> executeJavaScript(String code, Map<String, Object> input) throws ScriptException {
        ScriptEngineManager manager = new ScriptEngineManager();
        ScriptEngine engine = manager.getEngineByName("nashorn");
        
        if (engine == null) {
            // Nashorn在Java 15+被移除，尝试使用GraalJS或返回简单处理
            log.warn("Nashorn引擎不可用，使用简化处理");
            return executeSimpleExpression(code, input);
        }

        // 将输入变量绑定到脚本引擎
        for (Map.Entry<String, Object> entry : input.entrySet()) {
            engine.put(entry.getKey(), entry.getValue());
        }
        
        // 添加辅助函数
        engine.put("JSON", new JsonHelper(objectMapper));

        Object result = engine.eval(code);
        
        Map<String, Object> output = new HashMap<>();
        if (result instanceof Map) {
            output.putAll((Map<String, Object>) result);
        } else {
            output.put("result", result);
        }
        
        return output;
    }

    private Map<String, Object> executeSimpleExpression(String code, Map<String, Object> input) {
        Map<String, Object> result = new HashMap<>();
        
        // 简单的表达式处理
        // 支持 return xxx; 格式
        String trimmedCode = code.trim();
        if (trimmedCode.startsWith("return ") && trimmedCode.endsWith(";")) {
            String expression = trimmedCode.substring(7, trimmedCode.length() - 1).trim();
            
            // 简单变量引用
            if (input.containsKey(expression)) {
                result.put("result", input.get(expression));
            } else {
                result.put("result", expression);
            }
        } else {
            result.put("result", null);
            result.put("warning", "复杂代码需要JavaScript引擎支持");
        }
        
        return result;
    }

    public static class JsonHelper {
        private final ObjectMapper objectMapper;

        public JsonHelper(ObjectMapper objectMapper) {
            this.objectMapper = objectMapper;
        }

        public String stringify(Object obj) {
            try {
                return objectMapper.writeValueAsString(obj);
            } catch (Exception e) {
                return "{}";
            }
        }

        public Object parse(String json) {
            try {
                return objectMapper.readValue(json, Object.class);
            } catch (Exception e) {
                return null;
            }
        }
    }
}
