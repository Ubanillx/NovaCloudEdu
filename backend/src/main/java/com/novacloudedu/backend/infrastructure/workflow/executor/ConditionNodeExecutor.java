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
 * 条件分支节点执行器 — 二路条件分支 (if-else)
 *
 * <h3>执行逻辑概览</h3>
 * <pre>
 * 1. 从 node.config 中读取配置，优先使用 "conditions" 多条件列表模式
 * 2. 多条件模式：按数组顺序逐个评估分支条件，首个匹配的分支生效
 *    - 每个分支可配置为 EXPRESSION（表达式）或 VARIABLE_COMPARE（变量比较）
 *    - 若所有分支均不匹配，走 "default" 分支
 * 3. 单条件模式（向后兼容）：读取 config.variable/operator/value，直接比较
 * 4. 输出 Map 包含：
 *    - branch     : "true" / "false" — 用于引擎路由出边 (sourceHandle 匹配)
 *    - matchedBranch : 匹配分支名 / "default" — 用于多条件模式的出边匹配
 *    - conditionResult : boolean — 是否有分支命中
 *    - matchedIndex    : int — 命中分支在 conditions 数组中的下标 (-1 = default)
 * </pre>
 *
 * <h3>引擎侧路由</h3>
 * DefaultWorkflowEngine.executeFromNode 收到输出后：
 * <ol>
 *   <li>遍历当前节点的出边列表</li>
 *   <li>用 edge.sourceHandle 与 output.branch / output.matchedBranch 做精确匹配</li>
 *   <li>找不到精确匹配时走 sourceHandle="default" 或空 handle 的 fallback 边</li>
 *   <li>如果仍无匹配边 → 抛出 IllegalStateException</li>
 * </ol>
 *
 * <h3>边界条件处理</h3>
 * <ul>
 *   <li>config 为 null → 使用空 Map，走单条件模式（variable="", operator="==", value=null → result=false）</li>
 *   <li>conditions 列表中某项 variable 和 compareValue 都为空 → 跳过该项（warn 日志）</li>
 *   <li>EXPRESSION 中引用的变量不存在 → 视为不匹配（不抛异常）</li>
 *   <li>数值比较失败时回退到字符串字典序比较</li>
 *   <li>input 为 null → 视为空 Map，所有变量解析返回 null</li>
 * </ul>
 *
 * <h3>支持的操作符</h3>
 * ==, !=, >, >=, <, <=, contains, startsWith, endsWith, isEmpty, isNotEmpty
 */
@Slf4j
@Component
public class ConditionNodeExecutor implements NodeExecutor {

    private static final Pattern VAR_PATTERN = Pattern.compile("\\$\\{([^}]+)}");
    private static final Pattern EXPR_PATTERN = Pattern.compile(
            "^\\s*(.+?)\\s*(==|!=|>=|<=|>|<|contains|startsWith|endsWith)\\s*(.+?)\\s*$",
            Pattern.CASE_INSENSITIVE
    );

