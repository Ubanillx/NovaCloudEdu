package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.DatabaseMetadataService;
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
 * 支持SELECT查询，禁止修改操作，强制表白名单校验
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class DatabaseQueryNodeExecutor implements NodeExecutor {

    private final JdbcTemplate jdbcTemplate;
    private final DatabaseMetadataService metadataService;
    
    private static final Pattern UNSAFE_PATTERN = Pattern.compile(
            "\\b(INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE|GRANT|REVOKE|EXECUTE|EXEC)\\b",
            Pattern.CASE_INSENSITIVE
    );

    private static final int ABSOLUTE_MAX_ROWS = 1000;

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
        Integer maxRows = Math.min(getInteger(config, "maxRows", 100), ABSOLUTE_MAX_ROWS);
        Map<String, String> paramMapping = (Map<String, String>) config.get("paramMapping");
        
        // 安全检查1：禁止修改操作
        if (UNSAFE_PATTERN.matcher(sqlTemplate).find()) {
            throw new IllegalArgumentException("数据库查询节点禁止执行修改操作");
        }
        
        // 安全检查2：表白名单校验
        List<String> illegalTables = metadataService.validateSqlTables(sqlTemplate);
        if (!illegalTables.isEmpty()) {
            throw new IllegalArgumentException("SQL 引用了不允许查询的表: " + String.join(", ", illegalTables)
                    + "。允许的表: " + String.join(", ", metadataService.getAllowedTableNames()));
        }
        
        // 替换参数
        String sql = replaceParameters(sqlTemplate, input, paramMapping);
        
        // 安全检查3：替换参数后再次校验（防止参数注入表名）
        if (UNSAFE_PATTERN.matcher(sql).find()) {
            throw new IllegalArgumentException("参数替换后的SQL包含危险操作");
        }
        List<String> postReplaceIllegal = metadataService.validateSqlTables(sql);
        if (!postReplaceIllegal.isEmpty()) {
            throw new IllegalArgumentException("参数替换后的SQL引用了不允许的表: " + String.join(", ", postReplaceIllegal));
        }
        
        // 强制添加 LIMIT 防止全表扫描
        String safeSql = ensureLimit(sql, maxRows);
        
        log.info("数据库查询: nodeId={}, sql={}", node.getId(), safeSql.substring(0, Math.min(200, safeSql.length())));

        try {
            List<Map<String, Object>> results = jdbcTemplate.queryForList(safeSql);
            
            // 二次限制返回行数
            boolean truncated = results.size() > maxRows;
            if (truncated) {
                results = results.subList(0, maxRows);
            }

            Map<String, Object> output = new HashMap<>();
            output.put(outputVariable, results);
            output.put("rowCount", results.size());
            output.put("truncated", truncated);
            
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
        if (sql == null || sql.isBlank()) {
            throw new IllegalArgumentException("数据库查询节点SQL不能为空");
        }
        
        if (UNSAFE_PATTERN.matcher(sql).find()) {
            throw new IllegalArgumentException("数据库查询节点禁止执行修改操作");
        }
        
        // 校验表白名单
        List<String> illegalTables = metadataService.validateSqlTables(sql);
        if (!illegalTables.isEmpty()) {
            throw new IllegalArgumentException("SQL 引用了不允许查询的表: " + String.join(", ", illegalTables));
        }
    }

    /**
     * 如果 SQL 没有 LIMIT，强制添加
     */
    private String ensureLimit(String sql, int maxRows) {
        String trimmed = sql.trim().replaceAll(";\\s*$", "");
        if (!Pattern.compile("\\bLIMIT\\b", Pattern.CASE_INSENSITIVE).matcher(trimmed).find()) {
            return trimmed + " LIMIT " + maxRows;
        }
        return trimmed;
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
            matcher.appendReplacement(sb, Matcher.quoteReplacement(replacement));
        }
        matcher.appendTail(sb);
        
        return sb.toString();
    }

    private String escapeValue(Object value) {
        if (value instanceof Number) {
            return value.toString();
        }
        if (value instanceof Boolean) {
            return value.toString();
        }
        // 转义字符串，防止SQL注入
        String str = value.toString()
                .replace("'", "''")
                .replace("\\", "\\\\")
                .replace("\n", " ")
                .replace("\r", " ")
                .replace(";", "");
        return "'" + str + "'";
    }

    private Integer getInteger(Map<String, Object> config, String key, int defaultValue) {
        Object value = config.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) return ((Number) value).intValue();
        return defaultValue;
    }
}
