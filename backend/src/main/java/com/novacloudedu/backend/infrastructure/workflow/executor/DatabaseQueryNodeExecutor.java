package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 数据库查询节点执行器
 * 支持SELECT查询，禁止修改操作
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class DatabaseQueryNodeExecutor implements NodeExecutor {

    private final JdbcTemplate jdbcTemplate;
    
    private static final Pattern UNSAFE_PATTERN = Pattern.compile(
            "\\b(INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE|GRANT|REVOKE)\\b",
            Pattern.CASE_INSENSITIVE
    );

    @Override
    public NodeType getNodeType() {
        return NodeType.DATABASE_QUERY;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String sqlTemplate = (String) config.get("sql");
        String outputVariable = (String) config.getOrDefault("outputVariable", "queryResult");
        Integer maxRows = getInteger(config, "maxRows", 100);
        Map<String, String> paramMapping = (Map<String, String>) config.get("paramMapping");
        
        // 安全检查：禁止修改操作
        if (UNSAFE_PATTERN.matcher(sqlTemplate).find()) {
            throw new IllegalArgumentException("数据库查询节点禁止执行修改操作");
        }
        
        // 替换参数
        String sql = replaceParameters(sqlTemplate, input, paramMapping);
        
        log.info("数据库查询: nodeId={}, sql={}", node.getId(), sql.substring(0, Math.min(100, sql.length())));

        try {
            // 执行查询
            List<Map<String, Object>> results = jdbcTemplate.queryForList(sql);
            
            // 限制返回行数
            if (results.size() > maxRows) {
                results = results.subList(0, maxRows);
            }

            Map<String, Object> output = new HashMap<>();
            output.put(outputVariable, results);
            output.put("rowCount", results.size());
            output.put("truncated", results.size() >= maxRows);
            
            log.info("数据库查询完成: nodeId={}, rowCount={}", node.getId(), results.size());
            
            return output;
            
        } catch (Exception e) {
            log.error("数据库查询失败: nodeId={}, error={}", node.getId(), e.getMessage());
            throw new RuntimeException("数据库查询失败: " + e.getMessage(), e);
        }
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null || !config.containsKey("sql")) {
            throw new IllegalArgumentException("数据库查询节点缺少sql配置");
        }
        
        String sql = (String) config.get("sql");
        if (UNSAFE_PATTERN.matcher(sql).find()) {
            throw new IllegalArgumentException("数据库查询节点禁止执行修改操作");
        }
    }

    private String replaceParameters(String sql, Map<String, Object> input, Map<String, String> paramMapping) {
        String result = sql;
        
        // 替换参数映射
        if (paramMapping != null) {
            for (Map.Entry<String, String> entry : paramMapping.entrySet()) {
                String placeholder = ":" + entry.getKey();
                Object value = input.get(entry.getValue());
                String replacement = value != null ? escapeValue(value) : "NULL";
                result = result.replace(placeholder, replacement);
            }
        }
        
        // 替换直接变量引用 {{variableName}}
        Pattern pattern = Pattern.compile("\\{\\{(\\w+)\\}\\}");
        Matcher matcher = pattern.matcher(result);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            String varName = matcher.group(1);
            Object value = input.get(varName);
            String replacement = value != null ? escapeValue(value) : "NULL";
            matcher.appendReplacement(sb, replacement);
        }
        matcher.appendTail(sb);
        
        return sb.toString();
    }

    private String escapeValue(Object value) {
        if (value instanceof Number) {
            return value.toString();
        }
        // 转义字符串，防止SQL注入
        String str = value.toString()
                .replace("'", "''")
                .replace("\\", "\\\\");
        return "'" + str + "'";
    }

    private Integer getInteger(Map<String, Object> config, String key, int defaultValue) {
        Object value = config.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) return ((Number) value).intValue();
        return defaultValue;
    }
}
