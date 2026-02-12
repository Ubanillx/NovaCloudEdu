package com.novacloudedu.backend.domain.ppt.entity;

import com.novacloudedu.backend.domain.ppt.valueobject.PptGenerationState;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * PPT生成会话聚合根
 * 跟踪多步骤PPT生成流程的状态和中间数据
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PptGenerationSession {

    private Long id;
    private Long userId;
    private PptGenerationState state;
    private String topic;
    private String outlineMarkdown;
    private Long templateId;
    private String templateUrl;
    private String templateJson;
    private String slidesJson;
    private String resultUrl;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新的生成会话
     */
    public static PptGenerationSession create(Long userId, String topic) {
        if (topic == null || topic.isBlank()) {
            throw new IllegalArgumentException("主题不能为空");
        }
        PptGenerationSession s = new PptGenerationSession();
        s.userId = userId;
        s.state = PptGenerationState.INIT;
        s.topic = topic;
        s.createTime = LocalDateTime.now();
        s.updateTime = LocalDateTime.now();
        return s;
    }

    /**
     * 从持久化数据重建
     */
    public static PptGenerationSession reconstruct(
            Long id, Long userId, PptGenerationState state, String topic,
            String outlineMarkdown, Long templateId, String templateUrl,
            String templateJson, String slidesJson, String resultUrl,
            LocalDateTime createTime, LocalDateTime updateTime) {
        PptGenerationSession s = new PptGenerationSession();
        s.id = id;
        s.userId = userId;
        s.state = state;
        s.topic = topic;
        s.outlineMarkdown = outlineMarkdown;
        s.templateId = templateId;
        s.templateUrl = templateUrl;
        s.templateJson = templateJson;
        s.slidesJson = slidesJson;
        s.resultUrl = resultUrl;
        s.createTime = createTime;
        s.updateTime = updateTime;
        return s;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("会话ID已分配");
        }
        this.id = id;
    }

    // ==================== 状态迁移方法 ====================

    public void startGeneratingOutline() {
        this.state = PptGenerationState.GENERATING_OUTLINE;
        this.updateTime = LocalDateTime.now();
    }

    public void outlineReady(String outlineMarkdown) {
        this.state = PptGenerationState.OUTLINE_READY;
        this.outlineMarkdown = outlineMarkdown;
        this.updateTime = LocalDateTime.now();
    }

    public void awaitTemplate() {
        this.state = PptGenerationState.AWAITING_TEMPLATE;
        this.updateTime = LocalDateTime.now();
    }

    public void startParsingTemplate(Long templateId, String templateUrl) {
        this.state = PptGenerationState.PARSING_TEMPLATE;
        this.templateId = templateId;
        this.templateUrl = templateUrl;
        this.updateTime = LocalDateTime.now();
    }

    public void templateReady(String templateJson) {
        this.state = PptGenerationState.TEMPLATE_READY;
        this.templateJson = templateJson;
        this.updateTime = LocalDateTime.now();
    }

    public void startGeneratingSlides() {
        this.state = PptGenerationState.GENERATING_SLIDES;
        this.updateTime = LocalDateTime.now();
    }

    public void previewEditing() {
        this.state = PptGenerationState.PREVIEW_EDITING;
        this.updateTime = LocalDateTime.now();
    }

    public void saveSlidesJson(String slidesJson) {
        this.slidesJson = slidesJson;
        this.updateTime = LocalDateTime.now();
    }

    public void startAssembling(String slidesJson) {
        this.state = PptGenerationState.ASSEMBLING;
        this.slidesJson = slidesJson;
        this.updateTime = LocalDateTime.now();
    }

    public void completed(String resultUrl) {
        this.state = PptGenerationState.COMPLETED;
        this.resultUrl = resultUrl;
        this.updateTime = LocalDateTime.now();
    }

    public void failed() {
        this.state = PptGenerationState.FAILED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 验证会话所有者
     */
    public void verifyOwner(Long userId) {
        if (!this.userId.equals(userId)) {
            throw new IllegalStateException("无权操作此会话");
        }
    }
}
