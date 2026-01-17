package com.novacloudedu.backend.domain.book.entity;

import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.ChapterSummaryId;
import com.novacloudedu.backend.domain.book.valueobject.SummaryType;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 章节总结实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ChapterSummary {

    private ChapterSummaryId id;
    private ChapterId chapterId;
    private SummaryType summaryType;
    private String content;
    private List<String> keyPoints;
    private String aiModel;
    private boolean cached;
    private LocalDateTime createTime;

    /**
     * 创建章节总结
     */
    public static ChapterSummary create(ChapterId chapterId, SummaryType summaryType,
                                       String content, List<String> keyPoints, String aiModel) {
        if (chapterId == null) {
            throw new IllegalArgumentException("章节ID不能为空");
        }
        if (summaryType == null) {
            throw new IllegalArgumentException("总结类型不能为空");
        }
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("总结内容不能为空");
        }
        if (aiModel == null || aiModel.trim().isEmpty()) {
            throw new IllegalArgumentException("AI模型不能为空");
        }

        ChapterSummary summary = new ChapterSummary();
        summary.chapterId = chapterId;
        summary.summaryType = summaryType;
        summary.content = content.trim();
        summary.keyPoints = keyPoints != null ? new ArrayList<>(keyPoints) : new ArrayList<>();
        summary.aiModel = aiModel.trim();
        summary.cached = true;
        summary.createTime = LocalDateTime.now();
        return summary;
    }

    /**
     * 重构章节总结（从数据库加载）
     */
    public static ChapterSummary reconstruct(ChapterSummaryId id, ChapterId chapterId,
                                            SummaryType summaryType, String content,
                                            List<String> keyPoints, String aiModel,
                                            boolean cached, LocalDateTime createTime) {
        ChapterSummary summary = new ChapterSummary();
        summary.id = id;
        summary.chapterId = chapterId;
        summary.summaryType = summaryType;
        summary.content = content;
        summary.keyPoints = keyPoints != null ? new ArrayList<>(keyPoints) : new ArrayList<>();
        summary.aiModel = aiModel;
        summary.cached = cached;
        summary.createTime = createTime;
        return summary;
    }

    /**
     * 更新总结内容
     */
    public void updateContent(String newContent, List<String> newKeyPoints) {
        if (newContent == null || newContent.trim().isEmpty()) {
            throw new IllegalArgumentException("总结内容不能为空");
        }
        this.content = newContent.trim();
        this.keyPoints = newKeyPoints != null ? new ArrayList<>(newKeyPoints) : new ArrayList<>();
    }

    /**
     * 添加关键点
     */
    public void addKeyPoint(String keyPoint) {
        if (keyPoint == null || keyPoint.trim().isEmpty()) {
            throw new IllegalArgumentException("关键点不能为空");
        }
        this.keyPoints.add(keyPoint.trim());
    }

    /**
     * 标记为已缓存
     */
    public void markAsCached() {
        this.cached = true;
    }

    /**
     * 标记为未缓存
     */
    public void markAsUncached() {
        this.cached = false;
    }
}
