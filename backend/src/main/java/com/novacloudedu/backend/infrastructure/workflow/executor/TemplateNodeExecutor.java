package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 模板渲染节点执行器
 */
@Slf4j
@Component
public class TemplateNodeExecutor implements NodeExecutor {

    private static final Pattern VARIABLE_PATTERN = Pattern.compile("\\{\\{([^}]+)}}");

    @Override
    public NodeType getNodeType() {
        return NodeType.TEMPLATE;
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String template = (String) config.getOrDefault("template", "");
        String outputVariable = (String) config.getOrDefault("outputVariable", "templateOutput");

        String result = renderTemplate(template, input);

        log.info("模板渲染节点执行: 模板长度={}, 输出长度={}", template.length(), result.length());

        Map<String, Object> output = new HashMap<>();
        output.put(outputVariable, result);
        output.put("renderedTemplate", result);
        
        return output;
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null || !node.getConfig().containsKey("template")) {
            throw new IllegalArgumentException("模板节点缺少template配置");
        }
    }

    private String renderTemplate(String template, Map<String, Object> variables) {
        if (template == null || template.isEmpty()) {
            return "";
        }

        StringBuffer result = new StringBuffer();
        Matcher matcher = VARIABLE_PATTERN.matcher(template);

        while (matcher.find()) {
            String varName = matcher.group(1).trim();
            Object value = getNestedValue(varName, variables);
            String replacement = value != null ? String.valueOf(value) : "";
            matcher.appendReplacement(result, Matcher.quoteReplacement(replacement));
        }
        matcher.appendTail(result);

        return result.toString();
    }

    private Object getNestedValue(String path, Map<String, Object> variables) {
        String[] parts = path.split("\\.");
        Object current = variables;

        for (String part : parts) {
            if (current instanceof Map) {
                current = ((Map<?, ?>) current).get(part);
            } else {
                return null;
            }
            if (current == null) {
                return null;
            }
        }

        return current;
    }
}
