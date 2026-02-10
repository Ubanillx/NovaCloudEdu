package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 循环节点执行器
 *
 * <h3>重要：两种执行路径</h3>
 * <ol>
 *   <li><b>容器模式（主要路径）</b>：当 LOOP 节点包含子节点时，由
 *       {@code DefaultWorkflowEngine.executeLoopContainer()} 直接处理，
 *       不会调用本执行器。容器模式会在每次迭代中实际执行循环体子节点。</li>
 *   <li><b>Fallback 模式（本执行器）</b>：当 LOOP 节点没有子节点时，引擎会调用本执行器。
 *       此模式仅收集迭代元数据（item/index），不执行子节点。</li>
 * </ol>
 *
 * <h3>支持的循环类型</h3>
 * <ul>
 *   <li><b>FOR_EACH / forEach</b>：遍历数组变量，每次迭代设置 itemVariable 和 indexVariable</li>
 *   <li><b>FOR_COUNT / times</b>：指定次数循环，每次迭代设置 counterVariable 和 indexVariable</li>
 *   <li><b>WHILE</b>：条件循环，每次迭代前重新评估 whileCondition 表达式</li>
 * </ul>
 *
 * <h3>输出 Map</h3>
 * <ul>
 *   <li>resultVariable (默认 "loopResults") : List&lt;Map&gt; — 每次迭代的元数据</li>
 *   <li>loopCount      : int — 实际迭代次数</li>
 *   <li>loopCompleted  : boolean — 循环是否正常完成</li>
 * </ul>
 *
 * <h3>引擎侧处理（容器模式）</h3>
 * <pre>
 * DefaultWorkflowEngine.executeFromNode 中：
 * 1. 检测到 LOOP + 有子节点 → 调用 executeLoopContainer()
 * 2. 通过 sourceHandle="loop-start" 的边找到循环体入口节点
 * 3. 根据 loopType 执行迭代，每次迭代调用 executeFromNode(入口节点)
 * 4. 循环体内节点走到 LOOP_END 或无出边时自然结束当前迭代
 * 5. 循环结束后走 sourceHandle="output" 的边继续后续节点
 * 6. 支持 _loopBreak 变量提前跳出循环
 * </pre>
 *
 * <h3>边界条件处理</h3>
 * <ul>
 *   <li>config 为 null → 使用默认值（loopType=forEach, maxIterations=100）</li>
 *   <li>loopType 为 null → 默认 forEach</li>
 *   <li>FOR_EACH 的数组变量为 null / 非数组 → 视为空数组，循环 0 次</li>
 *   <li>迭代次数超过 maxIterations → 截断并 warn</li>
 *   <li>WHILE 条件变量不存在 → 视为 false，终止循环（避免死循环）</li>
 * </ul>
 */
@Slf4j
@Component
public class LoopNodeExecutor implements NodeExecutor {

    private static final Pattern VAR_PATTERN = Pattern.compile("\\$\\{([^}]+)}");
    private static final Pattern EXPR_PATTERN = Pattern.compile(
            "^\\s*(.+?)\\s*(==|!=|>=|<=|>|<|contains|startsWith|endsWith)\\s*(.+?)\\s*$",
            Pattern.CASE_INSENSITIVE
    );

    @Override
    public NodeType getNodeType() {
        return NodeType.LOOP;
    }

    /**
     * Fallback 执行：当 LOOP 节点没有子节点时由引擎调用。
     * 仅收集迭代元数据（item/index）并设置到 context 中，不执行子节点。
     * 带子节点的循环容器由 {@code DefaultWorkflowEngine.executeLoopContainer()} 处理。
     */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig() != null ? node.getConfig() : Map.of();
        if (input == null) input = Map.of();

        String loopType = (String) config.getOrDefault("loopType", "forEach");
        if (loopType == null) loopType = "forEach";
        String itemVariable = (String) config.getOrDefault("itemVariable", "item");
        if (itemVariable == null || itemVariable.isBlank()) itemVariable = "item";
        String indexVariable = (String) config.getOrDefault("indexVariable", "index");
        if (indexVariable == null || indexVariable.isBlank()) indexVariable = "index";
        int maxIterations = getInt(config, "maxIterations", 100);
        if (maxIterations <= 0) {
            log.warn("循环节点[{}] maxIterations={} 无效，已修正为默认值100", node.getId(), maxIterations);
            maxIterations = 100;
        }
        String resultVariable = (String) config.getOrDefault("resultVariable", "loopResults");
        if (resultVariable == null || resultVariable.isBlank()) resultVariable = "loopResults";

        List<Map<String, Object>> results = new ArrayList<>();

