package com.novacloudedu.backend.domain.exam.entity;

import com.novacloudedu.backend.domain.exam.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 题目聚合根（充血模型）
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Question {

    private QuestionId id;
    private QuestionType type;
    private Subject subject;
    private String grade;
    private DifficultyLevel difficulty;
    private String content;
    private String options;
    private String answer;
    private String explanation;
    private List<String> knowledgeTags;
    private String imageUrl;
    private QuestionSource source;
    private UserId creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新题目
     */
    public static Question create(QuestionType type, Subject subject, String grade,
                                  DifficultyLevel difficulty, String content, String options,
                                  String answer, String explanation, List<String> knowledgeTags,
                                  String imageUrl, QuestionSource source, UserId creatorId) {
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("题干内容不能为空");
        }
        if (answer == null || answer.trim().isEmpty()) {
            throw new IllegalArgumentException("答案不能为空");
        }

        Question question = new Question();
        question.type = type;
        question.subject = subject;
        question.grade = grade;
        question.difficulty = difficulty;
        question.content = content.trim();
        question.options = options;
        question.answer = answer.trim();
        question.explanation = explanation;
        question.knowledgeTags = knowledgeTags;
        question.imageUrl = imageUrl;
        question.source = source;
        question.creatorId = creatorId;
        question.createTime = LocalDateTime.now();
        question.updateTime = LocalDateTime.now();
        return question;
    }

    /**
     * 从持久化数据重建
     */
    public static Question reconstruct(QuestionId id, QuestionType type, Subject subject,
                                       String grade, DifficultyLevel difficulty, String content,
                                       String options, String answer, String explanation,
                                       List<String> knowledgeTags, String imageUrl,
                                       QuestionSource source, UserId creatorId,
                                       LocalDateTime createTime, LocalDateTime updateTime) {
        Question question = new Question();
        question.id = id;
        question.type = type;
        question.subject = subject;
        question.grade = grade;
        question.difficulty = difficulty;
        question.content = content;
        question.options = options;
        question.answer = answer;
        question.explanation = explanation;
        question.knowledgeTags = knowledgeTags;
        question.imageUrl = imageUrl;
        question.source = source;
        question.creatorId = creatorId;
        question.createTime = createTime;
        question.updateTime = updateTime;
        return question;
    }

    public void assignId(QuestionId id) {
        if (this.id != null) {
            throw new IllegalStateException("题目ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 更新题目信息
     */
    public void update(QuestionType type, Subject subject, String grade,
                       DifficultyLevel difficulty, String content, String options,
                       String answer, String explanation, List<String> knowledgeTags,
                       String imageUrl) {
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("题干内容不能为空");
        }
        this.type = type;
        this.subject = subject;
        this.grade = grade;
        this.difficulty = difficulty;
        this.content = content.trim();
        this.options = options;
        this.answer = answer;
        this.explanation = explanation;
        this.knowledgeTags = knowledgeTags;
        this.imageUrl = imageUrl;
        this.updateTime = LocalDateTime.now();
    }
}
