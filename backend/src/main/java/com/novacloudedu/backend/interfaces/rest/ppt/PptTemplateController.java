package com.novacloudedu.backend.interfaces.rest.ppt;

import com.novacloudedu.backend.application.service.PptTemplateApplicationService;
import com.novacloudedu.backend.common.BaseResponse;
import com.novacloudedu.backend.common.ResultUtils;
import com.novacloudedu.backend.domain.ppt.entity.PptTemplate;
import com.novacloudedu.backend.infrastructure.ppt.PptServiceClient;
import com.novacloudedu.backend.interfaces.rest.ppt.assembler.PptTemplateAssembler;
import com.novacloudedu.backend.interfaces.rest.ppt.dto.request.GeneratePptRequest;
import com.novacloudedu.backend.interfaces.rest.ppt.dto.response.PptGenerateResponse;
import com.novacloudedu.backend.interfaces.rest.ppt.dto.response.PptTemplateDetailResponse;
import com.novacloudedu.backend.interfaces.rest.ppt.dto.response.PptTemplateListResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * PPT模板管理控制器
 */
@Tag(name = "PPT模板", description = "PPT模板管理与生成接口")
@RestController
@RequestMapping("/api/ppt")
@RequiredArgsConstructor
@Slf4j
public class PptTemplateController {

    private final PptTemplateApplicationService pptTemplateService;
    private final PptTemplateAssembler assembler;

    @PostMapping("/templates")
    @Operation(summary = "上传PPT模板")
    public BaseResponse<Long> uploadTemplate(
            @RequestParam("file") @Parameter(description = "PPTX模板文件") MultipartFile file,
            @RequestParam("name") @Parameter(description = "模板名称") String name,
            @RequestParam(value = "description", required = false) @Parameter(description = "模板描述") String description,
            Authentication authentication) {

        Long userId = Long.parseLong(authentication.getName());
        Long templateId = pptTemplateService.uploadTemplate(file, name, description, userId);
        return ResultUtils.success(templateId);
    }

    @GetMapping("/templates")
    @Operation(summary = "列出所有可用模板")
    public BaseResponse<List<PptTemplateListResponse>> listTemplates() {
        List<PptTemplate> templates = pptTemplateService.listEnabledTemplates();
        List<PptTemplateListResponse> list = templates.stream()
                .map(assembler::toListResponse)
                .toList();
        return ResultUtils.success(list);
    }

    @GetMapping("/templates/{id}")
    @Operation(summary = "查看模板详情")
    public BaseResponse<PptTemplateDetailResponse> getTemplateDetail(
            @PathVariable @Parameter(description = "模板ID") Long id) {
        PptTemplate template = pptTemplateService.getTemplateById(id);
        return ResultUtils.success(assembler.toDetailResponse(template));
    }

    @DeleteMapping("/templates/{id}")
    @Operation(summary = "删除模板")
    public BaseResponse<Void> deleteTemplate(
            @PathVariable @Parameter(description = "模板ID") Long id) {
        pptTemplateService.deleteTemplate(id);
        return ResultUtils.success(null);
    }

    @PostMapping("/generate")
    @Operation(summary = "基于模板生成PPT")
    public BaseResponse<PptGenerateResponse> generatePpt(
            @RequestBody GeneratePptRequest request) {
        PptServiceClient.GenerateResult result = pptTemplateService.generatePpt(
                request.getTemplateId(),
                request.getTitle(),
                request.getAuthor(),
                request.getSlides()
        );
        return ResultUtils.success(assembler.toGenerateResponse(result));
    }
}
