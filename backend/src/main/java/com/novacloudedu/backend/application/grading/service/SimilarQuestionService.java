package com.novacloudedu.backend.application.grading.service;

import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.QuestionGrading;
import com.novacloudedu.backend.domain.grading.service.GradingDomainService;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 同类题推荐服务
 * <p>
 * 基于错因分析和知识点，从题库中检索同类题给学生练习。
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class SimilarQuestionService {

    private final QuestionRepository questionRepository;
    private final GradingDomainService gradingDomainService;

    /**
     * 根据错题推荐同类题目
     *
     * @param grading     错题批改详情
     * @param subjectCode 学科代码
     * @param userId      学生ID（用于计算自适应难度）
     * @param limit       推荐数量上限
     * @return 推荐的题目列表
     */
    public List<Question> recommendByGrading(QuestionGrading grading, String subjectCode,
                                              Long userId, int limit) {
        if (grading.getKnowledgePoints() == null || grading.getKnowledgePoints().isEmpty()) {
            return List.of();
        }

        Subject subject = Subject.fromCode(subjectCode);

        // 计算自适应难度
        String mainKp = grading.getKnowledgePoints().get(0);
        int difficulty = gradingDomainService.calculateAdaptiveDifficulty(
                UserId.of(userId), subject, mainKp);

        // 从题库按条件检索
        QuestionRepository.QuestionQueryCondition condition = QuestionRepository.QuestionQueryCondition.of(
                mainKp, null, subject, null, difficulty, null, 1, limit);

        QuestionRepository.QuestionPage page = questionRepository.findByCondition(condition);

        if (!page.questions().isEmpty()) {
            log.info("同类题推荐: knowledgePoint={}, difficulty={}, found={}", mainKp, difficulty, page.questions().size());
            return page.questions();
        }

        // 如果精确匹配无结果，放宽难度搜索
        QuestionRepository.QuestionQueryCondition relaxed = QuestionRepository.QuestionQueryCondition.of(
                mainKp, null, subject, null, null, null, 1, limit);
        QuestionRepository.QuestionPage relaxedPage = questionRepository.findByCondition(relaxed);
        log.info("同类题推荐(放宽): knowledgePoint={}, found={}", mainKp, relaxedPage.questions().size());
        return relaxedPage.questions();
    }

    /**
     * 批量推荐：对一次批改中所有错题推荐同类题
     */
    public List<QuestionRecommendation> recommendForGradingResult(
            List<QuestionGrading> gradings, String subjectCode, Long userId) {
        List<QuestionRecommendation> recommendations = new ArrayList<>();

        for (QuestionGrading grading : gradings) {
            // 只为错题推荐
            if (grading.getScore() >= grading.getMaxScore()) continue;

            List<Question> similar = recommendByGrading(grading, subjectCode, userId, 3);
            if (!similar.isEmpty()) {
                recommendations.add(new QuestionRecommendation(
                        grading.getQuestionIndex(),
                        grading.getKnowledgePoints(),
                        grading.getErrorCategories(),
                        similar
                ));
            }
        }

        return recommendations;
    }

    public record QuestionRecommendation(
            int errorQuestionIndex,
            List<String> knowledgePoints,
            List<String> errorCategories,
            List<Question> recommendedQuestions
    ) {}
}
