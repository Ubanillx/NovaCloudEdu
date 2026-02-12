package com.novacloudedu.backend.domain.ai.entity;

import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * MCP 服务器聚合根
 * <p>
 * 存储 MCP (Model Context Protocol) 服务器的连接配置。
 * 支持两种传输方式：
 * <ul>
 *   <li>stdio — configJson 包含 command/args/env，url 为空</li>
 *   <li>streamable-http — configJson 包含 headers，url 指定 HTTP 端点</li>
 * </ul>
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class McpServer {

    private Long id;
    private String name;
    private String description;
    /** HTTP 端点 URL（stdio 模式下为空） */
    private String url;
    /** 完整 JSON 配置（stdio: command/args/env; HTTP: headers 等） */
    private String configJson;
    private Boolean enabled;
    private UserId creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新 MCP 服务器配置
     */
    public static McpServer create(String name, String description, String url,
                                    String configJson, UserId creatorId) {
        McpServer server = new McpServer();
        server.name = name;
        server.description = description;
        server.url = url;
        server.configJson = configJson;
        server.enabled = true;
        server.creatorId = creatorId;
        server.createTime = LocalDateTime.now();
        server.updateTime = LocalDateTime.now();
        return server;
    }

    /**
     * 从持久化数据重建
     */
    public static McpServer reconstruct(Long id, String name, String description, String url,
                                         String configJson, Boolean enabled, UserId creatorId,
                                         LocalDateTime createTime, LocalDateTime updateTime) {
        McpServer server = new McpServer();
        server.id = id;
        server.name = name;
        server.description = description;
        server.url = url;
        server.configJson = configJson;
        server.enabled = enabled;
        server.creatorId = creatorId;
        server.createTime = createTime;
        server.updateTime = updateTime;
        return server;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("MCP服务器ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 更新配置
     */
    public void update(String name, String description, String url, String configJson) {
        this.name = name;
        this.description = description;
        this.url = url;
        this.configJson = configJson;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 启用/禁用
     */
    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
        this.updateTime = LocalDateTime.now();
    }
}
