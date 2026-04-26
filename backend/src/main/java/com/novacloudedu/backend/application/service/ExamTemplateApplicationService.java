package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.domain.exam.entity.ExamTemplate;
import com.novacloudedu.backend.domain.exam.repository.ExamTemplateRepository;
import com.novacloudedu.backend.domain.exam.valueobject.ExamTemplateId;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.exam.TypstCompileServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * 试卷模板应用服务
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ExamTemplateApplicationService {

    private final ExamTemplateRepository examTemplateRepository;
    private final OssService ossService;
    private final TypstCompileServiceImpl typstCompileService;

    /**
     * 上传模板：.typ → OSS → 用示例数据生成预览图 → 存 DB
     */
    @Transactional
    public Long uploadTemplate(MultipartFile file, String name, String description, Long userId) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException(40000, "模板文件不能为空");
        }

        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || !originalFilename.endsWith(".typ")) {
            throw new BusinessException(40000, "仅支持 .typ 格式的 Typst 模板文件");
        }

        // 1. 上传 .typ 文件到 OSS
        String templateUrl = ossService.uploadFile(file, FileBusinessType.EXAM_TEMPLATE);

        // 2. 创建模板实体
        ExamTemplate template = ExamTemplate.create(name, description, templateUrl, UserId.of(userId));
        examTemplateRepository.save(template);

        // 3. 尝试用示例数据编译预览图
        try {
            String templateContent = ossService.readFileAsString(templateUrl, "UTF-8");
            Map<String, Object> sampleData = buildSampleData();
            byte[] pdfBytes = typstCompileService.compileWithTemplate(templateContent, sampleData);
            // 上传预览 PDF 的第一页作为封面（简单处理：直接上传 PDF bytes 作为封面）
            String coverUrl = ossService.uploadBytes(pdfBytes, ".pdf", FileBusinessType.EXAM_TEMPLATE);
            template.updateCoverUrl(coverUrl);
            examTemplateRepository.save(template);
        } catch (Exception e) {
            log.warn("模板预览图生成失败，模板已保存但无封面: {}", e.getMessage());
        }

        log.info("试卷模板上传成功: id={}, name={}", template.getId().value(), name);
        return template.getId().value();
    }

    /**
     * 列出所有启用的模板
     */
    @Transactional(readOnly = true)
    public List<ExamTemplate> listEnabledTemplates() {
        return examTemplateRepository.findEnabled();
    }

    /**
     * 列出所有模板（管理员）
     */
    @Transactional(readOnly = true)
    public List<ExamTemplate> listAllTemplates() {
        return examTemplateRepository.findAll();
    }

    /**
     * 获取模板详情
     */
    @Transactional(readOnly = true)
    public ExamTemplate getTemplateById(Long id) {
        return examTemplateRepository.findById(ExamTemplateId.of(id))
                .orElseThrow(() -> new BusinessException(ErrorCode.NOT_FOUND_ERROR, "模板不存在"));
    }

    /**
     * 删除模板
     */
    @Transactional
    public void deleteTemplate(Long id) {
        ExamTemplate template = getTemplateById(id);
        if (template.isSystem()) {
            throw new BusinessException(40000, "系统内置模板不允许删除");
        }

        // 删除 OSS 文件
        try {
            ossService.deleteFile(template.getTemplateUrl());
            if (template.getCoverUrl() != null && !template.getCoverUrl().isBlank()) {
                ossService.deleteFile(template.getCoverUrl());
            }
        } catch (Exception e) {
            log.warn("删除OSS文件失败: {}", e.getMessage());
        }

        examTemplateRepository.deleteById(ExamTemplateId.of(id));
        log.info("试卷模板已删除: id={}", id);
    }

    /**
     * 预览模板效果（用示例数据编译 PDF）
     */
    public byte[] previewTemplate(Long id) {
        ExamTemplate template = getTemplateById(id);
        String templateContent = ossService.readFileAsString(template.getTemplateUrl(), "UTF-8");
        Map<String, Object> sampleData = buildSampleData();
        return typstCompileService.compileWithTemplate(templateContent, sampleData);
    }

    /**
     * 获取模板内容（用于编译）
     */
    @Transactional(readOnly = true)
    public String getTemplateContent(Long templateId) {
        ExamTemplate template = getTemplateById(templateId);
        return ossService.readFileAsString(template.getTemplateUrl(), "UTF-8");
    }

    /**
     * 构建示例试卷数据（供模板预览使用）
     */
    private Map<String, Object> buildSampleData() {
        return Map.of(
                "title", "示例试卷 — 模板预览",
                "subtitle", "(考试时间120分钟 满分100分)",
                "paper_size", "a4",
                "columns", 1,
                "sections", List.of(
                        Map.of(
                                "title", "一、选择题",
                                "description", "单选题每小题5分，多选题每小题6分",
                                "questions", List.of(
                                        Map.of("number", 1, "type", "SINGLE_CHOICE",
                                                "content", "下列哪个选项是正确的？",
                                                "score", 5,
                                                "options", List.of("选项A", "选项B", "选项C", "选项D")),
                                        Map.of("number", 2, "type", "MULTI_CHOICE",
                                                "content", "下列说法正确的是：",
                                                "score", 6,
                                                "options", List.of("选项A", "选项B", "选项C", "选项D"))
                                )
                        ),
                        Map.of(
                                "title", "二、判断题",
                                "description", "每小题4分，共8分",
                                "questions", List.of(
                                        Map.of("number", 3, "type", "TRUE_FALSE",
                                                "content", "地球绕太阳公转一周约为一年。",
                                                "score", 4),
                                        Map.of("number", 4, "type", "TRUE_FALSE",
                                                "content", "所有金属在常温下都是固体。",
                                                "score", 4)
                                )
                        ),
                        Map.of(
                                "title", "三、填空题",
                                "description", "每小题10分，共10分",
                                "questions", List.of(
                                        Map.of("number", 5, "type", "FILL_BLANK",
                                                "content", "地球的自转周期约为______小时。",
                                                "score", 10)
                                )
                        ),
                        Map.of(
                                "title", "四、主观题",
                                "description", "请在题目下方作答",
                                "questions", List.of(
                                        Map.of("number", 6, "type", "SHORT_ANSWER",
                                                "content", "请简述牛顿第三定律的内容及其应用。",
                                                "score", 12),
                                        Map.of("number", 7, "type", "CALCULATION",
                                                "content", "已知物体质量为2kg，加速度为3m/s²，求合力大小。",
                                                "score", 15),
                                        Map.of("number", 8, "type", "ESSAY",
                                                "content", "结合材料，论述科学探究中证据与结论之间的关系。",
                                                "score", 20)
                                )
                        )
                )
        );
    }
}
