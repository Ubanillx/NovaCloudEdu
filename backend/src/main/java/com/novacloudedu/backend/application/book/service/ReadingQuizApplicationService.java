package com.novacloudedu.backend.application.book.service;

import com.novacloudedu.backend.domain.book.entity.Chapter;
import com.novacloudedu.backend.domain.book.entity.ReadingQuiz;
import com.novacloudedu.backend.domain.book.repository.ChapterRepository;
import com.novacloudedu.backend.domain.book.repository.ReadingQuizRepository;
import com.novacloudedu.backend.domain.book.service.LlmService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterId;
import com.novacloudedu.backend.domain.book.valueobject.QuestionDifficulty;
import com.novacloudedu.backend.domain.book.valueobject.QuestionType;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * 阅读测试应用服务
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ReadingQuizApplicationService {

    private final ChapterRepository chapterRepository;
    private final ReadingQuizRepository quizRepository;
    private final LlmService llmService;
    private final Gson gson;

    @Value("${ai.quiz.default-count:5}")
    private int defaultQuestionCount;

    /**
     * 生成阅读测试
     */
    @Transactional
    public ReadingQuiz generateQuiz(Long chapterId, Integer questionCount, String difficulty) {
        ChapterId id = ChapterId.of(chapterId);
        int count = questionCount != null ? questionCount : defaultQuestionCount;
        QuestionDifficulty diff = difficulty != null ? 
                QuestionDifficulty.valueOf(difficulty.toUpperCase()) : QuestionDifficulty.MEDIUM;

        log.info("开始生成阅读测试: chapterId={}, count={}, difficulty={}", chapterId, count, diff);

        // 获取章节内容
        Chapter chapter = chapterRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("章节不存在: " + chapterId));

        // 使用LLM生成测试题
        String systemPrompt = buildSystemPrompt(count, diff);
        String userMessage = buildUserMessage(chapter);
        
        String response = llmService.chatWithSystemPrompt(systemPrompt, userMessage);
        
        // 解析题目
        List<ReadingQuiz.QuizQuestion> questions = parseQuestions(response);
        
        // 创建并保存测试
        ReadingQuiz quiz = ReadingQuiz.create(id, questions, llmService.getModelName());
        ReadingQuiz saved = quizRepository.save(quiz);
        
        log.info("阅读测试生成完成: quizId={}, questionCount={}", saved.getId(), questions.size());
        return saved;
    }

    /**
     * 获取测试
     */
    public Optional<ReadingQuiz> getQuiz(Long quizId) {
        return quizRepository.findById(com.novacloudedu.backend.domain.book.valueobject.ReadingQuizId.of(quizId));
    }

    /**
     * 获取章节的最新测试
     */
    public Optional<ReadingQuiz> getLatestQuiz(Long chapterId) {
        ChapterId id = ChapterId.of(chapterId);
        return quizRepository.findLatestByChapterId(id);
    }

    /**
     * 提交答案并评分
     */
    public int submitAnswers(Long quizId, List<String> userAnswers) {
        ReadingQuiz quiz = quizRepository.findById(
                com.novacloudedu.backend.domain.book.valueobject.ReadingQuizId.of(quizId))
                .orElseThrow(() -> new IllegalArgumentException("测试不存在: " + quizId));
        
        int score = quiz.calculateScore(userAnswers);
        log.info("测试评分完成: quizId={}, score={}", quizId, score);
        return score;
    }

    /**
     * 构建系统提示词
     */
    private String buildSystemPrompt(int count, QuestionDifficulty difficulty) {
        return String.format(
                "你是一个专业的阅读理解测试出题助手。请根据给定的章节内容生成%d道测试题。\n\n" +
                "题目要求：\n" +
                "- 难度：%s\n" +
                "- 题型：选择题、填空题、判断题\n" +
                "- 题目应该覆盖章节的关键内容\n" +
                "- 答案必须能从章节内容中找到依据\n\n" +
                "请以JSON数组格式返回，每道题包含：\n" +
                "- type: 题型（CHOICE/FILL/TRUE_FALSE）\n" +
                "- difficulty: 难度（EASY/MEDIUM/HARD）\n" +
                "- question: 题目\n" +
                "- options: 选项数组（选择题必填）\n" +
                "- correctAnswer: 正确答案\n" +
                "- explanation: 答案解析\n\n" +
                "示例格式：\n" +
                "[{\"type\":\"CHOICE\",\"difficulty\":\"MEDIUM\",\"question\":\"...\",\"options\":[\"A...\",\"B...\"],\"correctAnswer\":\"A\",\"explanation\":\"...\"}]",
                count,
                difficulty.getDescription()
        );
    }

    /**
     * 构建用户消息
     */
    private String buildUserMessage(Chapter chapter) {
        return String.format(
                "章节标题：%s\n\n章节内容：\n%s",
                chapter.getTitle(),
                chapter.getContent()
        );
    }

    /**
     * 解析题目
     */
    private List<ReadingQuiz.QuizQuestion> parseQuestions(String response) {
        List<ReadingQuiz.QuizQuestion> questions = new ArrayList<>();
        
        try {
            // 提取JSON数组
            String jsonStr = extractJsonArray(response);
            JsonArray jsonArray = gson.fromJson(jsonStr, JsonArray.class);
            
            for (JsonElement element : jsonArray) {
                JsonObject obj = element.getAsJsonObject();
                
                String typeStr = obj.get("type").getAsString();
                String diffStr = obj.has("difficulty") ? 
                        obj.get("difficulty").getAsString() : "MEDIUM";
                String question = obj.get("question").getAsString();
                String correctAnswer = obj.get("correctAnswer").getAsString();
                String explanation = obj.has("explanation") ? 
                        obj.get("explanation").getAsString() : "";
                
                List<String> options = new ArrayList<>();
                if (obj.has("options")) {
                    JsonArray optionsArray = obj.getAsJsonArray("options");
                    for (JsonElement opt : optionsArray) {
                        options.add(opt.getAsString());
                    }
                }
                
                QuestionType type;
                try {
                    type = QuestionType.valueOf(typeStr.toUpperCase());
                } catch (IllegalArgumentException e) {
                    log.warn("未知的题型: {}，使用CHOICE", typeStr);
                    type = QuestionType.CHOICE;
                }
                
                QuestionDifficulty difficulty;
                try {
                    difficulty = QuestionDifficulty.valueOf(diffStr.toUpperCase());
                } catch (IllegalArgumentException e) {
                    difficulty = QuestionDifficulty.MEDIUM;
                }
                
                ReadingQuiz.QuizQuestion quizQuestion = ReadingQuiz.QuizQuestion.create(
                        type,
                        difficulty,
                        question,
                        options,
                        correctAnswer,
                        explanation
                );
                questions.add(quizQuestion);
            }
        } catch (Exception e) {
            log.error("解析题目失败", e);
            throw new RuntimeException("题目解析失败: " + e.getMessage(), e);
        }
        
        return questions;
    }

    /**
     * 提取JSON数组
     */
    private String extractJsonArray(String text) {
        int start = text.indexOf('[');
        int end = text.lastIndexOf(']');
        if (start >= 0 && end > start) {
            return text.substring(start, end + 1);
        }
        return text;
    }
}
