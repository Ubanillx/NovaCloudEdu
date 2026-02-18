package com.novacloudedu.backend.domain.grading.entity;

import com.novacloudedu.backend.domain.grading.valueobject.GradingResultId;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 批改结果实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class GradingResult {

    private GradingResultId id;
    private SubmissionId submissionId;
    private Integer totalScore;
    private Integer maxScore;
    private String overallComment;
    private List<QuestionGrading> questionGradings;
    private String modelId;
    private LocalDateTime gradingTime;
    private LocalDateTime createTime;

    /**
     * 创建新的批改结果
     */
    public static GradingResult create(SubmissionId submissionId, String modelId) {
        if (submissionId == null) {
            throw new IllegalArgumentException("提交ID不能为空");
        }

        GradingResult result = new GradingResult();
        result.submissionId = submissionId;
        result.modelId = modelId;
        result.questionGradings = new ArrayList<>();
        result.totalScore = 0;
        result.maxScore = 0;
        result.createTime = LocalDateTime.now();
        return result;
    }

    /**
     * 从持久化数据重建
     */
    public static GradingResult reconstruct(GradingResultId id, SubmissionId submissionId,
                                             Integer totalScore, Integer maxScore,
                                             String overallComment, List<QuestionGrading> questionGradings,
                                             String modelId, LocalDateTime gradingTime,
                                             LocalDateTime createTime) {
        GradingResult result = new GradingResult();
        result.id = id;
        result.submissionId = submissionId;
        result.totalScore = totalScore;
        result.maxScore = maxScore;
        result.overallComment = overallComment;
        result.questionGradings = questionGradings != null ? new ArrayList<>(questionGradings) : new ArrayList<>();
        result.modelId = modelId;
        result.gradingTime = gradingTime;
        result.createTime = createTime;
        return result;
    }

    public void assignId(GradingResultId id) {
        if (this.id != null) {
            throw new IllegalStateException("批改结果ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 添加单题批改结果
     */
    public void addQuestionGrading(QuestionGrading grading) {
        this.questionGradings.add(grading);
    }

    /**
     * 计算汇总分数并完成批改
     */
    public void complete(String overallComment) {
        this.overallComment = overallComment;
        this.totalScore = questionGradings.stream().mapToInt(QuestionGrading::getScore).sum();
        this.maxScore = questionGradings.stream().mapToInt(QuestionGrading::getMaxScore).sum();
        this.gradingTime = LocalDateTime.now();
    }
}
