package com.novacloudedu.backend.domain.grading.service;

import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.QuestionGrading;
import com.novacloudedu.backend.domain.grading.entity.StudentKnowledgeProfile;
import com.novacloudedu.backend.domain.grading.repository.StudentKnowledgeProfileRepository;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * 批改领域服务
 * <p>
 * 负责评分规则、知识画像更新、难度自适应等核心领域逻辑。
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class GradingDomainService {

    private final StudentKnowledgeProfileRepository profileRepository;

    /**
     * 根据批改结果更新学生知识画像
     */
    @Transactional
    public void updateKnowledgeProfile(UserId studentId, Subject subject, List<QuestionGrading> gradings) {
        for (QuestionGrading grading : gradings) {
            List<String> knowledgePoints = grading.getKnowledgePoints();
            if (knowledgePoints == null || knowledgePoints.isEmpty()) {
                continue;
            }

            boolean isCorrect = grading.getScore() >= grading.getMaxScore();
            String mainErrorCategory = (grading.getErrorCategories() != null && !grading.getErrorCategories().isEmpty())
                    ? grading.getErrorCategories().get(0) : null;

            for (String kp : knowledgePoints) {
                Optional<StudentKnowledgeProfile> existing =
                        profileRepository.findByStudentAndSubjectAndPoint(studentId, subject, kp);

                StudentKnowledgeProfile profile;
                if (existing.isPresent()) {
                    profile = existing.get();
                } else {
                    profile = StudentKnowledgeProfile.create(studentId, subject, kp);
                }

                if (isCorrect) {
                    profile.recordCorrect();
                } else {
                    profile.recordError(mainErrorCategory);
                }

                profileRepository.save(profile);
            }
        }

        log.info("知识画像更新完成: studentId={}, subject={}, 题目数={}", 
                studentId.value(), subject.getCode(), gradings.size());
    }

    /**
     * 根据知识画像计算推荐难度（1~5）
     */
    public int calculateAdaptiveDifficulty(UserId studentId, Subject subject, String knowledgePoint) {
        Optional<StudentKnowledgeProfile> profile =
                profileRepository.findByStudentAndSubjectAndPoint(studentId, subject, knowledgePoint);

        if (profile.isEmpty()) {
            return 3; // 默认中等难度
        }

        double mastery = profile.get().getMasteryLevel();
        if (mastery >= 0.8) return 5;
        if (mastery >= 0.6) return 4;
        if (mastery >= 0.4) return 3;
        if (mastery >= 0.2) return 2;
        return 1;
    }
}
