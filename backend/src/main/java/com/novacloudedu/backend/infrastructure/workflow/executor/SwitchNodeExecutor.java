package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 多路分支 (Switch) 节点执行器 — 多路条件分支 (switch-case)
 *
 * <h3>执行逻辑概览</h3>
 * <pre>
 * 1. 从 node.config 读取 switchVariable（或 variable），解析其当前值 actualValue
 * 2. 遍历 config.cases 数组，对每个 case 项按以下优先级匹配：
 *    a. expression 不为空 → 执行表达式评估（与 ConditionNodeExecutor 相同的表达式引擎）
 *    b. values 列表存在 → 检查 actualValue 是否在列表中（多值匹配）
 *    c. value 单值存在 → 检查 actualValue 是否等于该值（字符串相等）
 * 3. 首个匹配的 case 立即返回，跳过后续 case
 * 4. 无匹配时走 "default" 分支
 * </pre>
 *
 * <h3>输出 Map</h3>
 * <ul>
 *   <li>switchValue    : 实际变量值（字符串形式）</li>
 *   <li>matchedBranch  : 匹配的 case 名称 / "default"</li>
 *   <li>matchedIndex   : 匹配 case 在数组中的下标 (-1 = default)</li>
 *   <li>branch         : 同 matchedBranch，用于引擎出边路由</li>
 * </ul>
 *
 * <h3>引擎侧路由</h3>
 * DefaultWorkflowEngine.executeFromNode 收到输出后：
 * <ol>
 *   <li>用 edge.sourceHandle 与 output.branch (case名) 做精确匹配</li>
 *   <li>无精确匹配时走 sourceHandle="default" 的 fallback 边</li>
 *   <li>仍无匹配 → 抛出 IllegalStateException</li>
 * </ol>
 *
 * <h3>边界条件处理</h3>
 * <ul>
 *   <li>config 为 null → 使用空 Map, switchVariable="", cases=空列表 → 走 default</li>
 *   <li>actualValue 为 null → 转为空字符串 "" 参与比较</li>
 *   <li>case.expression 中变量不存在 → 视为不匹配</li>
 *   <li>case.values 为 null → 跳过多值匹配</li>
 *   <li>input 为 null → 视为空 Map</li>
 * </ul>
 */
@Slf4j
@Component
public class SwitchNodeExecutor implements NodeExecutor {

    private static final Pattern VAR_PATTERN = Pattern.compile("\\$\\{([^}]+)}");
    private static final Pattern EXPR_PATTERN = Pattern.compile(
            "^\\s*(.+?)\\s*(==|!=|>=|<=|>|<|contains|startsWith|endsWith)\\s*(.+?)\\s*$",
            Pattern.CASE_INSENSITIVE
    );

