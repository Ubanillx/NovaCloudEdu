package com.novacloudedu.backend.domain.book.entity;

import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.QuestionDifficulty;
import com.novacloudedu.backend.domain.book.valueobject.QuestionType;
import com.novacloudedu.backend.domain.book.valueobject.ReadingQuizId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 阅读测试实体
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReadingQuiz {

    private ReadingQuizId id;
    private ChapterId chapterId;
    private List<QuizQuestion> questions;
    private String aiModel;
    private LocalDateTime createTime;

    /**
     * 测试题目
     */
    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class QuizQuestion {
        private QuestionType type;
        private QuestionDifficulty difficulty;
        private String question;
        private List<String> options;
        private String correctAnswer;
        private String explanation;

        public static QuizQuestion create(QuestionType type, QuestionDifficulty difficulty,
                                         String question, List<String> options,
                                         String correctAnswer, String explanation) {
            if (type == null) {
                throw new IllegalArgumentException("题目类型不能为空");
            }
            if (difficulty == null) {
                throw new IllegalArgumentException("难度不能为空");
            }
            if (question == null || question.trim().isEmpty()) {
                throw new IllegalArgumentException("题目不能为空");
            }
            if (correctAnswer == null || correctAnswer.trim().isEmpty()) {
                throw new IllegalArgumentException("正确答案不能为空");
            }

            QuizQuestion quizQuestion = new QuizQuestion();
            quizQuestion.type = type;
            quizQuestion.difficulty = difficulty;
            quizQuestion.question = question.trim();
            quizQuestion.options = options != null ? new ArrayList<>(options) : new ArrayList<>();
            quizQuestion.correctAnswer = correctAnswer.trim();
            quizQuestion.explanation = explanation != null ? explanation.trim() : "";
            return quizQuestion;
        }

        /**
         * 检查答案是否正确
         */
        public boolean checkAnswer(String userAnswer) {
            if (userAnswer == null) {
                return false;
            }
            return this.correctAnswer.equalsIgnoreCase(userAnswer.trim());
        }
    }

    /**
     * 创建阅读测试
     */
    public static ReadingQuiz create(ChapterId chapterId, List<QuizQuestion> questions, String aiModel) {
        if (chapterId == null) {
            throw new IllegalArgumentException("章节ID不能为空");
        }
        if (questions == null || questions.isEmpty()) {
            throw new IllegalArgumentException("题目列表不能为空");
        }
        if (aiModel == null || aiModel.trim().isEmpty()) {
            throw new IllegalArgumentException("AI模型不能为空");
        }

        ReadingQuiz quiz = new ReadingQuiz();
        quiz.chapterId = chapterId;
        quiz.questions = new ArrayList<>(questions);
        quiz.aiModel = aiModel.trim();
        quiz.createTime = LocalDateTime.now();
        return quiz;
    }

    /**
     * 重构阅读测试（从数据库加载）
     */
    public static ReadingQuiz reconstruct(ReadingQuizId id, ChapterId chapterId,
                                         List<QuizQuestion> questions, String aiModel,
                                         LocalDateTime createTime) {
        ReadingQuiz quiz = new ReadingQuiz();
        quiz.id = id;
        quiz.chapterId = chapterId;
        quiz.questions = questions != null ? new ArrayList<>(questions) : new ArrayList<>();
        quiz.aiModel = aiModel;
        quiz.createTime = createTime;
        return quiz;
    }

    /**
     * 添加题目
     */
    public void addQuestion(QuizQuestion question) {
        if (question == null) {
            throw new IllegalArgumentException("题目不能为空");
        }
        this.questions.add(question);
    }

    /**
     * 获取题目总数
     */
    public int getQuestionCount() {
        return questions.size();
    }

    /**
     * 计算得分
     */
    public int calculateScore(List<String> userAnswers) {
        if (userAnswers == null || userAnswers.size() != questions.size()) {
            throw new IllegalArgumentException("答案数量与题目数量不匹配");
        }

        int correctCount = 0;
        for (int i = 0; i < questions.size(); i++) {
            if (questions.get(i).checkAnswer(userAnswers.get(i))) {
                correctCount++;
            }
        }
        return (int) ((correctCount * 100.0) / questions.size());
    }
}
