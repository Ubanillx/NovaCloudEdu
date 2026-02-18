package com.novacloudedu.backend.application.grading.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.application.grading.command.SubmitHomeworkCommand;
import com.novacloudedu.backend.domain.exam.entity.ExamPaper;
import com.novacloudedu.backend.domain.exam.entity.PaperQuestion;
import com.novacloudedu.backend.domain.exam.entity.PaperSection;
import com.novacloudedu.backend.domain.exam.entity.Question;
import com.novacloudedu.backend.domain.exam.repository.ExamPaperRepository;
import com.novacloudedu.backend.domain.exam.repository.PaperQuestionRepository;
import com.novacloudedu.backend.domain.exam.repository.PaperSectionRepository;
import com.novacloudedu.backend.domain.exam.repository.QuestionRepository;
import com.novacloudedu.backend.domain.exam.valueobject.ExamPaperId;
import com.novacloudedu.backend.domain.exam.valueobject.PaperSectionId;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.grading.entity.GradingResult;
import com.novacloudedu.backend.domain.grading.entity.HomeworkSubmission;
import com.novacloudedu.backend.domain.grading.entity.QuestionGrading;
import com.novacloudedu.backend.domain.grading.repository.GradingResultRepository;
import com.novacloudedu.backend.domain.grading.repository.HomeworkSubmissionRepository;
import com.novacloudedu.backend.domain.grading.service.GradingDomainService;
import com.novacloudedu.backend.domain.grading.valueobject.GradingMode;
import com.novacloudedu.backend.domain.grading.valueobject.SubmissionId;
import com.novacloudedu.backend.domain.membership.service.AiUsageLimitService;
import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.infrastructure.ocr.OcrService;
import com.novacloudedu.backend.config.ChatModelProperties;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 作业批改应用服务（核心批改引擎）
 * <p>
 * 编排完整批改流程：提交 → OCR → LLM批改 → 错因分析 → 知识画像更新
 * 支持两种模式：
 * - 模式A（有标准答案）：关联 examPaperId → 拉取题库标准答案 → LLM 对比批改
 * - 模式B（无标准答案）：LLM 自行理解题意 → 推断正确性 → 给出评分和评语
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class HomeworkGradingApplicationService {

    private final HomeworkSubmissionRepository submissionRepository;
    private final GradingResultRepository gradingResultRepository;
    private final OcrService ocrService;
    private final LangchainChatService langchainChatService;
    private final GradingDomainService gradingDomainService;
    private final AiUsageLimitService aiUsageLimitService;
    private final ExamPaperRepository examPaperRepository;
    private final PaperSectionRepository paperSectionRepository;
    private final PaperQuestionRepository paperQuestionRepository;
    private final QuestionRepository questionRepository;
    private final ObjectMapper objectMapper;
    private final ChatModelProperties chatModelProperties;

    private final ExecutorService executor = Executors.newCachedThreadPool();

    /**
     * 提交作业并触发异步批改（SSE 流式返回进度）
     */
    public SseEmitter submitAndGrade(SubmitHomeworkCommand command, Long userId) {
        // 检查 AI 配额
        aiUsageLimitService.checkAndConsume(userId, AiFeatureType.AI_GRADING);

        // 解析批改模式
        GradingMode gradingMode = GradingMode.fromCode(command.gradingMode());

        // 解析学科（可空，通用模式下 AI 推断）
        Subject subject = null;
        if (command.subject() != null && !command.subject().isBlank()) {
            try { subject = Subject.fromCode(command.subject()); } catch (Exception ignored) {}
        }

        // 创建提交记录
        HomeworkSubmission submission = HomeworkSubmission.create(
                UserId.of(userId),
                gradingMode,
                command.title(),
                subject,
                command.grade(),
                command.imageUrls(),
                command.classId(),
                command.examPaperId()
        );
        submissionRepository.save(submission);

        log.info("作业提交成功: submissionId={}, userId={}, mode={}, subject={}, images={}",
                submission.getId().getValue(), userId, gradingMode.getCode(),
                subject != null ? subject.getCode() : "AI推断", command.imageUrls().size());

        // SSE 流式返回
        SseEmitter emitter = new SseEmitter(600_000L); // 10 分钟超时

        executor.submit(() -> {
            try {
                doGrading(submission, emitter);
            } catch (Exception e) {
                log.error("批改流程异常: submissionId={}", submission.getId().getValue(), e);
                submission.fail();
                submissionRepository.save(submission);
                try {
                    emitter.send(SseEmitter.event().name("error")
                            .data(Map.of("message", "批改失败: " + e.getMessage())));
                    emitter.complete();
                } catch (IOException ignored) {}
            }
        });

        return emitter;
    }

    /**
     * 查询批改状态
     */
    public Optional<HomeworkSubmission> getSubmission(Long submissionId) {
        return submissionRepository.findById(SubmissionId.of(submissionId));
    }

    /**
     * 获取批改结果
     */
    public Optional<GradingResult> getGradingResult(Long submissionId) {
        return gradingResultRepository.findBySubmissionId(SubmissionId.of(submissionId));
    }

    /**
     * 查询学生批改历史
     */
    public List<HomeworkSubmission> getHistory(Long userId, int page, int size) {
        return submissionRepository.findByStudentId(UserId.of(userId), page, size);
    }

    /**
     * 查询已发布的试卷列表（供学生批改时选择）
     */
    public ExamPaperRepository.ExamPaperPage queryPublishedPapers(String keyword, String subjectCode,
                                                                   String grade, int page, int size) {
        Subject subject = null;
        if (subjectCode != null && !subjectCode.isBlank()) {
            try { subject = Subject.fromCode(subjectCode); } catch (Exception ignored) {}
        }
        ExamPaperRepository.ExamPaperQueryCondition condition = ExamPaperRepository.ExamPaperQueryCondition.of(
                keyword, subject, grade,
                com.novacloudedu.backend.domain.exam.valueobject.PaperStatus.PUBLISHED,
                null, page, size
        );
        return examPaperRepository.findByCondition(condition);
    }

    // ==================== 核心批改流程 ====================

    private void doGrading(HomeworkSubmission submission, SseEmitter emitter) throws Exception {
        Long submissionId = submission.getId().getValue();

        // Step 1: OCR 识别
        emitter.send(SseEmitter.event().name("progress")
                .data(Map.of("step", "ocr", "message", "正在识别作业内容...")));

        submission.startOcr();
        submissionRepository.save(submission);

        OcrService.OcrResult ocrResult = ocrService.recognize(submission.getImageUrls());
        String structuredJson = objectMapper.writeValueAsString(ocrResult.questions());

        submission.updateOcrResult(ocrResult.rawText(), structuredJson);
        submissionRepository.save(submission);

        if (ocrResult.questions().isEmpty()) {
            emitter.send(SseEmitter.event().name("error")
                    .data(Map.of("message", "未能识别出任何题目，请确保图片清晰")));
            submission.fail();
            submissionRepository.save(submission);
            emitter.complete();
            return;
        }

        emitter.send(SseEmitter.event().name("progress")
                .data(Map.of("step", "ocr_done", "message",
                        "识别完成，共识别到 " + ocrResult.questions().size() + " 道题目",
                        "questionCount", ocrResult.questions().size())));

        String modelId = chatModelProperties.getDefaultModel();

        // Step 2: 获取标准答案（试卷批改模式）
        Map<Integer, StandardAnswerInfo> standardAnswers = loadStandardAnswers(submission);

        // Step 2.5: 通用模式且无学科 — 用 AI 推断学科
        if (submission.getSubject() == null && submission.getGradingMode() == GradingMode.GENERAL) {
            try {
                String inferredSubject = inferSubjectFromOcrText(ocrResult.rawText(), modelId);
                if (inferredSubject != null && !inferredSubject.isBlank()) {
                    try {
                        Subject inferred = Subject.fromCode(inferredSubject.trim().toUpperCase());
                        submission.inferSubject(inferred);
                        submissionRepository.save(submission);
                        log.info("AI推断学科: {}", inferred.getCode());
                    } catch (Exception ignored) {}
                }
            } catch (Exception e) {
                log.warn("学科推断失败: {}", e.getMessage());
            }
        }

        // Step 3: LLM 逐题批改
        submission.startGrading();
        submissionRepository.save(submission);
        GradingResult gradingResult = GradingResult.create(submission.getId(), modelId);

        List<OcrService.QuestionBlock> questions = ocrResult.questions();
        for (int i = 0; i < questions.size(); i++) {
            OcrService.QuestionBlock qBlock = questions.get(i);

            emitter.send(SseEmitter.event().name("grading")
                    .data(Map.of("index", i + 1, "total", questions.size(),
                            "message", "正在批改第 " + (i + 1) + "/" + questions.size() + " 题...")));

            StandardAnswerInfo stdInfo = standardAnswers.get(qBlock.index());
            QuestionGrading questionGrading = gradeQuestion(qBlock, stdInfo, modelId);
            gradingResult.addQuestionGrading(questionGrading);

            // 发送单题批改结果
            Map<String, Object> questionResult = new LinkedHashMap<>();
            questionResult.put("index", questionGrading.getQuestionIndex());
            questionResult.put("score", questionGrading.getScore());
            questionResult.put("maxScore", questionGrading.getMaxScore());
            questionResult.put("comment", questionGrading.getComment());
            questionResult.put("errorCategories", questionGrading.getErrorCategories());
            questionResult.put("knowledgePoints", questionGrading.getKnowledgePoints());

            emitter.send(SseEmitter.event().name("question_graded").data(questionResult));
        }

        // Step 4: 生成总评
        String overallComment = generateOverallComment(gradingResult, modelId);
        gradingResult.complete(overallComment);

        // Step 5: 保存批改结果
        gradingResultRepository.save(gradingResult);

        // Step 6: 更新知识画像
        try {
            gradingDomainService.updateKnowledgeProfile(
                    submission.getStudentId(), submission.getSubject(), gradingResult.getQuestionGradings());
        } catch (Exception e) {
            log.warn("知识画像更新失败: {}", e.getMessage());
        }

        // Step 7: 完成
        submission.complete();
        submissionRepository.save(submission);

        Map<String, Object> doneData = new LinkedHashMap<>();
        doneData.put("submissionId", String.valueOf(submissionId));
        doneData.put("totalScore", gradingResult.getTotalScore());
        doneData.put("maxScore", gradingResult.getMaxScore());
        doneData.put("overallComment", overallComment);
        doneData.put("questionCount", gradingResult.getQuestionGradings().size());

        emitter.send(SseEmitter.event().name("done").data(doneData));
        emitter.complete();

        log.info("批改完成: submissionId={}, score={}/{}", submissionId,
                gradingResult.getTotalScore(), gradingResult.getMaxScore());
    }

    // ==================== 标准答案加载 ====================

    private Map<Integer, StandardAnswerInfo> loadStandardAnswers(HomeworkSubmission submission) {
        Map<Integer, StandardAnswerInfo> answers = new HashMap<>();
        if (submission.getExamPaperId() == null) {
            return answers; // 无标准答案模式
        }

        try {
            Optional<ExamPaper> paper = examPaperRepository.findById(
                    ExamPaperId.of(submission.getExamPaperId()));
            if (paper.isEmpty()) return answers;

            // 通过 section -> question 加载标准答案
            List<PaperSection> sections = paperSectionRepository.findByPaperId(
                    ExamPaperId.of(submission.getExamPaperId()));
            List<PaperSectionId> sectionIds = sections.stream()
                    .map(PaperSection::getId).toList();
            List<PaperQuestion> paperQuestions = sectionIds.isEmpty()
                    ? List.of() : paperQuestionRepository.findBySectionIds(sectionIds);

            int index = 1;
            for (PaperQuestion pq : paperQuestions) {
                Optional<Question> question = questionRepository.findById(pq.getQuestionId());
                if (question.isPresent()) {
                    Question q = question.get();
                    answers.put(index, new StandardAnswerInfo(
                            q.getContent(), q.getAnswer(), q.getExplanation(),
                            q.getType().getCode(), pq.getScore(),
                            q.getKnowledgeTags()
                    ));
                }
                index++;
            }
            log.info("加载标准答案: examPaperId={}, 题目数={}", submission.getExamPaperId(), answers.size());
        } catch (Exception e) {
            log.warn("加载标准答案失败: {}", e.getMessage());
        }

        return answers;
    }

    record StandardAnswerInfo(
            String content, String answer, String explanation,
            String questionType, int score, List<String> knowledgeTags
    ) {}

    // ==================== LLM 单题批改 ====================

    private QuestionGrading gradeQuestion(OcrService.QuestionBlock qBlock,
                                           StandardAnswerInfo stdInfo, String modelId) {
        boolean hasStandardAnswer = stdInfo != null && stdInfo.answer() != null;
        int maxScore = 0;
        if (stdInfo != null && stdInfo.score() > 0) {
            maxScore = stdInfo.score();
        } else if (qBlock.metadata() != null && qBlock.metadata().get("maxScore") instanceof Number n) {
            maxScore = n.intValue();
        }
        if (maxScore <= 0) maxScore = 10; // 默认 10 分

        String systemPrompt = buildGradingSystemPrompt(hasStandardAnswer);
        String userPrompt = buildGradingUserPrompt(qBlock, stdInfo, maxScore);

        try {
            StringBuilder sb = new StringBuilder();
            langchainChatService.streamChatWithParams(
                    modelId,
                    List.of(
                            Map.of("role", "system", "content", systemPrompt),
                            Map.of("role", "user", "content", userPrompt)
                    ),
                    0.3, 0.9, 2000, token -> sb.append(token)
            );

            return parseGradingResponse(sb.toString(), qBlock, stdInfo, maxScore);
        } catch (Exception e) {
            log.error("LLM 批改第{}题失败: {}", qBlock.index(), e.getMessage());
            // 返回一个默认的批改结果
            return QuestionGrading.create(
                    qBlock.index(), qBlock.questionContent(), qBlock.questionType(),
                    qBlock.studentAnswer(),
                    stdInfo != null ? stdInfo.answer() : null,
                    0, maxScore,
                    List.of(), "LLM批改异常: " + e.getMessage(),
                    stdInfo != null ? stdInfo.knowledgeTags() : List.of(),
                    "批改失败，请人工复核"
            );
        }
    }

    // ==================== Prompt 构建 ====================

    private String buildGradingSystemPrompt(boolean hasStandardAnswer) {
        StringBuilder sb = new StringBuilder();
        sb.append("你是一位经验丰富、严谨专业的教师，负责批改学生作业。\n\n");

        if (hasStandardAnswer) {
            sb.append("你将获得题目、标准答案和学生答案，请严格按照评分标准逐项打分。\n");
        } else {
            sb.append("你将获得题目和学生答案（无标准答案）。\n");
            sb.append("请根据你的专业知识评估学生作答的正确性和完整性。\n");
            sb.append("如果题目是作文/日记/书写练习等非标准化题目，请从内容质量、语言表达、逻辑结构等维度综合评估。\n");
        }

        sb.append("\n请直接输出纯 JSON，不要添加 markdown 标记或额外文字。\n");
        sb.append("JSON 格式：\n");
        sb.append("{\n");
        sb.append("  \"score\": 得分(整数),\n");
        if (!hasStandardAnswer) {
            sb.append("  \"referenceAnswer\": \"参考答案/正确答案（必填，给出本题的正确解答供学生参考）\",\n");
        }
        sb.append("  \"errorPoints\": [\"扣分点1\", \"扣分点2\"],\n");
        sb.append("  \"errorCategory\": \"错误分类(CONCEPT_ERROR/CALCULATION_ERROR/READING_ERROR/UNIT_ERROR/STEP_MISSING/LOGIC_INCOMPLETE/EXPRESSION_UNCLEAR/GRAMMAR_ERROR/SPELLING_ERROR/FORMAT_ERROR/KNOWLEDGE_GAP/CARELESS_MISTAKE/NONE)\",\n");
        sb.append("  \"knowledgePoints\": [\"知识点1\", \"知识点2\"],\n");
        sb.append("  \"comment\": \"评语（简洁专业，指出优点和不足）\",\n");
        sb.append("  \"stepAnalysis\": \"逐步分析（计算题/解答题适用，其他题型可为空字符串）\"\n");
        sb.append("}\n\n");
        sb.append("规则：\n");
        sb.append("1. score 不能超过满分，不能为负数\n");
        sb.append("2. 如果学生完全正确，errorCategory 填 \"NONE\"，errorPoints 为空数组\n");
        sb.append("3. knowledgePoints 填写 2~4 个相关知识点\n");
        sb.append("4. comment 不超过100字\n");
        sb.append("5. 如果学生未作答，score 为 0\n");
        if (!hasStandardAnswer) {
            sb.append("6. referenceAnswer 必须填写，给出完整的正确答案或参考解答，帮助学生理解正确解法\n");
        }

        return sb.toString();
    }

    private String buildGradingUserPrompt(OcrService.QuestionBlock qBlock,
                                           StandardAnswerInfo stdInfo, int maxScore) {
        StringBuilder sb = new StringBuilder();
        sb.append("【题目信息】\n");
        sb.append("题号: ").append(qBlock.index()).append("\n");
        sb.append("题型: ").append(qBlock.questionType() != null ? qBlock.questionType() : "未知").append("\n");
        sb.append("满分: ").append(maxScore).append("\n");
        sb.append("题干: ").append(qBlock.questionContent()).append("\n");

        if (stdInfo != null) {
            if (stdInfo.answer() != null) {
                sb.append("标准答案: ").append(stdInfo.answer()).append("\n");
            }
            if (stdInfo.explanation() != null) {
                sb.append("解析: ").append(stdInfo.explanation()).append("\n");
            }
        } else {
            sb.append("（无标准答案，请根据题意自行判断）\n");
        }

        sb.append("\n【学生答案】\n");
        if (qBlock.studentAnswer() == null || qBlock.studentAnswer().isBlank()) {
            sb.append("（未作答）\n");
        } else {
            sb.append(qBlock.studentAnswer()).append("\n");
        }

        sb.append("\n请批改并输出 JSON。");
        return sb.toString();
    }

    // ==================== 响应解析 ====================

    private QuestionGrading parseGradingResponse(String response, OcrService.QuestionBlock qBlock,
                                                   StandardAnswerInfo stdInfo, int maxScore) {
        try {
            String json = extractJson(response);
            Map<String, Object> parsed = objectMapper.readValue(json, new TypeReference<>() {});

            int score = 0;
            if (parsed.get("score") instanceof Number n) {
                score = Math.max(0, Math.min(n.intValue(), maxScore));
            }

            List<String> errorCategories = new ArrayList<>();
            String errorCat = parsed.get("errorCategory") instanceof String s ? s : "";
            if (!errorCat.isBlank() && !"NONE".equals(errorCat)) {
                errorCategories.add(errorCat);
            }

            List<String> errorPoints = parsed.get("errorPoints") instanceof List<?> list
                    ? list.stream().map(Object::toString).toList() : List.of();
            String errorDetail = String.join("; ", errorPoints);

            List<String> knowledgePoints = parsed.get("knowledgePoints") instanceof List<?> list
                    ? list.stream().map(Object::toString).toList()
                    : (stdInfo != null && stdInfo.knowledgeTags() != null ? stdInfo.knowledgeTags() : List.of());

            String comment = parsed.get("comment") instanceof String s ? s : "";

            // 通用模式：从 LLM 输出中提取参考答案
            String standardAnswer = stdInfo != null ? stdInfo.answer() : null;
            if (standardAnswer == null && parsed.get("referenceAnswer") instanceof String refAns && !refAns.isBlank()) {
                standardAnswer = refAns;
            }

            return QuestionGrading.create(
                    qBlock.index(), qBlock.questionContent(), qBlock.questionType(),
                    qBlock.studentAnswer(),
                    standardAnswer,
                    score, maxScore,
                    errorCategories, errorDetail, knowledgePoints, comment
            );
        } catch (Exception e) {
            log.warn("解析LLM批改响应失败: {}", e.getMessage());
            return QuestionGrading.create(
                    qBlock.index(), qBlock.questionContent(), qBlock.questionType(),
                    qBlock.studentAnswer(),
                    stdInfo != null ? stdInfo.answer() : null,
                    0, maxScore,
                    List.of(), "解析失败",
                    stdInfo != null ? stdInfo.knowledgeTags() : List.of(),
                    "AI批改结果解析异常，请人工复核"
            );
        }
    }

    // ==================== 总评生成 ====================

    private String generateOverallComment(GradingResult result, String modelId) {
        try {
            int total = result.getQuestionGradings().stream().mapToInt(QuestionGrading::getScore).sum();
            int max = result.getQuestionGradings().stream().mapToInt(QuestionGrading::getMaxScore).sum();
            int count = result.getQuestionGradings().size();
            long correctCount = result.getQuestionGradings().stream()
                    .filter(q -> q.getScore() >= q.getMaxScore()).count();

            String prompt = String.format(
                    "学生完成了%d道题，总分%d/%d，全对%d题。请用2~3句话生成专业简洁的总评语，指出整体表现和改进方向。直接输出评语文本，不要JSON。",
                    count, total, max, correctCount);

            return langchainChatService.chat(modelId, "你是一位专业教师。", prompt);
        } catch (Exception e) {
            log.warn("生成总评失败: {}", e.getMessage());
            return "批改完成，请查看各题详细评分。";
        }
    }

    // ==================== 学科推断 ====================

    /**
     * 通用模式：从 OCR 文本推断学科
     */
    private String inferSubjectFromOcrText(String ocrText, String modelId) {
        if (ocrText == null || ocrText.isBlank()) return null;
        // 截取前500字避免 token 浪费
        String snippet = ocrText.length() > 500 ? ocrText.substring(0, 500) : ocrText;
        String prompt = "根据以下作业内容片段，判断这是哪个学科的作业。" +
                "只需回复一个学科代码，从以下选项中选择：MATH, CHINESE, ENGLISH, PHYSICS, CHEMISTRY, BIOLOGY, HISTORY, GEOGRAPHY, POLITICS。" +
                "如果无法判断，回复 UNKNOWN。不要输出任何其他内容。\n\n" +
                "作业内容：\n" + snippet;
        String result = langchainChatService.chat(modelId, "你是一个学科分类助手。", prompt);
        if (result != null) {
            result = result.trim().toUpperCase().replaceAll("[^A-Z]", "");
            if ("UNKNOWN".equals(result)) return null;
        }
        return result;
    }

    // ==================== 工具方法 ====================

    private String extractJson(String text) {
        if (text == null || text.isBlank()) return "{}";
        String trimmed = text.trim();
        if (trimmed.startsWith("{")) return trimmed;

        int start = text.indexOf("```json");
        if (start >= 0) {
            start = text.indexOf('\n', start) + 1;
        } else {
            start = text.indexOf("```");
            if (start >= 0) start = text.indexOf('\n', start) + 1;
        }
        if (start > 0) {
            int end = text.indexOf("```", start);
            if (end > start) return text.substring(start, end).trim();
        }

        int braceStart = text.indexOf('{');
        int braceEnd = text.lastIndexOf('}');
        if (braceStart >= 0 && braceEnd > braceStart) {
            return text.substring(braceStart, braceEnd + 1);
        }
        return "{}";
    }
}
