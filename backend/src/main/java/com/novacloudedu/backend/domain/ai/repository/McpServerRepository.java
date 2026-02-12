package com.novacloudedu.backend.domain.ai.repository;

import com.novacloudedu.backend.domain.ai.entity.McpServer;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * MCP 服务器仓储接口
 */
public interface McpServerRepository {

    McpServer save(McpServer mcpServer);

    Optional<McpServer> findById(Long id);

    List<McpServer> findByCreatorId(UserId creatorId);

    List<McpServer> findByIds(List<Long> ids);

    List<McpServer> findAllEnabled();

    void delete(Long id);
}
