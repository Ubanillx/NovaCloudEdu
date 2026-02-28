package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.ppt.entity.PptTemplate;
import com.novacloudedu.backend.domain.ppt.repository.PptTemplateRepository;
import com.novacloudedu.backend.domain.ppt.valueobject.PptTemplateId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.ppt.PptServiceClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * PPT模板应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class PptTemplateApplicationService {

    private final PptTemplateRepository pptTemplateRepository;
    private final OssService ossService;
    private final PptServiceClient pptServiceClient;

    /**
     * 上传模板：PPTX → OSS → 存 DB（状态 PENDING）→ 异步触发语义增强解析
     */
    @Transactional
    public Long uploadTemplate(MultipartFile file, String name, String description, Long uploaderId) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException(40000, "模板文件不能为空");
        }

        // 1. 上传 PPTX 到 OSS
        String templateUrl = ossService.uploadFile(file, FileBusinessType.PPT_TEMPLATE);

        // 2. 创建模板实体（状态为 PENDING，前端可见但不可选用）
        PptTemplate template = PptTemplate.create(name, description, templateUrl, uploaderId);
        pptTemplateRepository.save(template);

        Long templateId = template.getId().value();
        log.info("PPT模板上传成功: id={}, name={}, 异步解析已触发", templateId, name);

        // 3. 异步触发语义增强解析
        triggerEnrichedParsing(templateId, templateUrl);

        return templateId;
    }

    /**
     * 异步执行语义增强解析：调用 ppt-service 的 enriched 端点
     */
    @Async
    public void triggerEnrichedParsing(Long templateId, String templateUrl) {
        PptTemplate template = pptTemplateRepository.findById(PptTemplateId.of(templateId))
                .orElse(null);
        if (template == null) {
            log.warn("异步解析模板时找不到模板: id={}", templateId);
            return;
        }

        template.markParsing();
        pptTemplateRepository.save(template);

        try {
            PptServiceClient.ParseEnrichedResult enrichedResult =
                    pptServiceClient.parseTemplateEnriched(templateUrl);

            template.updateStructure(
                    enrichedResult.fullResponseJson(),
                    enrichedResult.coverUrl(),
                    enrichedResult.slideCount()
            );
            pptTemplateRepository.save(template);
            log.info("模板语义增强解析完成: id={}", templateId);

        } catch (Exception e) {
            log.error("模板语义增强解析失败: id={}", templateId, e);
            template.markParseFailed();
            pptTemplateRepository.save(template);
        }
    }

    /**
     * 手动重新触发模板解析（用于 FAILED 状态的模板）
     */
    @Transactional
    public void retryParsing(Long templateId) {
        PptTemplate template = pptTemplateRepository.findById(PptTemplateId.of(templateId))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "模板不存在"));
        triggerEnrichedParsing(templateId, template.getTemplateUrl());
    }

    /**
     * 列出所有启用的模板（摘要）
     */
    @Transactional(readOnly = true)
    public List<PptTemplate> listEnabledTemplates() {
        return pptTemplateRepository.findEnabled();
    }

    /**
     * 列出所有模板（管理员）
     */
    @Transactional(readOnly = true)
    public List<PptTemplate> listAllTemplates() {
        return pptTemplateRepository.findAll();
    }

    /**
     * 获取模板详情
     */
    @Transactional(readOnly = true)
    public PptTemplate getTemplateById(Long id) {
        return pptTemplateRepository.findById(PptTemplateId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "模板不存在"));
    }

    /**
     * 删除模板
     */
    @Transactional
    public void deleteTemplate(Long id) {
        PptTemplate template = getTemplateById(id);

        // 删除 OSS 文件
        try {
            ossService.deleteFile(template.getTemplateUrl());
            if (template.getCoverUrl() != null && !template.getCoverUrl().isBlank()) {
                ossService.deleteFile(template.getCoverUrl());
            }
        } catch (Exception e) {
            log.warn("删除OSS文件失败: {}", e.getMessage());
        }

        pptTemplateRepository.delete(PptTemplateId.of(id));
        log.info("PPT模板已删除: id={}", id);
    }

    /**
     * 生成 PPT：查 DB 获取 templateUrl → 调 Python 生成 → 返回 OSS URL
     */
    public PptServiceClient.GenerateResult generatePpt(Long templateId, String title,
                                                        String author, List<Map<String, Object>> slides) {
        PptTemplate template = getTemplateById(templateId);
        if (!template.isEnabled()) {
            throw new BusinessException(40000, "模板已禁用");
        }

        Map<String, Object> request = Map.of(
                "template_url", template.getTemplateUrl(),
                "title", title,
                "author", author != null ? author : "",
                "slides", slides
        );

        PptServiceClient.GenerateResult result = pptServiceClient.generate(request);
        log.info("PPT生成成功: templateId={}, fileUrl={}", templateId, result.fileUrl());
        return result;
    }
}
