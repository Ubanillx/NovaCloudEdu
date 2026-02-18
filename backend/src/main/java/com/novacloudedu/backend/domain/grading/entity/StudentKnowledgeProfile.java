package com.novacloudedu.backend.domain.grading.entity;

import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 学生知识画像实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class StudentKnowledgeProfile {

    private Long id;
    private UserId studentId;
    private Subject subject;
    private String knowledgePoint;
    private double masteryLevel;
    private int totalAttempts;
    private int correctCount;
    private List<String> recentErrorCategories;
    private LocalDateTime lastUpdated;

    /**
     * 创建新的知识画像记录
     */
    public static StudentKnowledgeProfile create(UserId studentId, Subject subject, String knowledgePoint) {
        StudentKnowledgeProfile profile = new StudentKnowledgeProfile();
        profile.studentId = studentId;
        profile.subject = subject;
        profile.knowledgePoint = knowledgePoint;
        profile.masteryLevel = 0.5;
        profile.totalAttempts = 0;
        profile.correctCount = 0;
        profile.recentErrorCategories = new ArrayList<>();
        profile.lastUpdated = LocalDateTime.now();
        return profile;
    }

    /**
     * 从持久化数据重建
     */
    public static StudentKnowledgeProfile reconstruct(Long id, UserId studentId, Subject subject,
                                                       String knowledgePoint, double masteryLevel,
                                                       int totalAttempts, int correctCount,
                                                       List<String> recentErrorCategories,
                                                       LocalDateTime lastUpdated) {
        StudentKnowledgeProfile profile = new StudentKnowledgeProfile();
        profile.id = id;
        profile.studentId = studentId;
        profile.subject = subject;
        profile.knowledgePoint = knowledgePoint;
        profile.masteryLevel = masteryLevel;
        profile.totalAttempts = totalAttempts;
        profile.correctCount = correctCount;
        profile.recentErrorCategories = recentErrorCategories != null ? new ArrayList<>(recentErrorCategories) : new ArrayList<>();
        profile.lastUpdated = lastUpdated;
        return profile;
    }

    /**
     * 记录一次答题（正确）
     */
    public void recordCorrect() {
        this.totalAttempts++;
        this.correctCount++;
        recalculateMastery();
        this.lastUpdated = LocalDateTime.now();
    }

    /**
     * 记录一次答题（错误）
     */
    public void recordError(String errorCategory) {
        this.totalAttempts++;
        if (errorCategory != null && !errorCategory.isBlank()) {
            this.recentErrorCategories.add(errorCategory);
            // 只保留最近10条错误记录
            if (this.recentErrorCategories.size() > 10) {
                this.recentErrorCategories = new ArrayList<>(
                        this.recentErrorCategories.subList(this.recentErrorCategories.size() - 10, this.recentErrorCategories.size()));
            }
        }
        recalculateMastery();
        this.lastUpdated = LocalDateTime.now();
    }

    /**
     * 重新计算掌握度（带衰减因子，近期权重更高）
     */
    private void recalculateMastery() {
        if (totalAttempts == 0) {
            this.masteryLevel = 0.5;
            return;
        }
        // 基础正确率
        double baseRate = (double) correctCount / totalAttempts;
        // 近期表现权重（最近5次）
        int recentWindow = Math.min(5, totalAttempts);
        int recentCorrect = Math.max(0, correctCount - Math.max(0, (totalAttempts - recentWindow) * correctCount / totalAttempts));
        double recentRate = recentWindow > 0 ? (double) recentCorrect / recentWindow : baseRate;
        // 加权：70% 近期 + 30% 历史
        this.masteryLevel = Math.max(0.0, Math.min(1.0, recentRate * 0.7 + baseRate * 0.3));
    }

    /**
     * 是否为薄弱知识点（掌握度 < 0.4 且答题次数 >= 3）
     */
    public boolean isWeakPoint() {
        return totalAttempts >= 3 && masteryLevel < 0.4;
    }
}
