package com.novacloudedu.backend.domain.grading.entity;

import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.valueobject.GradingMode;
import com.novacloudedu.backend.domain.grading.valueobject.GradingStatus;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 作业提交聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class HomeworkSubmission {

    private SubmissionId id;
    private UserId studentId;
    private Long classId;
    private GradingMode gradingMode;
    private String title;
    private Subject subject;
    private String grade;
    private List<String> imageUrls;
    private String ocrRawText;
    private String structuredData;
    private GradingStatus status;
    private Long examPaperId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 创建新的作业提交
     */
    public static HomeworkSubmission create(UserId studentId, GradingMode gradingMode, String title,
                                            Subject subject, String grade,
                                            List<String> imageUrls, Long classId, Long examPaperId) {
        if (studentId == null) {
            throw new IllegalArgumentException("学生ID不能为空");
        }
        if (imageUrls == null || imageUrls.isEmpty()) {
            throw new IllegalArgumentException("作业图片不能为空");
        }

        HomeworkSubmission submission = new HomeworkSubmission();
        submission.studentId = studentId;
        submission.classId = classId;
        submission.gradingMode = gradingMode != null ? gradingMode : GradingMode.GENERAL;
        submission.title = title;
        submission.subject = subject;
        submission.grade = grade;
        submission.imageUrls = List.copyOf(imageUrls);
        submission.status = GradingStatus.PENDING;
        submission.examPaperId = examPaperId;
        submission.createTime = LocalDateTime.now();
        submission.updateTime = LocalDateTime.now();
        return submission;
    }

    /**
     * 从持久化数据重建
     */
    public static HomeworkSubmission reconstruct(SubmissionId id, UserId studentId, Long classId,
                                                  GradingMode gradingMode, String title,
                                                  Subject subject, String grade, List<String> imageUrls,
                                                  String ocrRawText, String structuredData,
                                                  GradingStatus status, Long examPaperId,
                                                  LocalDateTime createTime, LocalDateTime updateTime) {
        HomeworkSubmission submission = new HomeworkSubmission();
        submission.id = id;
        submission.studentId = studentId;
        submission.classId = classId;
        submission.gradingMode = gradingMode != null ? gradingMode : GradingMode.GENERAL;
        submission.title = title;
        submission.subject = subject;
        submission.grade = grade;
        submission.imageUrls = imageUrls != null ? List.copyOf(imageUrls) : List.of();
        submission.ocrRawText = ocrRawText;
        submission.structuredData = structuredData;
        submission.status = status;
        submission.examPaperId = examPaperId;
        submission.createTime = createTime;
        submission.updateTime = updateTime;
        return submission;
    }

    public void assignId(SubmissionId id) {
        if (this.id != null) {
            throw new IllegalStateException("提交ID已分配，不可重复分配");
        }
        this.id = id;
    }

    /**
     * 开始 OCR 识别
     */
    public void startOcr() {
        this.status = GradingStatus.OCR_PROCESSING;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 更新 OCR 结果
     */
    public void updateOcrResult(String rawText, String structuredData) {
        this.ocrRawText = rawText;
        this.structuredData = structuredData;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * AI 推断后回填学科
     */
    public void inferSubject(Subject subject) {
        if (this.subject == null && subject != null) {
            this.subject = subject;
            this.updateTime = LocalDateTime.now();
        }
    }

    /**
     * 开始批改
     */
    public void startGrading() {
        this.status = GradingStatus.GRADING;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 批改完成
     */
    public void complete() {
        this.status = GradingStatus.COMPLETED;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 批改失败
     */
    public void fail() {
        this.status = GradingStatus.FAILED;
        this.updateTime = LocalDateTime.now();
    }
}
