package com.novacloudedu.backend.domain.book.entity;

import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.KnowledgePointId;
import com.novacloudedu.backend.domain.book.valueobject.KnowledgePointType;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 知识点实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class KnowledgePoint {

    private KnowledgePointId id;
    private ChapterId chapterId;
    private KnowledgePointType pointType;
    private String name;
    private String description;
    private Integer position;
    private List<Long> relatedChapterIds;
    private List<Long> relatedPointIds;
    private LocalDateTime createTime;

    /**
     * 创建知识点
     */
    public static KnowledgePoint create(ChapterId chapterId, KnowledgePointType pointType,
                                       String name, String description, Integer position) {
        if (chapterId == null) {
            throw new IllegalArgumentException("章节ID不能为空");
        }
        if (pointType == null) {
            throw new IllegalArgumentException("知识点类型不能为空");
        }
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("知识点名称不能为空");
        }

        KnowledgePoint point = new KnowledgePoint();
        point.chapterId = chapterId;
        point.pointType = pointType;
        point.name = name.trim();
        point.description = description != null ? description.trim() : "";
        point.position = position != null ? position : 0;
        point.relatedChapterIds = new ArrayList<>();
        point.relatedPointIds = new ArrayList<>();
        point.createTime = LocalDateTime.now();
        return point;
    }

    /**
     * 重构知识点（从数据库加载）
     */
    public static KnowledgePoint reconstruct(KnowledgePointId id, ChapterId chapterId,
                                            KnowledgePointType pointType, String name,
                                            String description, Integer position,
                                            List<Long> relatedChapterIds, List<Long> relatedPointIds,
                                            LocalDateTime createTime) {
        KnowledgePoint point = new KnowledgePoint();
        point.id = id;
        point.chapterId = chapterId;
        point.pointType = pointType;
        point.name = name;
        point.description = description;
        point.position = position;
        point.relatedChapterIds = relatedChapterIds != null ? new ArrayList<>(relatedChapterIds) : new ArrayList<>();
        point.relatedPointIds = relatedPointIds != null ? new ArrayList<>(relatedPointIds) : new ArrayList<>();
        point.createTime = createTime;
        return point;
    }

    /**
     * 更新描述
     */
    public void updateDescription(String newDescription) {
        this.description = newDescription != null ? newDescription.trim() : "";
    }

    /**
     * 添加关联章节
     */
    public void addRelatedChapter(Long chapterId) {
        if (chapterId == null) {
            throw new IllegalArgumentException("章节ID不能为空");
        }
        if (!this.relatedChapterIds.contains(chapterId)) {
            this.relatedChapterIds.add(chapterId);
        }
    }

    /**
     * 添加关联知识点
     */
    public void addRelatedPoint(Long pointId) {
        if (pointId == null) {
            throw new IllegalArgumentException("知识点ID不能为空");
        }
        if (!this.relatedPointIds.contains(pointId)) {
            this.relatedPointIds.add(pointId);
        }
    }

    /**
     * 移除关联章节
     */
    public void removeRelatedChapter(Long chapterId) {
        this.relatedChapterIds.remove(chapterId);
    }

    /**
     * 移除关联知识点
     */
    public void removeRelatedPoint(Long pointId) {
        this.relatedPointIds.remove(pointId);
    }
}
