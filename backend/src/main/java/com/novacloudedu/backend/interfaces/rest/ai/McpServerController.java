package com.novacloudedu.backend.interfaces.rest.ai;

import com.novacloudedu.backend.application.service.McpServerApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.ai.entity.McpServer;
import com.novacloudedu.backend.infrastructure.ai.McpClientService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * MCP 服务器管理控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/ai/mcp-servers")
@RequiredArgsConstructor
@Tag(name = "MCP服务器管理", description = "MCP服务器CRUD及工具发现接口")
public class McpServerController {

    private final McpServerApplicationService mcpServerService;

    @PostMapping
    @Operation(summary = "创建MCP服务器", operationId = "mcpServerCreate")
    public BaseResponse<Map<String, Object>> create(
            @RequestParam Long userId,
            @RequestBody Map<String, Object> body) {
        try {
            String name = (String) body.get("name");
            String description = (String) body.get("description");
            String url = (String) body.get("url");
            String configJson = (String) body.get("configJson");

            Long id = mcpServerService.create(name, description, url, configJson, userId);
            return ResultUtils.success(Map.of("id", id));
        } catch (Exception e) {
            log.error("创建MCP服务器失败", e);
            return (BaseResponse<Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PutMapping("/{id}")
    @Operation(summary = "更新MCP服务器", operationId = "mcpServerUpdate")
    public BaseResponse<Void> update(
            @PathVariable Long id,
            @RequestParam Long userId,
            @RequestBody Map<String, Object> body) {
        try {
            String name = (String) body.get("name");
            String description = (String) body.get("description");
            String url = (String) body.get("url");
            String configJson = (String) body.get("configJson");

            mcpServerService.update(id, name, description, url, configJson, userId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("更新MCP服务器失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除MCP服务器", operationId = "mcpServerDelete")
    public BaseResponse<Void> delete(@PathVariable Long id, @RequestParam Long userId) {
        try {
            mcpServerService.delete(id, userId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("删除MCP服务器失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PatchMapping("/{id}/enabled")
    @Operation(summary = "启用/禁用MCP服务器", operationId = "mcpServerSetEnabled")
    public BaseResponse<Void> setEnabled(
            @PathVariable Long id,
            @RequestParam Long userId,
            @RequestParam boolean enabled) {
        try {
            mcpServerService.setEnabled(id, enabled, userId);
            return ResultUtils.success(null);
        } catch (Exception e) {
            log.error("设置MCP服务器状态失败", e);
            return (BaseResponse<Void>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取MCP服务器详情", operationId = "mcpServerGetById")
    public BaseResponse<Map<String, Object>> getById(@PathVariable Long id) {
        try {
            McpServer server = mcpServerService.getById(id);
            return ResultUtils.success(toVO(server));
        } catch (Exception e) {
            log.error("获取MCP服务器详情失败", e);
            return (BaseResponse<Map<String, Object>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping
    @Operation(summary = "获取用户的MCP服务器列表", operationId = "mcpServerListByCreator")
    public BaseResponse<List<Map<String, Object>>> listByCreator(@RequestParam Long userId) {
        try {
            List<McpServer> servers = mcpServerService.listByCreator(userId);
            List<Map<String, Object>> result = servers.stream().map(this::toVO).toList();
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("获取MCP服务器列表失败", e);
            return (BaseResponse<List<Map<String, Object>>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @PostMapping("/{id}/test")
    @Operation(summary = "测试MCP服务器连接", operationId = "mcpServerTestConnection")
    public BaseResponse<Map<String, String>> testConnection(@PathVariable Long id) {
        try {
            Map<String, String> info = mcpServerService.testConnection(id);
            return ResultUtils.success(info);
        } catch (Exception e) {
            log.error("测试MCP服务器连接失败", e);
            return (BaseResponse<Map<String, String>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    @GetMapping("/{id}/tools")
    @Operation(summary = "获取MCP服务器提供的工具列表", operationId = "mcpServerListTools")
    public BaseResponse<List<Map<String, Object>>> listTools(@PathVariable Long id) {
        try {
            List<McpClientService.McpTool> tools = mcpServerService.listTools(id);
            List<Map<String, Object>> result = tools.stream().map(t -> {
                Map<String, Object> m = new LinkedHashMap<>();
                m.put("name", t.getName());
                m.put("description", t.getDescription());
                m.put("inputSchema", t.getInputSchema());
                return m;
            }).toList();
            return ResultUtils.success(result);
        } catch (Exception e) {
            log.error("获取MCP工具列表失败", e);
            return (BaseResponse<List<Map<String, Object>>>) (BaseResponse<?>) ResultUtils.error(50000, e.getMessage());
        }
    }

    private Map<String, Object> toVO(McpServer server) {
        Map<String, Object> vo = new LinkedHashMap<>();
        vo.put("id", server.getId());
        vo.put("name", server.getName());
        vo.put("description", server.getDescription());
        vo.put("url", server.getUrl());
        vo.put("configJson", server.getConfigJson());
        vo.put("enabled", server.getEnabled());
        vo.put("creatorId", server.getCreatorId() != null ? server.getCreatorId().value() : null);
        vo.put("createTime", server.getCreateTime());
        vo.put("updateTime", server.getUpdateTime());
        return vo;
    }
}
