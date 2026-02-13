package com.novacloudedu.backend.interfaces.rest.exam;

import com.novacloudedu.backend.application.exam.service.ExamTemplateApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.exam.entity.ExamTemplate;
import com.novacloudedu.backend.interfaces.rest.exam.dto.response.ExamTemplateResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 试卷模板管理控制器
 */
@Tag(name = "试卷模板", description = "试卷模板上传、管理与预览")
@RestController
@RequestMapping("/api/exam-templates")
@RequiredArgsConstructor
@Slf4j
public class ExamTemplateController {

    private final ExamTemplateApplicationService examTemplateService;

    @PostMapping
    @Operation(summary = "上传试卷模板")
    public BaseResponse<Long> uploadTemplate(
            @RequestParam("file") @Parameter(description = "Typst 模板文件 (.typ)") MultipartFile file,
            @RequestParam("name") @Parameter(description = "模板名称") String name,
            @RequestParam(value = "description", required = false) @Parameter(description = "模板描述") String description,
            Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        Long templateId = examTemplateService.uploadTemplate(file, name, description, userId);
        return ResultUtils.success(templateId);
    }

    @GetMapping
    @Operation(summary = "列出所有可用模板")
    public BaseResponse<List<ExamTemplateResponse>> listTemplates() {
        List<ExamTemplate> templates = examTemplateService.listEnabledTemplates();
        List<ExamTemplateResponse> list = templates.stream()
                .map(this::toResponse)
                .toList();
        return ResultUtils.success(list);
    }

    @GetMapping("/all")
    @Operation(summary = "列出所有模板（管理员）")
    public BaseResponse<List<ExamTemplateResponse>> listAllTemplates() {
        List<ExamTemplate> templates = examTemplateService.listAllTemplates();
        List<ExamTemplateResponse> list = templates.stream()
                .map(this::toResponse)
                .toList();
        return ResultUtils.success(list);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取模板详情")
    public BaseResponse<ExamTemplateResponse> getTemplate(
            @PathVariable @Parameter(description = "模板ID") Long id) {
        ExamTemplate template = examTemplateService.getTemplateById(id);
        return ResultUtils.success(toResponse(template));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除模板")
    public BaseResponse<Void> deleteTemplate(
            @PathVariable @Parameter(description = "模板ID") Long id) {
        examTemplateService.deleteTemplate(id);
        return ResultUtils.success(null);
    }

    @PostMapping("/{id}/preview")
    @Operation(summary = "预览模板效果（用示例数据编译PDF）")
    public ResponseEntity<byte[]> previewTemplate(
            @PathVariable @Parameter(description = "模板ID") Long id) {
        byte[] pdf = examTemplateService.previewTemplate(id);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=template_preview.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdf);
    }

    private ExamTemplateResponse toResponse(ExamTemplate template) {
        return ExamTemplateResponse.builder()
                .id(template.getId().value())
                .name(template.getName())
                .description(template.getDescription())
                .templateUrl(template.getTemplateUrl())
                .coverUrl(template.getCoverUrl())
                .isSystem(template.isSystem())
                .isEnabled(template.isEnabled())
                .creatorId(template.getCreatorId().value())
                .createTime(template.getCreateTime() != null ? template.getCreateTime().toString() : null)
                .updateTime(template.getUpdateTime() != null ? template.getUpdateTime().toString() : null)
                .build();
    }
}
