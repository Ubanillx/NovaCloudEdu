package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.ai.entity.McpServer;
import com.novacloudedu.backend.domain.ai.repository.McpServerRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.ai.McpClientService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * MCP 服务器应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class McpServerApplicationService {

    private final McpServerRepository mcpServerRepository;
    private final McpClientService mcpClientService;

    @Transactional
    public Long create(String name, String description, String url, String configJson, Long creatorId) {
        McpServer server = McpServer.create(name, description, url, configJson, UserId.of(creatorId));
        mcpServerRepository.save(server);
        log.info("创建MCP服务器: id={}, name={}", server.getId(), name);
        return server.getId();
    }

    @Transactional
    public void update(Long id, String name, String description, String url, String configJson, Long operatorId) {
        McpServer server = mcpServerRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("MCP服务器不存在: " + id));
        if (!server.getCreatorId().value().equals(operatorId)) {
            throw new IllegalStateException("无权操作此MCP服务器");
        }
        server.update(name, description, url, configJson);
        mcpServerRepository.save(server);
        mcpClientService.clearToolsCache(id);
        log.info("更新MCP服务器: id={}, name={}", id, name);
    }

    @Transactional
    public void delete(Long id, Long operatorId) {
        McpServer server = mcpServerRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("MCP服务器不存在: " + id));
        if (!server.getCreatorId().value().equals(operatorId)) {
            throw new IllegalStateException("无权操作此MCP服务器");
        }
        mcpServerRepository.delete(id);
        mcpClientService.clearToolsCache(id);
        log.info("删除MCP服务器: id={}, name={}", id, server.getName());
    }

    @Transactional
    public void setEnabled(Long id, boolean enabled, Long operatorId) {
        McpServer server = mcpServerRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("MCP服务器不存在: " + id));
        if (!server.getCreatorId().value().equals(operatorId)) {
            throw new IllegalStateException("无权操作此MCP服务器");
        }
        server.setEnabled(enabled);
        mcpServerRepository.save(server);
        log.info("{}MCP服务器: id={}, name={}", enabled ? "启用" : "禁用", id, server.getName());
    }

    public McpServer getById(Long id) {
        return mcpServerRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("MCP服务器不存在: " + id));
    }

    public List<McpServer> listByCreator(Long creatorId) {
        return mcpServerRepository.findByCreatorId(UserId.of(creatorId));
    }

    public List<McpServer> findByIds(List<Long> ids) {
        return mcpServerRepository.findByIds(ids);
    }

    /**
     * 测试 MCP 服务器连接
     */
    public Map<String, String> testConnection(Long id) {
        McpServer server = getById(id);
        return mcpClientService.testConnection(server);
    }

    /**
     * 获取 MCP 服务器提供的工具列表
     */
    public List<McpClientService.McpTool> listTools(Long id) {
        McpServer server = getById(id);
        return mcpClientService.listTools(server);
    }
}
