package com.novacloudedu.backend.domain.exam.entity;

import com.novacloudedu.backend.domain.exam.valueobject.ExamTemplateId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 试卷模板实体（充血模型）
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ExamTemplate {

    private ExamTemplateId id;
    private String name;
    private String description;
    private String templateUrl;
    private String coverUrl;
    private UserId creatorId;
    private boolean isSystem;
    private boolean isEnabled;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新模板
     */
    public static ExamTemplate create(String name, String description, String templateUrl, UserId creatorId) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("模板名称不能为空");
        }
        if (templateUrl == null || templateUrl.trim().isEmpty()) {
            throw new IllegalArgumentException("模板文件URL不能为空");
        }

        ExamTemplate template = new ExamTemplate();
        template.name = name.trim();
        template.description = description;
        template.templateUrl = templateUrl;
        template.creatorId = creatorId;
        template.isSystem = false;
        template.isEnabled = true;
        template.createTime = LocalDateTime.now();
        template.updateTime = LocalDateTime.now();
        return template;
    }

    /**
     * 从持久化数据重建
     */
    public static ExamTemplate reconstruct(ExamTemplateId id, String name, String description,
                                           String templateUrl, String coverUrl, UserId creatorId,
                                           boolean isSystem, boolean isEnabled,
                                           LocalDateTime createTime, LocalDateTime updateTime) {
        ExamTemplate template = new ExamTemplate();
        template.id = id;
        template.name = name;
        template.description = description;
        template.templateUrl = templateUrl;
        template.coverUrl = coverUrl;
        template.creatorId = creatorId;
        template.isSystem = isSystem;
        template.isEnabled = isEnabled;
        template.createTime = createTime;
        template.updateTime = updateTime;
        return template;
    }

    public void assignId(ExamTemplateId id) {
        if (this.id != null) {
            throw new IllegalStateException("模板ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
        this.updateTime = LocalDateTime.now();
    }

    public void enable() {
        this.isEnabled = true;
        this.updateTime = LocalDateTime.now();
    }

    public void disable() {
        this.isEnabled = false;
        this.updateTime = LocalDateTime.now();
    }
}
