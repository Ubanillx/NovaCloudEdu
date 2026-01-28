package com.novacloudedu.backend.workflow.executor;

import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.FileNodeExecutor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 文件读写节点执行器单元测试
 */
@DisplayName("FileNodeExecutor 单元测试")
class FileNodeExecutorTest {

    private FileNodeExecutor executor;

    @TempDir
    Path tempDir;

    @BeforeEach
    void setUp() {
        executor = new FileNodeExecutor();
    }

    @Test
    @DisplayName("获取节点类型应返回FILE_READ")
    void getNodeType_shouldReturnFileRead() {
        assertEquals(NodeType.FILE_READ, executor.getNodeType());
    }

    @Test
    @DisplayName("验证 - 缺少filePath配置应抛出异常")
    void validate_missingFilePath_shouldThrowException() {
        Map<String, Object> config = new HashMap<>();
        config.put("operation", "READ");

        WorkflowNode node = WorkflowNode.builder()
                .id("file_1")
                .type(NodeType.FILE_READ)
                .name("无效配置")
                .config(config)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 缺少config应抛出异常")
    void validate_missingConfig_shouldThrowException() {
        WorkflowNode node = WorkflowNode.builder()
                .id("file_1")
                .type(NodeType.FILE_READ)
                .name("无效配置")
                .config(null)
                .build();

        assertThrows(IllegalArgumentException.class, () -> executor.validate(node));
    }

    @Test
    @DisplayName("验证 - 有filePath配置应通过验证")
    void validate_withFilePath_shouldPass() {
        Map<String, Object> config = new HashMap<>();
        config.put("filePath", "/test/file.txt");
        config.put("operation", "READ");

        WorkflowNode node = WorkflowNode.builder()
                .id("file_1")
                .type(NodeType.FILE_READ)
                .name("有效配置")
                .config(config)
                .build();

        assertDoesNotThrow(() -> executor.validate(node));
    }
}
