package com.novacloudedu.backend.domain.exam.entity;

import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperStatus;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 试卷聚合根（充血模型）
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ExamPaper {

    private ExamPaperId id;
    private String title;
    private String subtitle;
    private Subject subject;
    private String grade;
    private Integer totalScore;
    private Integer durationMin;
    private String layout;
    private PaperStatus status;
    private Long templateId;
    private UserId creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新试卷
     */
    public static ExamPaper create(String title, String subtitle, Subject subject,
                                   String grade, Integer durationMin, String layout,
                                   UserId creatorId) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("试卷标题不能为空");
        }

        ExamPaper paper = new ExamPaper();
        paper.title = title.trim();
        paper.subtitle = subtitle;
        paper.subject = subject;
        paper.grade = grade;
        paper.totalScore = 0;
        paper.durationMin = durationMin;
        paper.layout = layout != null ? layout : "{}";
        paper.status = PaperStatus.DRAFT;
        paper.creatorId = creatorId;
        paper.createTime = LocalDateTime.now();
        paper.updateTime = LocalDateTime.now();
        return paper;
    }

    /**
     * 从持久化数据重建
     */
    public static ExamPaper reconstruct(ExamPaperId id, String title, String subtitle,
                                        Subject subject, String grade, Integer totalScore,
                                        Integer durationMin, String layout, PaperStatus status,
                                        Long templateId, UserId creatorId,
                                        LocalDateTime createTime, LocalDateTime updateTime) {
        ExamPaper paper = new ExamPaper();
        paper.id = id;
        paper.title = title;
        paper.subtitle = subtitle;
        paper.subject = subject;
        paper.grade = grade;
        paper.totalScore = totalScore;
        paper.durationMin = durationMin;
        paper.layout = layout;
        paper.status = status;
        paper.templateId = templateId;
        paper.creatorId = creatorId;
        paper.createTime = createTime;
        paper.updateTime = updateTime;
        return paper;
    }

    public void assignId(ExamPaperId id) {
        if (this.id != null) {
            throw new IllegalStateException("试卷ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 更新基本信息
     */
    public void updateBasicInfo(String title, String subtitle, Subject subject,
                                String grade, Integer durationMin, String layout) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("试卷标题不能为空");
        }
        this.title = title.trim();
        this.subtitle = subtitle;
        this.subject = subject;
        this.grade = grade;
        this.durationMin = durationMin;
        this.layout = layout != null ? layout : this.layout;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新模板
     */
    public void updateTemplateId(Long templateId) {
        this.templateId = templateId;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新总分
     */
    public void updateTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 发布试卷
     */
    public void publish() {
        if (this.totalScore == null || this.totalScore <= 0) {
            throw new IllegalStateException("总分必须大于0才能发布试卷");
        }
        this.status = PaperStatus.PUBLISHED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 撤回为草稿
     */
    public void unpublish() {
        this.status = PaperStatus.DRAFT;
        this.updateTime = LocalDateTime.now();
    }

    public boolean isDraft() {
        return this.status == PaperStatus.DRAFT;
    }

    public boolean isPublished() {
        return this.status == PaperStatus.PUBLISHED;
    }
}
