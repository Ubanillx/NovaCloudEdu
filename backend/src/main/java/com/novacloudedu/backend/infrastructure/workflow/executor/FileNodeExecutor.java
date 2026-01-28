package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.HashMap;
import java.util.Map;

/**
 * 文件读写节点执行器
 * 支持FILE_READ和FILE_WRITE两种操作
 */
@Slf4j
@Component
public class FileNodeExecutor implements NodeExecutor {

    @Value("${workflow.file.base-path:/tmp/workflow-files}")
    private String basePath;

    @Value("${workflow.file.max-size:10485760}")
    private long maxFileSize; // 默认10MB

    @Override
    public NodeType getNodeType() {
        return NodeType.FILE_READ; // 同时处理FILE_READ和FILE_WRITE
    }

    @Override
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();
        
        String operation = (String) config.getOrDefault("operation", "READ");
        String filePathTemplate = (String) config.get("filePath");
        String outputVariable = (String) config.getOrDefault("outputVariable", "fileContent");
        
        // 替换路径中的变量
        String filePath = replaceVariables(filePathTemplate, input);
        
        // 安全检查：确保路径在允许的目录内
        Path resolvedPath = resolveSafePath(filePath);
        
        if ("READ".equalsIgnoreCase(operation)) {
            return executeRead(node, resolvedPath, outputVariable, config);
        } else if ("WRITE".equalsIgnoreCase(operation)) {
            return executeWrite(node, resolvedPath, input, config);
        } else {
            throw new IllegalArgumentException("不支持的文件操作: " + operation);
        }
    }

    private Map<String, Object> executeRead(WorkflowNode node, Path filePath, String outputVariable, 
                                             Map<String, Object> config) {
        try {
            if (!Files.exists(filePath)) {
                throw new IllegalArgumentException("文件不存在: " + filePath);
            }
            
            long fileSize = Files.size(filePath);
            if (fileSize > maxFileSize) {
                throw new IllegalArgumentException("文件过大: " + fileSize + " bytes, 最大允许: " + maxFileSize);
            }

            String encoding = (String) config.getOrDefault("encoding", "UTF-8");
            String content = Files.readString(filePath, java.nio.charset.Charset.forName(encoding));

            log.info("文件读取完成: nodeId={}, path={}, size={}", node.getId(), filePath, fileSize);

            Map<String, Object> result = new HashMap<>();
            result.put(outputVariable, content);
            result.put("fileName", filePath.getFileName().toString());
            result.put("fileSize", fileSize);
            result.put("filePath", filePath.toString());
            
            return result;
            
        } catch (IOException e) {
            log.error("文件读取失败: nodeId={}, path={}, error={}", node.getId(), filePath, e.getMessage());
            throw new RuntimeException("文件读取失败: " + e.getMessage(), e);
        }
    }

    private Map<String, Object> executeWrite(WorkflowNode node, Path filePath, Map<String, Object> input,
                                              Map<String, Object> config) {
        try {
            String contentVariable = (String) config.get("contentVariable");
            String content = (String) input.get(contentVariable);
            
            if (content == null) {
                content = (String) config.getOrDefault("content", "");
            }
            
            String encoding = (String) config.getOrDefault("encoding", "UTF-8");
            Boolean append = (Boolean) config.getOrDefault("append", false);
            Boolean createDirs = (Boolean) config.getOrDefault("createDirectories", true);
            
            // 创建父目录
            if (createDirs && filePath.getParent() != null) {
                Files.createDirectories(filePath.getParent());
            }
            
            // 写入文件
            if (append) {
                Files.writeString(filePath, content, java.nio.charset.Charset.forName(encoding),
                        StandardOpenOption.CREATE, StandardOpenOption.APPEND);
            } else {
                Files.writeString(filePath, content, java.nio.charset.Charset.forName(encoding),
                        StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
            }

            long fileSize = Files.size(filePath);
            log.info("文件写入完成: nodeId={}, path={}, size={}", node.getId(), filePath, fileSize);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("filePath", filePath.toString());
            result.put("fileSize", fileSize);
            result.put("append", append);
            
            return result;
            
        } catch (IOException e) {
            log.error("文件写入失败: nodeId={}, path={}, error={}", node.getId(), filePath, e.getMessage());
            throw new RuntimeException("文件写入失败: " + e.getMessage(), e);
        }
    }

    private Path resolveSafePath(String filePath) {
        Path base = Paths.get(basePath).toAbsolutePath().normalize();
        Path resolved = base.resolve(filePath).normalize();
        
        // 安全检查：确保解析后的路径仍在基础路径内
        if (!resolved.startsWith(base)) {
            throw new SecurityException("不允许访问基础目录外的文件: " + filePath);
        }
        
        return resolved;
    }

    private String replaceVariables(String template, Map<String, Object> variables) {
        if (template == null) return null;
        String result = template;
        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            String value = entry.getValue() != null ? String.valueOf(entry.getValue()) : "";
            result = result.replace(placeholder, value);
        }
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null || !config.containsKey("filePath")) {
            throw new IllegalArgumentException("文件节点缺少filePath配置");
        }
    }
}
