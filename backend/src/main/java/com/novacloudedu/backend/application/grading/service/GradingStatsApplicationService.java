package com.novacloudedu.backend.application.grading.service;

import com.novacloudedu.backend.domain.grading.entity.GradingResult;
import com.novacloudedu.backend.domain.grading.entity.HomeworkSubmission;
import com.novacloudedu.backend.domain.grading.entity.QuestionGrading;
import com.novacloudedu.backend.domain.grading.repository.GradingResultRepository;
import com.novacloudedu.backend.domain.grading.repository.HomeworkSubmissionRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * 批改统计应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class GradingStatsApplicationService {

    private final HomeworkSubmissionRepository submissionRepository;
    private final GradingResultRepository gradingResultRepository;

    /**
     * 获取学生最近N次批改提交（含结果）
     */
    public List<SubmissionWithResult> getRecentSubmissions(Long userId, int limit) {
        List<HomeworkSubmission> submissions = submissionRepository.findByStudentId(
                UserId.of(userId), 1, limit);
        List<SubmissionWithResult> results = new ArrayList<>();
        for (HomeworkSubmission sub : submissions) {
            Optional<GradingResult> result = gradingResultRepository.findBySubmissionId(sub.getId());
            results.add(new SubmissionWithResult(sub, result.orElse(null)));
        }
        return results;
    }

    /**
     * 获取学生总提交数
     */
    public long getTotalSubmissions(Long userId) {
        return submissionRepository.countByStudentId(UserId.of(userId));
    }

    /**
     * 汇总错因分布（遍历最近提交的所有题目）
     */
    public Map<String, Long> getErrorDistribution(Long userId, int recentCount) {
        List<SubmissionWithResult> recent = getRecentSubmissions(userId, recentCount);
        Map<String, Long> distribution = new LinkedHashMap<>();
        for (SubmissionWithResult swr : recent) {
            if (swr.result() == null) continue;
            for (QuestionGrading qg : swr.result().getQuestionGradings()) {
                if (qg.getErrorCategories() != null) {
                    for (String cat : qg.getErrorCategories()) {
                        distribution.merge(cat, 1L, Long::sum);
                    }
                }
            }
        }
        return distribution;
    }

    public record SubmissionWithResult(HomeworkSubmission submission, GradingResult result) {}
}
