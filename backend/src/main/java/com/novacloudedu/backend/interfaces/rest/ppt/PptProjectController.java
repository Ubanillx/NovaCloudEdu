package com.novacloudedu.backend.interfaces.rest.ppt;

import com.novacloudedu.backend.application.service.PptProjectService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * PPT项目管理控制器
 */
@RestController
@RequestMapping("/api/ppt/projects")
@RequiredArgsConstructor
@Tag(name = "PPT项目管理", description = "PPT项目CRUD + 文档管理")
public class PptProjectController {

    private final PptProjectService pptProjectService;

    // ==================== 项目 CRUD ====================

    @PostMapping
    @Operation(summary = "创建PPT项目")
    public BaseResponse<Map<String, Object>> createProject(
            @RequestBody Map<String, String> body,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        String name = body.getOrDefault("name", "");
        String description = body.get("description");
        return ResultUtils.success(pptProjectService.createProject(userId, name, description));
    }

    @GetMapping
    @Operation(summary = "获取PPT项目列表")
    public BaseResponse<List<Map<String, Object>>> listProjects(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        return ResultUtils.success(pptProjectService.listProjects(userId));
    }

    @GetMapping("/{projectId}")
    @Operation(summary = "获取PPT项目详情（含文档列表）")
    public BaseResponse<Map<String, Object>> getProjectDetail(
            @PathVariable @Parameter(description = "项目ID") Long projectId,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        return ResultUtils.success(pptProjectService.getProjectDetail(projectId, userId));
    }

    @PutMapping("/{projectId}")
    @Operation(summary = "更新PPT项目")
    public BaseResponse<Void> updateProject(
            @PathVariable Long projectId,
            @RequestBody Map<String, String> body,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        pptProjectService.updateProject(projectId, userId, body.get("name"), body.get("description"));
        return ResultUtils.success(null);
    }

    @DeleteMapping("/{projectId}")
    @Operation(summary = "删除PPT项目")
    public BaseResponse<Void> deleteProject(
            @PathVariable Long projectId,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        pptProjectService.deleteProject(projectId, userId);
        return ResultUtils.success(null);
    }

    // ==================== 文档管理 ====================

    @PostMapping("/{projectId}/documents")
    @Operation(summary = "添加文档到项目")
    public BaseResponse<Map<String, Object>> addDocument(
            @PathVariable Long projectId,
            @RequestBody Map<String, Object> body,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        String fileName = (String) body.getOrDefault("fileName", "");
        String fileUrl = (String) body.getOrDefault("fileUrl", "");
        String fileType = (String) body.get("fileType");
        Long fileSize = body.get("fileSize") != null ? Long.parseLong(body.get("fileSize").toString()) : 0L;
        return ResultUtils.success(
                pptProjectService.addDocument(projectId, userId, fileName, fileUrl, fileType, fileSize));
    }

    @DeleteMapping("/{projectId}/documents/{documentId}")
    @Operation(summary = "删除项目文档")
    public BaseResponse<Void> deleteDocument(
            @PathVariable Long projectId,
            @PathVariable Long documentId,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        pptProjectService.deleteDocument(documentId, userId);
        return ResultUtils.success(null);
    }
}
