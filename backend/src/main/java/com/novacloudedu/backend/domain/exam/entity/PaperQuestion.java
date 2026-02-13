package com.novacloudedu.backend.domain.exam.entity;

import com.novacloudedu.backend.domain.exam.valueobject.PaperQuestionId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;
import com.novacloudedu.backend.domain.exam.valueobject.QuestionId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 试卷题目关联（试卷中的一道小题）
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PaperQuestion {

    private PaperQuestionId id;
    private PaperSectionId sectionId;
    private QuestionId questionId;
    private Integer score;
    private Integer sortOrder;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建试卷题目关联
     */
    public static PaperQuestion create(PaperSectionId sectionId, QuestionId questionId,
                                       Integer score, Integer sortOrder) {
        if (score == null || score < 0) {
            throw new IllegalArgumentException("分值不能为负数");
        }

        PaperQuestion pq = new PaperQuestion();
        pq.sectionId = sectionId;
        pq.questionId = questionId;
        pq.score = score;
        pq.sortOrder = sortOrder != null ? sortOrder : 0;
        pq.createTime = LocalDateTime.now();
        pq.updateTime = LocalDateTime.now();
        return pq;
    }

    /**
     * 从持久化数据重建
     */
    public static PaperQuestion reconstruct(PaperQuestionId id, PaperSectionId sectionId,
                                            QuestionId questionId, Integer score,
                                            Integer sortOrder, LocalDateTime createTime,
                                            LocalDateTime updateTime) {
        PaperQuestion pq = new PaperQuestion();
        pq.id = id;
        pq.sectionId = sectionId;
        pq.questionId = questionId;
        pq.score = score;
        pq.sortOrder = sortOrder;
        pq.createTime = createTime;
        pq.updateTime = updateTime;
        return pq;
    }

    public void assignId(PaperQuestionId id) {
        if (this.id != null) {
            throw new IllegalStateException("试卷题目关联ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 更新分值和排序
     */
    public void update(Integer score, Integer sortOrder) {
        if (score != null) {
            if (score < 0) {
                throw new IllegalArgumentException("分值不能为负数");
            }
            this.score = score;
        }
        if (sortOrder != null) {
            this.sortOrder = sortOrder;
        }
        this.updateTime = LocalDateTime.now();
    }
}
