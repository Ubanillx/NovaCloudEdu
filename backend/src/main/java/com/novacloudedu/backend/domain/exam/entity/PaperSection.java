package com.novacloudedu.backend.domain.exam.entity;

import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;
import com.novacloudedu.backend.domain.exam.valueobject.QuestionType;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 试卷大题
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PaperSection {

    private PaperSectionId id;
    private ExamPaperId paperId;
    private String title;
    private String description;
    private QuestionType questionType;
    private Integer sortOrder;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建大题
     */
    public static PaperSection create(ExamPaperId paperId, String title, String description,
                                      QuestionType questionType, Integer sortOrder) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("大题标题不能为空");
        }

        PaperSection section = new PaperSection();
        section.paperId = paperId;
        section.title = title.trim();
        section.description = description;
        section.questionType = questionType;
        section.sortOrder = sortOrder != null ? sortOrder : 0;
        section.createTime = LocalDateTime.now();
        section.updateTime = LocalDateTime.now();
        return section;
    }

    /**
     * 从持久化数据重建
     */
    public static PaperSection reconstruct(PaperSectionId id, ExamPaperId paperId, String title,
                                           String description, QuestionType questionType,
                                           Integer sortOrder, LocalDateTime createTime,
                                           LocalDateTime updateTime) {
        PaperSection section = new PaperSection();
        section.id = id;
        section.paperId = paperId;
        section.title = title;
        section.description = description;
        section.questionType = questionType;
        section.sortOrder = sortOrder;
        section.createTime = createTime;
        section.updateTime = updateTime;
        return section;
    }

    public void assignId(PaperSectionId id) {
        if (this.id != null) {
            throw new IllegalStateException("大题ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 更新大题信息
     */
    public void update(String title, String description, QuestionType questionType, Integer sortOrder) {
        if (title != null && !title.trim().isEmpty()) {
            this.title = title.trim();
        }
        this.description = description;
        if (questionType != null) {
            this.questionType = questionType;
        }
        if (sortOrder != null) {
            this.sortOrder = sortOrder;
        }
        this.updateTime = LocalDateTime.now();
    }
}