    @Override
    public NodeType getNodeType() {
        return NodeType.CONDITION;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig() != null ? node.getConfig() : Map.of();
        if (input == null) input = Map.of();
        Map<String, Object> output = new HashMap<>();

        // 模式一：多条件分支列表
        List<Map<String, Object>> conditions = (List<Map<String, Object>>) config.get("conditions");
        if (conditions != null && !conditions.isEmpty()) {
            return evaluateConditions(conditions, input, config);
        }

        // 模式二：向后兼容旧的单条件
        String variableName = (String) config.getOrDefault("variable", "");
        String operator = (String) config.getOrDefault("operator", "==");
        if (operator == null) operator = "==";
        Object expectedValue = config.get("value");

        Object actualValue = resolveValue(variableName, input);
        boolean result = compareValues(actualValue, operator, expectedValue);

        log.info("条件节点执行(单条件): variable={}, operator={}, expected={}, actual={}, result={}",
                variableName, operator, expectedValue, actualValue, result);

        output.put("conditionResult", result);
        output.put("branch", result ? "true" : "false");
        output.put("matchedBranch", result ? "true" : "default");
        output.put("matchedIndex", result ? 0 : -1);
        return output;
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null) {
            throw new IllegalArgumentException("条件节点缺少配置");
        }
    }

    /**
     * 评估多条件分支列表，返回第一个匹配分支的信息。
     *
     * <p>遍历 conditions 数组，每个元素可以是：</p>
     * <ul>
     *   <li>EXPRESSION 模式 — 执行 evaluateExpression(expression, input)</li>
     *   <li>VARIABLE_COMPARE 模式 — 解析 variable 的值，与 compareValue 用 operator 比较</li>
     * </ul>
     * <p>首个匹配的分支立即返回，跳过后续分支评估。</p>
     * <p>无匹配时返回 branch="false", matchedBranch="default"。</p>
     *
     * @param conditions 前端配置的条件分支数组
     * @param input      当前节点的输入变量（即 execution.getVariables() 快照）
     * @param config     节点完整配置（用于获取 defaultTargetNodeId）
     * @return 路由结果 Map
     */
    private Map<String, Object> evaluateConditions(List<Map<String, Object>> conditions,
                                                     Map<String, Object> input,
                                                     Map<String, Object> config) {
        Map<String, Object> output = new HashMap<>();

        for (int i = 0; i < conditions.size(); i++) {
            Map<String, Object> branch = conditions.get(i);
            String branchName = (String) branch.getOrDefault("name", "条件 " + (i + 1));
            String conditionType = (String) branch.getOrDefault("conditionType", "VARIABLE_COMPARE");
            boolean matched;

            if ("EXPRESSION".equalsIgnoreCase(conditionType)) {
                String expression = (String) branch.getOrDefault("expression", "");
                matched = evaluateExpression(expression, input);
            } else {
                // VARIABLE_* 模式
                String variable = (String) branch.getOrDefault("variable", "");
                String operator = (String) branch.getOrDefault("operator", "==");
                if (operator == null) operator = "==";
                Object compareValue = branch.get("compareValue");

                // Fix #7: 空条件项保护 — variable 和 compareValue 都未配置时跳过
                if ((variable == null || variable.isBlank()) && compareValue == null) {
                    log.warn("条件分支[{}]配置不完整(variable和compareValue均为空)，跳过", branchName);
                    continue;
                }

                Object actualValue = resolveValue(variable, input);
                matched = compareValues(actualValue, operator, compareValue);
                log.debug("条件分支详情: variable='{}', actualValue={}, operator='{}', compareValue={}", 
                        variable, actualValue, operator, compareValue);
            }

            log.info("条件分支评估: name='{}', conditionType={}, matched={}", branchName, conditionType, matched);

            if (matched) {
                output.put("conditionResult", true);
                output.put("branch", "true");
                output.put("matchedBranch", branchName);
                output.put("matchedIndex", i);
                String targetNodeId = (String) branch.get("targetNodeId");
                if (targetNodeId != null) {
                    output.put("targetNodeId", targetNodeId);
                }
                return output;
            }
        }

        // 无分支匹配 → 走默认分支
        output.put("conditionResult", false);
        output.put("branch", "false");
        output.put("matchedBranch", "default");
        output.put("matchedIndex", -1);
        String defaultTarget = (String) config.get("defaultTargetNodeId");
        if (defaultTarget != null) {
            output.put("targetNodeId", defaultTarget);
        }
        return output;
    }

    /**
     * 评估表达式字符串，如 "${score} > 80" 或 "${name} contains 张"。
     *
     * <p>处理步骤：</p>
     * <ol>
     *   <li>扫描表达式中的 ${varName} 引用，任一变量不存在 → 直接返回 false（warn 日志）</li>
     *   <li>替换所有 ${varName} 为实际值的字符串形式</li>
     *   <li>尝试用正则 EXPR_PATTERN 解析为 "left operator right" 格式并比较</li>
     *   <li>回退: 尝试作为 boolean 字面量 (true/false)</li>
     *   <li>回退: 尝试作为数字，非零为 true</li>
     *   <li>回退: 非空字符串为 true</li>
     * </ol>
     *
     * @param expression 表达式字符串
     * @param input      变量上下文
     * @return 表达式评估结果
     */
    private boolean evaluateExpression(String expression, Map<String, Object> input) {
        if (expression == null || expression.isBlank()) {
            return false;
        }

        // 检查表达式中引用的变量是否存在（不存在则视为不匹配）
        Matcher varCheck = VAR_PATTERN.matcher(expression);
        while (varCheck.find()) {
            String varName = varCheck.group(1).trim();
            Object val = resolveValue(varName, input);
            if (val == null) {
                log.warn("表达式变量未找到(视为不匹配): variable='{}', expression='{}'", varName, expression);
                return false;
            }
        }

        // 替换变量引用 ${varName} → 实际值
        String resolved = resolveVariables(expression, input);

        // 尝试解析为 "left operator right" 格式
        Matcher m = EXPR_PATTERN.matcher(resolved);
        if (m.matches()) {
            String left = m.group(1).trim();
            String op = m.group(2).trim();
            String right = m.group(3).trim();

            // 去除引号
            left = stripQuotes(left);
            right = stripQuotes(right);

            return compareValues(left, op, right);
        }

        // 尝试作为布尔值解析
        resolved = resolved.trim();
        if ("true".equalsIgnoreCase(resolved)) return true;
        if ("false".equalsIgnoreCase(resolved)) return false;

        // 尝试作为数字：非零为 true
        try {
            return Double.parseDouble(resolved) != 0;
        } catch (NumberFormatException ignored) {}

        // 非空字符串为 true
        return !resolved.isEmpty();
    }

    /**
     * 替换表达式中的 ${variable} 引用为实际值的字符串形式。
     * 变量不存在时替换为空字符串 ""。
     */
    private String resolveVariables(String expression, Map<String, Object> input) {
        Matcher m = VAR_PATTERN.matcher(expression);
        StringBuffer sb = new StringBuffer();
        while (m.find()) {
            String varName = m.group(1).trim();
            Object value = resolveValue(varName, input);
            String replacement = value != null ? String.valueOf(value) : "";
            m.appendReplacement(sb, Matcher.quoteReplacement(replacement));
        }
        m.appendTail(sb);
        return sb.toString();
    }

    /**
     * 解析变量值，支持嵌套路径如 "node1.result"。
     *
     * <p>查找策略（按优先级）：</p>
     * <ol>
     *   <li>直接精确匹配 input[path]</li>
     *   <li>嵌套路径查找：按 "." 分割逐层深入 Map（如 "a.b.c" → input["a"]["b"]["c"]）</li>
     *   <li>回退：去掉节点名前缀，用路径最后一段查找（如 "开始.input" → input["input"]）</li>
     * </ol>
     * <p>前端使用 "{节点名}.{变量名}" 格式引用变量，但后端变量 map 中 key 只有简单名，
     * 因此第 3 步回退是必要的兼容处理。</p>
     *
     * @param path  变量路径
     * @param input 变量上下文 Map
     * @return 解析到的值，未找到返回 null
     */
    @SuppressWarnings("unchecked")
    private Object resolveValue(String path, Map<String, Object> input) {
        if (path == null || path.isBlank()) return null;

        // 1. 直接精确匹配
        if (input.containsKey(path)) {
            return input.get(path);
        }

        // 2. 嵌套路径查找 (e.g. "a.b.c" → input["a"]["b"]["c"])
        String[] parts = path.split("\\.");
        if (parts.length > 1) {
            Object current = input;
            boolean resolved = true;
            for (String part : parts) {
                if (current instanceof Map) {
                    current = ((Map<String, Object>) current).get(part);
                } else {
                    resolved = false;
                    break;
                }
                if (current == null) { resolved = false; break; }
            }
            if (resolved && current != null) {
                return current;
            }

            // 3. 回退：去掉节点名前缀，用最后一段查找 (e.g. "开始.input" → "input")
            String lastPart = parts[parts.length - 1];
            if (input.containsKey(lastPart)) {
                log.debug("变量回退解析: '{}' → '{}'", path, lastPart);
                return input.get(lastPart);
            }
        }

        return null;
    }

    /**
     * 比较两个值，支持多种操作符。
     *
     * <p>特殊处理：</p>
     * <ul>
     *   <li>两者都为 null → 仅 == 返回 true</li>
     *   <li>只有一个为 null → 仅 != 返回 true</li>
     *   <li>== 比较时先尝试数值相等（兼容 1.0 == "1"），再回退字符串相等</li>
     *   <li>>, >=, <, <= 先尝试数值比较，解析失败回退为字符串字典序</li>
     *   <li>contains/startsWith/endsWith 基于字符串操作</li>
     *   <li>isEmpty/isNotEmpty 判断字符串是否为空</li>
     * </ul>
     *
     * @param actual   实际值
     * @param operator 操作符
     * @param expected 期望值
     * @return 比较结果
     */
    private boolean compareValues(Object actual, String operator, Object expected) {
        if (actual == null && expected == null) {
            return "==".equals(operator) || "equals".equalsIgnoreCase(operator);
        }
        if (actual == null || expected == null) {
            return "!=".equals(operator) || "notEquals".equalsIgnoreCase(operator);
        }

        String actualStr = String.valueOf(actual);
        String expectedStr = String.valueOf(expected);

        switch (operator.toLowerCase()) {
            case "==", "equals", "eq", "equal" -> {
                // 先尝试数字比较（兼容 1.0 == "1" 的场景）
                if (numericEquals(actualStr, expectedStr)) return true;
                return actualStr.equals(expectedStr);
            }
            case "!=", "notequals", "ne", "not_equals" -> {
                if (numericEquals(actualStr, expectedStr)) return false;
                return !actualStr.equals(expectedStr);
            }
            case ">", "greaterthan", "gt" -> {
                return compareNumbers(actualStr, expectedStr) > 0;
            }
            case ">=", "greaterthanorequals", "gte" -> {
                return compareNumbers(actualStr, expectedStr) >= 0;
            }
            case "<", "lessthan", "lt" -> {
                return compareNumbers(actualStr, expectedStr) < 0;
            }
            case "<=", "lessthanorequals", "lte" -> {
                return compareNumbers(actualStr, expectedStr) <= 0;
            }
            case "contains" -> {
                return actualStr.contains(expectedStr);
            }
            case "startswith", "starts_with" -> {
                return actualStr.startsWith(expectedStr);
            }
            case "endswith", "ends_with" -> {
                return actualStr.endsWith(expectedStr);
            }
            case "isempty", "is_empty" -> {
                return actualStr.isEmpty();
            }
            case "isnotempty", "is_not_empty" -> {
                return !actualStr.isEmpty();
            }
            default -> {
                log.warn("未知的操作符: {}", operator);
                return false;
            }
        }
    }

    private boolean numericEquals(String a, String b) {
        try {
            double numA = Double.parseDouble(a);
            double numB = Double.parseDouble(b);
            return Double.compare(numA, numB) == 0;
        } catch (NumberFormatException e) {
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

    private String stripQuotes(String s) {
        if (s.length() >= 2) {
            if ((s.startsWith("\"") && s.endsWith("\"")) || (s.startsWith("'") && s.endsWith("'"))) {
                return s.substring(1, s.length() - 1);
            }
        }
        return s;
    }
}