        switch (loopType.toUpperCase()) {
            case "FOREACH", "FOR_EACH" -> {
                // 兼容 iterableVariable 和 itemsVariable
                String itemsVar = (String) config.getOrDefault("iterableVariable",
                        config.getOrDefault("itemsVariable", "items"));
                Object itemsObj = resolveValue(itemsVar, input);
                List<Object> items = itemsObj instanceof List ? (List<Object>) itemsObj : new ArrayList<>();

                log.info("循环节点(FOR_EACH): 数组变量={}, 元素数={}", itemsVar, items.size());

                if (items.size() > maxIterations) {
                    log.warn("循环节点(FOR_EACH)[{}]: 数组元素数({})超过maxIterations({})，将截断", node.getId(), items.size(), maxIterations);
                }
                int index = 0;
                for (Object item : items) {
                    if (index >= maxIterations) {
                        break;
                    }
                    Map<String, Object> iterResult = new HashMap<>();
                    iterResult.put(itemVariable, item);
                    iterResult.put(indexVariable, index);
                    results.add(iterResult);

                    context.setVariable(itemVariable, item);
                    context.setVariable(indexVariable, index);
                    index++;
                }
            }
            case "TIMES", "FOR_COUNT" -> {
                int loopCount = getInt(config, "loopCount", getInt(config, "times", 1));
                String counterVar = (String) config.getOrDefault("counterVariable", indexVariable);
                if (counterVar == null || counterVar.isBlank()) counterVar = indexVariable;

                if (loopCount <= 0) {
                    log.warn("循环节点(FOR_COUNT)[{}]: loopCount={} 无效，循环不会执行", node.getId(), loopCount);
                }
                log.info("循环节点(FOR_COUNT): 次数={}", loopCount);

                for (int i = 0; i < Math.min(loopCount, maxIterations); i++) {
                    Map<String, Object> iterResult = new HashMap<>();
                    iterResult.put(counterVar, i);
                    iterResult.put(indexVariable, i);
                    results.add(iterResult);

                    context.setVariable(counterVar, i);
                    context.setVariable(indexVariable, i);
                }
            }
            case "WHILE" -> {
                // 注意：此执行器仅用于无子节点的 LOOP 节点（fallback 模式）。
                // 带子节点的循环容器由 DefaultWorkflowEngine.executeLoopContainer() 处理，
                // 该方法会在每次迭代中实际执行循环体子节点。
                // 此处 WHILE 循环仅收集迭代元数据，条件变量的变化依赖于 context 中的外部修改。
                String whileCondition = (String) config.getOrDefault("whileCondition", "false");

                log.info("循环节点(WHILE): 条件={}", whileCondition);

                int index = 0;
                while (index < maxIterations) {
                    // 每次迭代重新评估条件（变量可能被循环体修改）
                    Map<String, Object> evalContext = new HashMap<>(input);
                    evalContext.put(indexVariable, index);
                    // 合并上下文中的最新变量
                    evalContext.putAll(context.getVariables());

                    if (!evaluateExpression(whileCondition, evalContext)) {
                        break;
                    }

                    Map<String, Object> iterResult = new HashMap<>();
                    iterResult.put(indexVariable, index);
                    results.add(iterResult);

                    context.setVariable(indexVariable, index);
                    index++;
                }
            }
            default -> {
                log.warn("未知的循环类型: {}", loopType);
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put(resultVariable, results);
        result.put("loopCount", results.size());
        result.put("loopCompleted", true);

        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        if (node.getConfig() == null) {
            log.warn("循环节点[{}]缺少配置，将使用默认值", node.getId());
        }
    }

    private boolean evaluateExpression(String expression, Map<String, Object> input) {
        if (expression == null || expression.isBlank()) return false;

        // 检查表达式中引用的变量是否存在（不存在则终止循环，避免死循环）
        Matcher varCheck = VAR_PATTERN.matcher(expression);
        while (varCheck.find()) {
            String varName = varCheck.group(1).trim();
            Object val = resolveValue(varName, input);
            if (val == null) {
                log.warn("循环条件变量未找到(终止循环): variable='{}', expression='{}'", varName, expression);
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
        try { return Double.parseDouble(resolved) != 0; } catch (NumberFormatException ignored) {}
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
            // 嵌套路径查找
            Object current = input;
            boolean resolved = true;
            for (String part : parts) {
                if (current instanceof Map) current = ((Map<String, Object>) current).get(part);
                else { resolved = false; break; }
                if (current == null) { resolved = false; break; }
            }
            if (resolved && current != null) return current;

            // 回退：去掉节点名前缀，用最后一段查找
            String lastPart = parts[parts.length - 1];
            if (input.containsKey(lastPart)) {
                log.debug("Loop变量回退解析: '{}' → '{}'", path, lastPart);
                return input.get(lastPart);
            }
        }
        return null;
    }

    private boolean compare(String a, String op, String b) {
        switch (op.toLowerCase()) {
            case "==", "equals", "eq", "equal" -> {
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
                log.warn("循环节点未知的操作符: {}", op);
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

    private int getInt(Map<String, Object> config, String key, int defaultValue) {
        Object val = config.get(key);
        if (val instanceof Number) return ((Number) val).intValue();
        if (val instanceof String) {
            try { return Integer.parseInt((String) val); } catch (NumberFormatException ignored) {}
        }
        return defaultValue;
    }
}
