package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.DatabaseMetadataService;
import com.novacloudedu.backend.infrastructure.workflow.executor.DatabaseQueryNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

/**
 * 数据库查询节点执行器单元测试
 */
@DisplayName("DatabaseQueryNodeExecutor 单元测试")
class DatabaseQueryNodeExecutorTest {

    @Mock
    private JdbcTemplate jdbcTemplate;

    @Mock
    private DatabaseMetadataService metadataService;

    private DatabaseQueryNodeExecutor executor;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        executor = new DatabaseQueryNodeExecutor(jdbcTemplate, metadataService);
        // 默认：所有表都通过白名单校验
        when(metadataService.validateSqlTables(anyString())).thenReturn(List.of());
        when(metadataService.getAllowedTableNames()).thenReturn(List.of("user_info", "course", "post"));
    }

    @Test
    @DisplayName("获取节点类型应返回DATABASE_QUERY")
    void getNodeType_shouldReturnDatabaseQuery() {
        assertEquals(NodeType.DATABASE_QUERY, executor.getNodeType());
    }

    @Test
    @DisplayName("执行 - 应执行SELECT查询并返回结果")
    void execute_shouldExecuteSelectAndReturnResults() {
        List<Map<String, Object>> mockResults = List.of(
                Map.of("id", 1, "name", "张三"),
                Map.of("id", 2, "name", "李四")
        );
        when(jdbcTemplate.queryForList(anyString())).thenReturn(mockResults);

        Map<String, Object> config = new HashMap<>();
        config.put("sql", "SELECT * FROM user_info WHERE status = 'active'");
        config.put("outputVariable", "users");

        WorkflowNode node = WorkflowNode.builder()
                .id("db_1")
                .type(NodeType.DATABASE_QUERY)
                .name("查询用户")
                .config(config)
                .build();

        Map<String, Object> input = new HashMap<>();

        Map<String, Object> result = executor.execute(node, input, null);

        assertNotNull(result);
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> users = (List<Map<String, Object>>) result.get("users");
        assertEquals(2, users.size());
        assertEquals(2, result.get("rowCount"));
    }

    @Test
    @DisplayName("验证 - INSERT语句应抛出异常")
    void validate_insertStatement_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("sql", "INSERT INTO users (name) VALUES ('test')");

        WorkflowNode node = WorkflowNode.builder()
                .id("db_1")
                .type(NodeType.DATABASE_QUERY)
                .name("非法操作")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - UPDATE语句应抛出异常")
    void validate_updateStatement_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("sql", "UPDATE users SET name = 'test' WHERE id = 1");

        WorkflowNode node = WorkflowNode.builder()
                .id("db_1")
                .type(NodeType.DATABASE_QUERY)
                .name("非法操作")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - DELETE语句应抛出异常")
    void validate_deleteStatement_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("sql", "DELETE FROM users WHERE id = 1");

        WorkflowNode node = WorkflowNode.builder()
                .id("db_1")
                .type(NodeType.DATABASE_QUERY)
                .name("非法操作")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - DROP语句应抛出异常")
    void validate_dropStatement_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("sql", "DROP TABLE users");

        WorkflowNode node = WorkflowNode.builder()
                .id("db_1")
                .type(NodeType.DATABASE_QUERY)
                .name("非法操作")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少sql配置应抛出异常")
    void validate_missingSql_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("outputVariable", "result");

        WorkflowNode node = WorkflowNode.builder()
                .id("db_1")
                .type(NodeType.DATABASE_QUERY)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - SELECT语句应通过")
    void validate_selectStatement_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("sql", "SELECT * FROM user_info WHERE id = 1");

        WorkflowNode node = WorkflowNode.builder()
                .id("db_1")
                .type(NodeType.DATABASE_QUERY)
                .name("有效查询")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
