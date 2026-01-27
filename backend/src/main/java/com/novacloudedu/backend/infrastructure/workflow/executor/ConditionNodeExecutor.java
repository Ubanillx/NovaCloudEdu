package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 条件分支节点执行器
 */
@Slf4j
@Component
public class ConditionNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.CONDITION;
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String variableName = (String) config.getOrDefault("variable", "");
        String operator = (String) config.getOrDefault("operator", "==");
        Object expectedValue = config.get("value");
        
        Object actualValue = input.get(variableName);
        
        boolean result = evaluate(actualValue, operator, expectedValue);
        
        log.info("条件节点执行: variable={}, operator={}, expected={}, actual={}, result={}", 
                variableName, operator, expectedValue, actualValue, result);

        Map<String, Object> output = new HashMap<>();
        output.put("conditionResult", result);
        output.put("branch", result ? "true" : "false");
        
        return output;
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null) {
            throw new IllegalArgumentException("条件节点缺少配置");
        }
    }

    private boolean evaluate(Object actual, String operator, Object expected) {
        if (actual == null && expected == null) {
            return "==".equals(operator);
        }
        if (actual == null || expected == null) {
            return "!=".equals(operator);
        }

        String actualStr = String.valueOf(actual);
        String expectedStr = String.valueOf(expected);

        switch (operator) {
            case "==":
            case "equals":
            case "eq":
                return actualStr.equals(expectedStr);
            case "!=":
            case "notEquals":
            case "ne":
                return !actualStr.equals(expectedStr);
            case ">":
            case "greaterThan":
            case "gt":
                return compareNumbers(actualStr, expectedStr) > 0;
            case ">=":
            case "greaterThanOrEquals":
            case "gte":
                return compareNumbers(actualStr, expectedStr) >= 0;
            case "<":
            case "lessThan":
            case "lt":
                return compareNumbers(actualStr, expectedStr) < 0;
            case "<=":
            case "lessThanOrEquals":
            case "lte":
                return compareNumbers(actualStr, expectedStr) <= 0;
            case "contains":
                return actualStr.contains(expectedStr);
            case "startsWith":
                return actualStr.startsWith(expectedStr);
            case "endsWith":
                return actualStr.endsWith(expectedStr);
            case "isEmpty":
                return actualStr.isEmpty();
            case "isNotEmpty":
                return !actualStr.isEmpty();
            default:
                log.warn("未知的操作符: {}", operator);
                return false;
        }
    }

    private int compareNumbers(String a, String b) {
        try {
            double numA = Double.parseDouble(a);
            double numB = Double.parseDouble(b);
            return Double.compare(numA, numB);
        } catch (NumberFormatException e) {
            return a.compareTo(b);
        }
    }
}
