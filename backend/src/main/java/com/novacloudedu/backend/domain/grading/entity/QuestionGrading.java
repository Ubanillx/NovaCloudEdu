package com.novacloudedu.backend.domain.grading.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 单题批改详情实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class QuestionGrading {

    private Long id;
    private Long gradingResultId;
    private int questionIndex;
    private String questionContent;
    private String questionType;
    private String studentAnswer;
    private String standardAnswer;
    private int score;
    private int maxScore;
    private List<String> errorCategories;
    private String errorDetail;
    private List<String> knowledgePoints;
    private String comment;
    private Long similarQuestionId;
    private LocalDateTime createTime;

    /**
     * 创建单题批改结果
     */
    public static QuestionGrading create(int questionIndex, String questionContent, String questionType,
                                          String studentAnswer, String standardAnswer,
                                          int score, int maxScore,
                                          List<String> errorCategories, String errorDetail,
                                          List<String> knowledgePoints, String comment) {
        QuestionGrading grading = new QuestionGrading();
        grading.questionIndex = questionIndex;
        grading.questionContent = questionContent;
        grading.questionType = questionType;
        grading.studentAnswer = studentAnswer;
        grading.standardAnswer = standardAnswer;
        grading.score = score;
        grading.maxScore = maxScore;
        grading.errorCategories = errorCategories != null ? new ArrayList<>(errorCategories) : new ArrayList<>();
        grading.errorDetail = errorDetail;
        grading.knowledgePoints = knowledgePoints != null ? new ArrayList<>(knowledgePoints) : new ArrayList<>();
        grading.comment = comment;
        grading.createTime = LocalDateTime.now();
        return grading;
    }

    /**
     * 从持久化数据重建
     */
    public static QuestionGrading reconstruct(Long id, Long gradingResultId, int questionIndex,
                                               String questionContent, String questionType,
                                               String studentAnswer, String standardAnswer,
                                               int score, int maxScore,
                                               List<String> errorCategories, String errorDetail,
                                               List<String> knowledgePoints, String comment,
                                               Long similarQuestionId, LocalDateTime createTime) {
        QuestionGrading grading = new QuestionGrading();
        grading.id = id;
        grading.gradingResultId = gradingResultId;
        grading.questionIndex = questionIndex;
        grading.questionContent = questionContent;
        grading.questionType = questionType;
        grading.studentAnswer = studentAnswer;
        grading.standardAnswer = standardAnswer;
        grading.score = score;
        grading.maxScore = maxScore;
        grading.errorCategories = errorCategories != null ? new ArrayList<>(errorCategories) : new ArrayList<>();
        grading.errorDetail = errorDetail;
        grading.knowledgePoints = knowledgePoints != null ? new ArrayList<>(knowledgePoints) : new ArrayList<>();
        grading.comment = comment;
        grading.similarQuestionId = similarQuestionId;
        grading.createTime = createTime;
        return grading;
    }

    public void assignGradingResultId(Long gradingResultId) {
        this.gradingResultId = gradingResultId;
    }

    public void setSimilarQuestionId(Long similarQuestionId) {
        this.similarQuestionId = similarQuestionId;
    }
}