    @Override
    public NodeType getNodeType() {
        return NodeType.SWITCH;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig() != null ? node.getConfig() : Map.of();
        if (input == null) input = Map.of();

        // 兼容 switchVariable 和 variable 两种写法
        String variableName = (String) config.getOrDefault("switchVariable",
                config.getOrDefault("variable", ""));
        if (variableName == null) variableName = "";
        List<Map<String, Object>> cases = (List<Map<String, Object>>) config.getOrDefault("cases", List.of());
        if (cases == null) cases = List.of();
        String defaultTargetNodeId = (String) config.get("defaultTargetNodeId");

        Object actualValue = resolveValue(variableName, input);
        String actualValueStr = actualValue != null ? String.valueOf(actualValue) : "";

        log.info("Switch节点执行: variable={}, value={}, casesCount={}",
                variableName, actualValueStr, cases.size());

        Map<String, Object> result = new HashMap<>();
        result.put("switchValue", actualValueStr);

        for (int i = 0; i < cases.size(); i++) {
            Map<String, Object> caseItem = cases.get(i);
            String caseName = (String) caseItem.getOrDefault("name", "case_" + i);

            boolean matched = false;

            // 方式1: 表达式匹配
            String expression = (String) caseItem.get("expression");
            if (expression != null && !expression.isBlank()) {
                matched = evaluateExpression(expression, input);
            }
            // 方式2: 多值匹配
            else if (caseItem.containsKey("values")) {
                List<Object> values = (List<Object>) caseItem.get("values");
                if (values != null) {
                    matched = values.stream()
                            .anyMatch(v -> String.valueOf(v).equals(actualValueStr));
                }
            }
            // 方式3: 单值匹配
            else {
                Object caseValue = caseItem.get("value");
                if (caseValue != null) {
                    matched = String.valueOf(caseValue).equals(actualValueStr);
                }
            }

            if (matched) {
                result.put("matchedBranch", caseName);
                result.put("matchedIndex", i);
                result.put("branch", caseName);
                String targetNodeId = (String) caseItem.get("targetNodeId");
                if (targetNodeId != null) {
                    result.put("targetNodeId", targetNodeId);
                }
                log.info("Switch匹配: case='{}', index={}", caseName, i);
                return result;
            }
        }

        // 无匹配 → 走默认分支
        result.put("matchedBranch", "default");
        result.put("matchedIndex", -1);
        result.put("branch", "default");
        if (defaultTargetNodeId != null) {
            result.put("targetNodeId", defaultTargetNodeId);
        }
        log.info("Switch无匹配，走默认分支");
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null) {
            throw new IllegalArgumentException("Switch节点缺少配置");
        }
    }

    private boolean evaluateExpression(String expression, Map<String, Object> input) {
        if (expression == null || expression.isBlank()) return false;

        // 检查表达式中引用的变量是否存在（不存在则视为不匹配）
        Matcher varCheck = VAR_PATTERN.matcher(expression);
        while (varCheck.find()) {
            String varName = varCheck.group(1).trim();
            Object val = resolveValue(varName, input);
            if (val == null) {
                log.warn("Switch表达式变量未找到(视为不匹配): variable='{}', expression='{}'", varName, expression);
                return false;
            }
        }

        String resolved = resolveVariables(expression, input);
        Matcher m = EXPR_PATTERN.matcher(resolved);
        if (m.matches()) {
            String left = stripQuotes(m.group(1).trim());
            String op = m.group(2).trim();
            String right = stripQuotes(m.group(3).trim());
            return compare(left, op, right);
        }
        resolved = resolved.trim();
        if ("true".equalsIgnoreCase(resolved)) return true;
        if ("false".equalsIgnoreCase(resolved)) return false;
        return !resolved.isEmpty();
    }

    private String resolveVariables(String expr, Map<String, Object> input) {
        Matcher m = VAR_PATTERN.matcher(expr);
        StringBuffer sb = new StringBuffer();
        while (m.find()) {
            Object val = resolveValue(m.group(1).trim(), input);
            m.appendReplacement(sb, Matcher.quoteReplacement(val != null ? String.valueOf(val) : ""));
        }
        m.appendTail(sb);
        return sb.toString();
    }

    @SuppressWarnings("unchecked")
    private Object resolveValue(String path, Map<String, Object> input) {
        if (path == null || path.isBlank()) return null;
        if (input.containsKey(path)) return input.get(path);
        String[] parts = path.split("\\.");
        if (parts.length > 1) {
            // 嵌套路径查找 (e.g. "a.b.c" → input["a"]["b"]["c"])
            Object current = input;
            boolean resolved = true;
            for (String part : parts) {
                if (current instanceof Map) current = ((Map<String, Object>) current).get(part);
                else { resolved = false; break; }
                if (current == null) { resolved = false; break; }
            }
            if (resolved && current != null) return current;

            // 回退：去掉节点名前缀，用最后一段查找 (e.g. "开始.input" → "input")
            String lastPart = parts[parts.length - 1];
            if (input.containsKey(lastPart)) {
                log.debug("Switch变量回退解析: '{}' → '{}'", path, lastPart);
                return input.get(lastPart);
            }
        }
        return null;
    }

    private boolean compare(String a, String op, String b) {
        switch (op.toLowerCase()) {
            case "==", "equals", "eq", "equal" -> {
                // 先尝试数值比较（兼容 1.0 == "1" 的场景），与 ConditionNodeExecutor 保持一致
                if (numEq(a, b)) return true;
                return a.equals(b);
            }
            case "!=", "notequals", "ne", "not_equals" -> {
                if (numEq(a, b)) return false;
                return !a.equals(b);
            }
            case ">", "greaterthan", "gt" -> { return compareNum(a, b) > 0; }
            case ">=", "greaterthanorequals", "gte" -> { return compareNum(a, b) >= 0; }
            case "<", "lessthan", "lt" -> { return compareNum(a, b) < 0; }
            case "<=", "lessthanorequals", "lte" -> { return compareNum(a, b) <= 0; }
            case "contains" -> { return a.contains(b); }
            case "startswith", "starts_with" -> { return a.startsWith(b); }
            case "endswith", "ends_with" -> { return a.endsWith(b); }
            case "isempty", "is_empty" -> { return a.isEmpty(); }
            case "isnotempty", "is_not_empty" -> { return !a.isEmpty(); }
            default -> {
                log.warn("Switch节点未知的操作符: {}", op);
                return false;
            }
        }
    }

    private boolean numEq(String a, String b) {
        try { return Double.compare(Double.parseDouble(a), Double.parseDouble(b)) == 0; }
        catch (NumberFormatException e) { return false; }
    }

    private int compareNum(String a, String b) {
        try { return Double.compare(Double.parseDouble(a), Double.parseDouble(b)); }
        catch (NumberFormatException e) { return a.compareTo(b); }
    }

    private String stripQuotes(String s) {
        if (s.length() >= 2 && ((s.startsWith("\"") && s.endsWith("\"")) || (s.startsWith("'") && s.endsWith("'")))) {
            return s.substring(1, s.length() - 1);
        }
        return s;
    }
}
