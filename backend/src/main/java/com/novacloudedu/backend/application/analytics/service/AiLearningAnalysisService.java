package com.novacloudedu.backend.application.analytics.service;

import com.novacloudedu.backend.application.analytics.service.LearningAnalyticsApplicationService.*;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * AI 学情分析服务
 * 调用 LLM 对学情数据进行智能分析，生成自然语言报告
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiLearningAnalysisService {

    private final LangchainChatService langchainChatService;
    private final ExecutorService executor = Executors.newCachedThreadPool();

    private static final String STUDENT_SYSTEM_PROMPT = """
            你是一位专业的教育数据分析师，擅长根据学生的学习数据进行学情诊断。
            请根据以下学情数据，从以下维度进行分析并给出建议：
            
            1. 学习投入度评价：根据学习时长、活动次数评价学生的投入程度
            2. 学科优劣势分析：根据各学科掌握度数据，指出优势学科和薄弱学科
            3. 知识点薄弱环节：指出需要重点加强的知识点方向
            4. 学习习惯诊断：根据打卡、学习频率等数据评价学习习惯
            5. 个性化改进建议：给出具体、可执行的学习建议
            
            要求：
            - 语言亲切、鼓励为主，避免负面打击
            - 建议要具体可执行，不要空泛
            - 使用 Markdown 格式输出
            - 控制在 800 字以内
            """;

    private static final String CLASS_SYSTEM_PROMPT = """
            你是一位专业的教育数据分析师，擅长根据班级整体学习数据进行学情诊断。
            请根据以下班级学情数据，从以下维度进行分析并给出建议：
            
            1. 班级整体学习投入评价：活跃度、学习时长等
            2. 班级学科整体表现：各学科平均掌握度分析
            3. 学习分化情况：优秀学生和需要关注的学生
            4. 教学建议：针对班级薄弱环节提出教学调整建议
            5. 优秀案例：指出表现突出的方面，供班级推广
            
            要求：
            - 面向教师，语言专业、客观
            - 建议要具体可执行
            - 使用 Markdown 格式输出
            - 控制在 1000 字以内
            """;

    /**
     * 生成个人学情 AI 分析报告（SSE 流式返回）
     */
    public SseEmitter analyzeStudent(StudentOverview overview, List<SubjectAnalytics> subjects,
                                      List<TrendItem> recentTrend) {
        String userData = buildStudentDataText(overview, subjects, recentTrend);
        return streamAnalysis(STUDENT_SYSTEM_PROMPT, userData);
    }

    /**
     * 生成班级学情 AI 分析报告（SSE 流式返回）
     */
    public SseEmitter analyzeClass(ClassOverview overview, List<SubjectAnalytics> subjects,
                                    List<TrendItem> recentTrend, List<StudentRanking> topRankings) {
        String classData = buildClassDataText(overview, subjects, recentTrend, topRankings);
        return streamAnalysis(CLASS_SYSTEM_PROMPT, classData);
    }

    // ==================== 私有方法 ====================

    private SseEmitter streamAnalysis(String systemPrompt, String userData) {
        SseEmitter emitter = new SseEmitter(120000L);

        executor.execute(() -> {
            try {
                List<Map<String, String>> messages = new ArrayList<>();
                messages.add(Map.of("role", "system", "content", systemPrompt));
                messages.add(Map.of("role", "user", "content", userData));

                StringBuilder fullResponse = new StringBuilder();
                LangchainChatService.StreamCallback callback = (token) -> {
                    try {
                        fullResponse.append(token);
                        emitter.send(SseEmitter.event()
                                .name("message")
                                .data(token));
                    } catch (IOException e) {
                        log.error("AI学情分析SSE发送失败", e);
                        emitter.completeWithError(e);
                    }
                };

                langchainChatService.streamChat(null, messages, callback);

                emitter.send(SseEmitter.event().name("done").data("[DONE]"));
                emitter.complete();
                log.info("AI学情分析完成，回复字符数: {}", fullResponse.length());

            } catch (Exception e) {
                log.error("AI学情分析异常", e);
                try {
                    emitter.send(SseEmitter.event()
                            .name("error")
                            .data("AI分析失败: " + e.getMessage()));
                } catch (IOException ioException) {
                    log.error("发送错误消息失败", ioException);
                }
                emitter.completeWithError(e);
            }
        });

        return emitter;
    }

    private String buildStudentDataText(StudentOverview o, List<SubjectAnalytics> subjects,
                                         List<TrendItem> trend) {
        StringBuilder sb = new StringBuilder();
        sb.append("## 学生学情数据\n\n");

        sb.append("### 学习概览\n");
        sb.append("- 学习总时长: ").append(formatDuration(o.totalDurationSec())).append("\n");
        sb.append("- 课程观看次数: ").append(o.courseWatchCount()).append("\n");
        sb.append("- 单词学习量: ").append(o.wordStudyCount()).append("\n");
        sb.append("- 文章阅读量: ").append(o.articleReadCount()).append("\n");
        sb.append("- 作业提交次数: ").append(o.homeworkSubmitCount()).append("\n");
        sb.append("- 累计打卡天数: ").append(o.totalCheckinDays()).append("\n");
        sb.append("- 当前连续打卡: ").append(o.currentStreak()).append("天\n");
        sb.append("- 知识点总数: ").append(o.totalKnowledgePoints()).append("\n");
        sb.append("- 薄弱知识点数: ").append(o.weakPointCount()).append("\n\n");

        if (!o.subjectMastery().isEmpty()) {
            sb.append("### 各学科掌握度\n");
            o.subjectMastery().forEach((subject, mastery) ->
                    sb.append("- ").append(subject).append(": ").append(String.format("%.1f%%", mastery * 100)).append("\n"));
            sb.append("\n");
        }

        if (subjects != null && !subjects.isEmpty()) {
            sb.append("### 学科详细数据\n");
            for (SubjectAnalytics s : subjects) {
                sb.append("- ").append(s.subjectName()).append(": 掌握度").append(String.format("%.1f%%", s.avgMasteryLevel() * 100));
                sb.append(", 答题").append(s.totalAttempts()).append("次");
                sb.append(", 正确率").append(String.format("%.1f%%", s.correctRate() * 100));
                sb.append(", 薄弱点").append(s.weakPointCount()).append("个");
                sb.append(", 优势点").append(s.strongPointCount()).append("个\n");
            }
            sb.append("\n");
        }

        if (trend != null && !trend.isEmpty()) {
            sb.append("### 近期学习趋势\n");
            for (TrendItem t : trend) {
                sb.append("- ").append(t.period()).append(": 活动").append(t.activityCount()).append("次");
                sb.append(", 时长").append(formatDuration(t.totalDurationSec())).append("\n");
            }
        }

        return sb.toString();
    }

    private String buildClassDataText(ClassOverview o, List<SubjectAnalytics> subjects,
                                       List<TrendItem> trend, List<StudentRanking> rankings) {
        StringBuilder sb = new StringBuilder();
        sb.append("## 班级学情数据\n\n");

        sb.append("### 班级概览\n");
        sb.append("- 班级人数: ").append(o.memberCount()).append("\n");
        sb.append("- 总学习时长: ").append(formatDuration(o.totalDurationSec())).append("\n");
        sb.append("- 人均学习时长: ").append(formatDuration(o.avgDurationSecPerMember())).append("\n");
        sb.append("- 总活动次数: ").append(o.totalActivities()).append("\n");
        sb.append("- 平均做题得分率: ").append(String.format("%.1f%%", o.avgScoreRate() * 100)).append("\n\n");

        if (o.activityTypeCounts() != null && !o.activityTypeCounts().isEmpty()) {
            sb.append("### 活动类型分布\n");
            o.activityTypeCounts().forEach((type, count) ->
                    sb.append("- ").append(type).append(": ").append(count).append("次\n"));
            sb.append("\n");
        }

        if (subjects != null && !subjects.isEmpty()) {
            sb.append("### 各学科班级平均表现\n");
            for (SubjectAnalytics s : subjects) {
                sb.append("- ").append(s.subjectName()).append(": 平均掌握度").append(String.format("%.1f%%", s.avgMasteryLevel() * 100));
                sb.append(", 正确率").append(String.format("%.1f%%", s.correctRate() * 100));
                sb.append(", 薄弱点").append(s.weakPointCount()).append("个\n");
            }
            sb.append("\n");
        }

        if (rankings != null && !rankings.isEmpty()) {
            sb.append("### 学生排名（前").append(Math.min(rankings.size(), 10)).append("名）\n");
            int rank = 1;
            for (StudentRanking r : rankings.subList(0, Math.min(rankings.size(), 10))) {
                sb.append(rank++).append(". ").append(r.userName());
                sb.append(" - 综合评分").append(String.format("%.2f", r.compositeScore()));
                sb.append(", 时长").append(formatDuration(r.totalDurationSec()));
                sb.append(", 得分率").append(String.format("%.1f%%", r.scoreRate() * 100)).append("\n");
            }
            sb.append("\n");
        }

        if (trend != null && !trend.isEmpty()) {
            sb.append("### 近期学习趋势\n");
            for (TrendItem t : trend) {
                sb.append("- ").append(t.period()).append(": 活动").append(t.activityCount()).append("次");
                sb.append(", 时长").append(formatDuration(t.totalDurationSec())).append("\n");
            }
        }

        return sb.toString();
    }

    private String formatDuration(long totalSec) {
        if (totalSec < 60) return totalSec + "秒";
        if (totalSec < 3600) return (totalSec / 60) + "分钟";
        return String.format("%d小时%d分钟", totalSec / 3600, (totalSec % 3600) / 60);
    }
}
