package com.novacloudedu.backend.application.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.application.exam.command.CreateQuestionCommand;
import com.novacloudedu.backend.domain.exam.valueobject.DifficultyLevel;
import com.novacloudedu.backend.domain.exam.valueobject.QuestionType;
import com.novacloudedu.backend.domain.exam.valueobject.Subject;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.membership.service.AiUsageLimitService;
import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.config.ChatModelProperties;
import com.novacloudedu.backend.infrastructure.ai.ImageGenerationService;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.infrastructure.exam.TypstCompileServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * AI 智能出题服务
 * <p>
 * 支持功能：
 * - 联网搜索热点出题（enableWebSearch）
 * - 几何图形渲染（withDiagram，通过 typst-service cetz）
 * - 文生图配图（withImage，通过 ImageGenerationService）
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiQuestionGenerationService {

    private final LangchainChatService langchainChatService;
    private final QuestionBankApplicationService questionBankApplicationService;
    private final ImageGenerationService imageGenerationService;
    private final TypstCompileServiceImpl typstCompileService;
    private final OssService ossService;
    private final ObjectMapper objectMapper;
    private final ChatModelProperties chatModelProperties;
    private final AiUsageLimitService aiUsageLimitService;

    private final ExecutorService executor = Executors.newCachedThreadPool();

    /**
     * AI 生成题目参数
     */
    public record GenerateParams(
            String subject,
            String type,
            Integer difficulty,
            String grade,
            Integer count,
            String topic,
            Boolean withDiagram,
            Boolean withImage,
            Boolean enableWebSearch,
            String modelId,
            String userInput
    ) {}

    /**
     * SSE 流式生成题目
     */
    public SseEmitter generateQuestions(GenerateParams params, Long userId) {
        aiUsageLimitService.checkAndConsume(userId, AiFeatureType.AI_EXAM);
        SseEmitter emitter = new SseEmitter(600_000L); // 10分钟超时（逐题调用 LLM，20题约需6-8分钟）

        executor.submit(() -> {
            try {
                doGenerate(params, userId, emitter);
            } catch (Exception e) {
                log.error("AI 出题失败", e);
                try {
                    emitter.send(SseEmitter.event()
                            .name("error")
                            .data(Map.of("message", "AI 出题失败: " + e.getMessage())));
                    emitter.complete();
                } catch (IOException ignored) {}
            }
        });

        return emitter;
    }

    private void doGenerate(GenerateParams params, Long userId, SseEmitter emitter) throws Exception {
        int totalCount = params.count();

        // 1. 发送开始事件
        emitter.send(SseEmitter.event()
                .name("started")
                .data(Map.of("count", totalCount, "subject", params.subject(), "type", params.type())));

        // 2. 构建 System Prompt（全局只构建一次）
        String systemPrompt = buildSystemPrompt(params);

        boolean enableSearch = Boolean.TRUE.equals(params.enableWebSearch());
        String modelId = params.modelId() != null && !params.modelId().isBlank()
                ? params.modelId() : chatModelProperties.getDefaultModel();

        // 3. 逐题生成：每次调用 LLM 生成 1 道题，避免超出模型输出 token 限制
        List<Map<String, Object>> savedQuestions = new ArrayList<>();
        List<String> generatedSummaries = new ArrayList<>(); // 已生成题目摘要，避免重复

        for (int idx = 1; idx <= totalCount; idx++) {
            try {
                // 3a. 发送"正在生成第 N 题"事件
                emitter.send(SseEmitter.event()
                        .name("generating")
                        .data(Map.of("index", idx, "total", totalCount,
                                "message", "正在生成第 " + idx + "/" + totalCount + " 题...")));

                // 3b. 构建 User Prompt（每题独立，携带已生成题目摘要）
                String userPrompt = buildSingleQuestionUserPrompt(params, generatedSummaries);

                // 3c. 调用 LLM 生成 1 道题
                StringBuilder sb = new StringBuilder();
                final int[] charCount = {0};
                final long[] lastProgressTime = {System.currentTimeMillis()};
                final int currentIdx = idx;
                langchainChatService.streamChatWithParams(
                        modelId,
                        List.of(
                                Map.of("role", "system", "content", systemPrompt),
                                Map.of("role", "user", "content", userPrompt)
                        ),
                        0.7, 0.9, 2000, enableSearch,
                        token -> {
                            sb.append(token);
                            charCount[0] += token.length();
                            long now = System.currentTimeMillis();
                            if (now - lastProgressTime[0] >= 2000) {
                                lastProgressTime[0] = now;
                                try {
                                    emitter.send(SseEmitter.event()
                                            .name("generating")
                                            .data(Map.of("index", currentIdx, "total", totalCount,
                                                    "message", "第 " + currentIdx + " 题生成中...已输出 " + charCount[0] + " 字")));
                                } catch (Exception ignored) {}
                            }
                        }
                );
                String llmResponse = sb.toString();
                log.info("LLM 第{}题响应长度: {}", idx, llmResponse.length());

                // 3d. 解析 JSON（期望得到 1 道题）
                List<Map<String, Object>> questions = parseQuestionsFromResponse(llmResponse);
                if (questions.isEmpty()) {
                    log.warn("第{}题解析失败，跳过", idx);
                    emitter.send(SseEmitter.event()
                            .name("question_error")
                            .data(Map.of("index", idx, "total", totalCount,
                                    "error", "AI 未能生成有效题目，已跳过")));
                    continue;
                }

                // 取第一道题（LLM 应该只生成 1 道）
                Map<String, Object> q = questions.get(0);
                String content = getStringField(q, "content");

                // 3e. 发送预览事件（generating 状态）
                emitter.send(SseEmitter.event()
                        .name("saving_question")
                        .data(Map.of("index", idx, "total", totalCount,
                                "message", "正在保存第 " + idx + "/" + totalCount + " 题...",
                                "content", content != null ? content : "")));

                // 3f. 几何图形渲染（可选）
                String imageUrl = null;
                String geometryCode = getStringField(q, "geometryCode");
                if (geometryCode != null && Boolean.TRUE.equals(params.withDiagram())) {
                    try {
                        byte[] pngBytes = typstCompileService.renderPng(geometryCode);
                        imageUrl = ossService.uploadBytes(pngBytes, ".png", FileBusinessType.EXAM_QUESTION_IMAGE);
                        log.info("几何图形渲染成功: question={}, url={}", idx, imageUrl);
                    } catch (Exception e) {
                        log.warn("几何图形渲染失败: question={}, error={}", idx, e.getMessage());
                    }
                }

                // 3g. 文生图配图（可选）
                String imagePrompt = getStringField(q, "imagePrompt");
                if (imagePrompt != null && imageUrl == null && Boolean.TRUE.equals(params.withImage())) {
                    try {
                        ImageGenerationService.ImageResult result = imageGenerationService.generateImage(imagePrompt);
                        if (result.success()) {
                            imageUrl = result.imageUrl();
                        }
                    } catch (Exception e) {
                        log.warn("文生图异常: question={}, error={}", idx, e.getMessage());
                    }
                }

                // 3h. 保存到题库
                String optionsStr = buildOptionsString(q);
                CreateQuestionCommand command = new CreateQuestionCommand(
                        params.type(), params.subject(), params.grade(), params.difficulty(),
                        content, optionsStr,
                        getStringField(q, "answer"), getStringField(q, "explanation"),
                        getKnowledgeTags(q), imageUrl, "AI"
                );
                Long questionId = questionBankApplicationService.createQuestion(command);

                // 3i. 发送 question_saved 事件
                Map<String, Object> savedQ = new LinkedHashMap<>();
                savedQ.put("id", String.valueOf(questionId));
                savedQ.put("index", idx);
                savedQ.put("total", totalCount);
                savedQ.put("content", content);
                savedQ.put("options", optionsStr);
                savedQ.put("answer", getStringField(q, "answer"));
                savedQ.put("explanation", getStringField(q, "explanation"));
                savedQ.put("imageUrl", imageUrl);
                savedQ.put("knowledgeTags", getKnowledgeTags(q));
                savedQuestions.add(savedQ);

                emitter.send(SseEmitter.event()
                        .name("question_saved")
                        .data(savedQ));

                // 记录已生成题目摘要，供后续去重
                if (content != null) {
                    String summary = content.length() > 60 ? content.substring(0, 60) + "..." : content;
                    generatedSummaries.add(summary);
                }

            } catch (Exception e) {
                log.error("生成第{}题失败: {}", idx, e.getMessage(), e);
                emitter.send(SseEmitter.event()
                        .name("question_error")
                        .data(Map.of("index", idx, "total", totalCount, "error", e.getMessage())));
            }
        }

        // 4. 完成
        emitter.send(SseEmitter.event()
                .name("done")
                .data(Map.of("total", savedQuestions.size(), "message", "成功生成 " + savedQuestions.size() + " 道题目")));
        emitter.complete();
    }

    // ==================== Prompt 构建 ====================

    private String buildSystemPrompt(GenerateParams params) {
        String subjectName = Subject.fromCode(params.subject()).getDescription();
        String typeName = QuestionType.fromCode(params.type()).getDescription();
        String diffDesc = DifficultyLevel.fromLevel(params.difficulty()).getDescription();

        boolean withDiagram = Boolean.TRUE.equals(params.withDiagram());
        boolean withImage = Boolean.TRUE.equals(params.withImage());
        boolean webSearch = Boolean.TRUE.equals(params.enableWebSearch());

        StringBuilder sb = new StringBuilder();
        sb.append("你是一位专业的").append(subjectName).append("教师，擅长出题。\n");
        sb.append("你需要生成").append(typeName).append("，难度为「").append(diffDesc).append("」。\n\n");

        if (webSearch) {
            sb.append("【重要】请先联网搜索最近的时事新闻、社会热点、科技动态等，然后基于这些真实热点事件出题。\n");
            sb.append("题目必须引用具体的新闻事实、数据或事件，确保时效性和真实性。\n\n");
        }

        // ==================== 公式规范 ====================
        sb.append("【公式规范 — 必须使用 Typst 数学语法，严禁使用 LaTeX】\n\n");
        sb.append("行内公式用 $...$ 包裹（美元符号紧贴内容，中间无空格）。示例：\n");
        sb.append("- 分数: $frac(a, b)$         ✗ 禁止: $\\frac{a}{b}$\n");
        sb.append("- 根号: $sqrt(x + 1)$        ✗ 禁止: $\\sqrt{x+1}$\n");
        sb.append("- n次根: $root(3, x)$        ✗ 禁止: $\\sqrt[3]{x}$\n");
        sb.append("- 下标: $x_(n+1)$            ✗ 禁止: $x_{n+1}$\n");
        sb.append("- 上标: $x^(2n)$             ✗ 禁止: $x^{2n}$\n");
        sb.append("- 单字符上下标可省略括号: $x_n$, $x^2$\n");
        sb.append("- 求和: $sum_(i=1)^n i$\n");
        sb.append("- 积分: $integral_0^1 f(x) dif x$\n");
        sb.append("- 极限: $lim_(n -> infinity) a_n$\n");
        sb.append("- 希腊字母直接写名称（无反斜杠）: $alpha$, $beta$, $pi$, $theta$, $Delta$\n");
        sb.append("- 比较符: $<=$, $>=$, $!=$\n");
        sb.append("- 运算符: $times$, $dot$, $plus.minus$\n");
        sb.append("- 箭头: $->$, $=>$\n");
        sb.append("- 无穷: $infinity$\n");
        sb.append("- 向量: $arrow(v)$ 或 $bold(v)$\n");
        sb.append("- 矩阵: $mat(1, 2; 3, 4)$\n");
        sb.append("- 文本嵌入公式: $f(x) > 0 space \"当\" x > 0$\n\n");
        sb.append("关键差异（务必遵守）:\n");
        sb.append("- Typst 用圆括号 () 包裹多字符上下标，不用花括号 {}\n");
        sb.append("  ✓ 正确: $x_(n+1)$, $a^(2n)$\n");
        sb.append("  ✗ 错误: $x_{n+1}$, $a^{2n}$（花括号会导致编译失败）\n");
        sb.append("- Typst 无反斜杠命令，函数用 name() 语法调用\n");
        sb.append("  ✓ 正确: $frac(a, b)$, $sqrt(x)$\n");
        sb.append("  ✗ 错误: $\\frac{a}{b}$, $\\sqrt{x}$（反斜杠会导致编译失败）\n");
        sb.append("- 微分符号用 dif，不用 d\n");
        sb.append("- 省略号用 dots 或 dots.c，不用 \\cdots\n");
        sb.append("- 【极其重要】在 $...$ 内，多个连续字母必须用空格分开！\n");
        sb.append("  ✓ 正确: $m g$, $m a$, $k x$, $a b$\n");
        sb.append("  ✗ 错误: $mg$, $ma$, $kx$, $ab$（连续字母被视为未定义变量）\n");
        sb.append("  物理量乘积: $F = m a$, $W = m g h$, $p = m v$\n");
        sb.append("  单位请用 upright: $9.8 upright(\"m/s\"^2)$\n");
        sb.append("- 填空题的下划线(____) 绝对不能放在 $...$ 公式内部！\n");
        sb.append("  ✓ 正确: 函数 $f(x)$ 的值域为 ____\n");
        sb.append("  ✗ 错误: 函数 $f(____) = 3$（下划线在公式内会导致编译失败）\n");
        sb.append("  如果公式中需要空位，用 square.stroked: $f(square.stroked) = 3$\n\n");

        // ==================== JSON 输出格式 ====================
        sb.append("【输出格式】\n\n");
        sb.append("直接输出纯 JSON 数组，禁止包裹在 markdown 代码块中，禁止添加任何额外文字。\n");
        sb.append("JSON 结构如下：\n");
        sb.append("[\n  {\n");
        sb.append("    \"content\": \"题干内容（数学公式用 Typst 语法 $...$ 包裹）\",\n");

        if ("SINGLE_CHOICE".equals(params.type()) || "MULTI_CHOICE".equals(params.type())) {
            sb.append("    \"options\": [\n");
            sb.append("      {\"label\": \"A\", \"text\": \"选项内容（可含 Typst 公式）\"},\n");
            sb.append("      {\"label\": \"B\", \"text\": \"选项内容\"},\n");
            sb.append("      {\"label\": \"C\", \"text\": \"选项内容\"},\n");
            sb.append("      {\"label\": \"D\", \"text\": \"选项内容\"}\n");
            sb.append("    ],\n");
        }

        sb.append("    \"answer\": \"标准答案\",\n");
        sb.append("    \"explanation\": \"详细解析（可含 Typst 公式）\",\n");
        sb.append("    \"knowledgeTags\": [\"知识点1\", \"知识点2\"]");

        if (withDiagram) {
            sb.append(",\n    \"geometryCode\": \"Typst cetz 绘图代码（见下方规范）\"");
        }
        if (withImage) {
            sb.append(",\n    \"imagePrompt\": \"英文图片描述（用于 AI 生图，仅需配图时提供）\"");
        }

        sb.append("\n  }\n]\n\n");

        // ==================== 几何图形 ====================
        if (withDiagram) {
            sb.append("【几何图形代码规范——重要】\n\n");
            sb.append("用户已开启几何图形功能。当题目涉及以下内容时，你**必须**提供 geometryCode 字段：\n");
            sb.append("- 平面几何：三角形、四边形、圆、多边形等\n");
            sb.append("- 立体几何：正方体、长方体、棱柱、棱锥、圆柱、圆锥、球等\n");
            sb.append("- 解析几何：坐标系中的直线、曲线、圆锥曲线等\n");
            sb.append("- 函数图像：需要示意图辅助理解的函数题\n");
            sb.append("- 其他需要图形辅助的题目\n\n");
            sb.append("geometryCode 必须是可直接在 Typst 中执行的 cetz 绘图代码。\n\n");
            sb.append("示例1 - 平面三角形：\n");
            sb.append("#cetz.canvas({\n");
            sb.append("  import cetz.draw: *\n");
            sb.append("  line((0, 0), (3, 0), (1.5, 2.6), close: true)\n");
            sb.append("  content((0, -0.3), $A$)\n");
            sb.append("  content((3, -0.3), $B$)\n");
            sb.append("  content((1.5, 2.9), $C$)\n");
            sb.append("})\n\n");
            sb.append("示例2 - 立体几何（正方体 ABCD-A'B'C'D'）：\n");
            sb.append("#cetz.canvas({\n");
            sb.append("  import cetz.draw: *\n");
            sb.append("  // 底面 ABCD\n");
            sb.append("  line((0, 0), (3, 0), (4, 1.2), (1, 1.2), close: true)\n");
            sb.append("  // 顶面 A'B'C'D'\n");
            sb.append("  line((0, 2.5), (3, 2.5), (4, 3.7), (1, 3.7), close: true)\n");
            sb.append("  // 四条竖直棱\n");
            sb.append("  line((0, 0), (0, 2.5))\n");
            sb.append("  line((3, 0), (3, 2.5))\n");
            sb.append("  line((4, 1.2), (4, 3.7))\n");
            sb.append("  line((1, 1.2), (1, 3.7))\n");
            sb.append("  // 顶点标注\n");
            sb.append("  content((-0.3, -0.2), $A$)\n");
            sb.append("  content((3.3, -0.2), $B$)\n");
            sb.append("  content((4.3, 1.0), $C$)\n");
            sb.append("  content((0.7, 1.0), $D$)\n");
            sb.append("  content((-0.4, 2.7), $A'$)\n");
            sb.append("  content((3.3, 2.7), $B'$)\n");
            sb.append("  content((4.4, 3.9), $C'$)\n");
            sb.append("  content((0.6, 3.9), $D'$)\n");
            sb.append("})\n\n");
            sb.append("示例3 - 坐标系：\n");
            sb.append("#cetz.canvas({\n");
            sb.append("  import cetz.draw: *\n");
            sb.append("  // 坐标轴\n");
            sb.append("  set-style(mark: (end: \">\"))\n");
            sb.append("  line((-0.5, 0), (4.5, 0))\n");
            sb.append("  line((0, -0.5), (0, 3.5))\n");
            sb.append("  content((4.7, 0), $x$)\n");
            sb.append("  content((0, 3.8), $y$)\n");
            sb.append("  content((-0.3, -0.3), $O$)\n");
            sb.append("})\n\n");
            sb.append("规则：\n");
            sb.append("1. 只提供 #cetz.canvas({...}) 块，不要包含 #import 语句\n");
            sb.append("2. 立体图形使用斜二测画法，用虚线表示被遮挡的棱: line((0, 0), (1, 1.2), stroke: (dash: \"dashed\"))\n");
            sb.append("3. 所有顶点/关键点必须用 content() 标注字母\n");
            sb.append("4. 图形大小适中，坐标值控制在 0~5 范围内\n");
            sb.append("5. 如果题目不涉及几何图形，则不要提供 geometryCode 字段\n\n");
        }

        // ==================== 题型专用规则 ====================
        sb.append("【规则】\n");
        sb.append("1. 只输出 JSON 数组，禁止任何额外文字或 markdown 标记\n");
        sb.append("2. 每道题提供 2~4 个精准的 knowledgeTags\n");
        sb.append("3. explanation 详细写出解题思路和步骤\n");
        sb.append("4. content/options/answer/explanation 中的数学表达式统一使用 Typst $...$ 语法\n");

        // 题型专用规则
        switch (params.type()) {
            case "SINGLE_CHOICE" -> {
                sb.append("5. 提供 4 个选项（A/B/C/D），answer 为单个字母，如 \"B\"\n");
                sb.append("6. 选项之间应有明确区分度，避免模棱两可\n");
            }
            case "MULTI_CHOICE" -> {
                sb.append("5. 提供 4~6 个选项，answer 为字母组合并按字母顺序排列，如 \"ACD\"\n");
                sb.append("6. 正确选项数量为 2~4 个，不要全选或只选一个\n");
            }
            case "TRUE_FALSE" -> {
                sb.append("5. 不需要 options 字段\n");
                sb.append("6. answer 只能是 \"对\" 或 \"错\"，不要用其他表述\n");
            }
            case "FILL_BLANK" -> {
                sb.append("5. 题干中用 ____（四个下划线）标记每个空位\n");
                sb.append("6. 多个空的答案用英文分号加空格分隔，如 \"3; 5; 7\"\n");
                sb.append("7. 不需要 options 字段\n");
            }
            case "SHORT_ANSWER" -> {
                sb.append("5. 不需要 options 字段\n");
                sb.append("6. answer 必须包含完整的解答过程，不能只写结论\n");
                sb.append("7. answer 的格式：先写解题思路，再分步骤展开论述，最后给出结论\n");
                sb.append("8. 每个步骤用换行分隔，步骤之间逻辑清晰\n");
            }
            case "CALCULATION" -> {
                sb.append("5. 不需要 options 字段\n");
                sb.append("6. answer 必须包含完整的计算过程和最终结果，格式示例：\n");
                sb.append("   解：\n   第一步：列出已知条件...\n   第二步：代入公式...\n   第三步：计算得...\n   答：最终结果为...\n");
                sb.append("7. explanation 从另一个角度补充说明解题方法、易错点或拓展知识\n");
                sb.append("8. answer 和 explanation 中的公式推导每步必须完整，不能跳步\n");
            }
            case "ESSAY" -> {
                sb.append("5. 不需要 options 字段\n");
                sb.append("6. answer 必须是完整的论述，包含：\n");
                sb.append("   - 开头：明确观点/立论\n");
                sb.append("   - 主体：分点论述（至少3个论点），每个论点有论据支撑\n");
                sb.append("   - 结尾：总结归纳\n");
                sb.append("7. explanation 补充说明评分要点和答题注意事项\n");
            }
            default -> {}
        }

        sb.append("\n");
        return sb.toString();
    }

    private String buildSingleQuestionUserPrompt(GenerateParams params, List<String> generatedSummaries) {
        StringBuilder sb = new StringBuilder();
        sb.append("请生成 1 道题目。\n");

        if (params.grade() != null && !params.grade().isBlank()) {
            sb.append("适用年级：").append(params.grade()).append("\n");
        }

        if (params.topic() != null && !params.topic().isBlank()) {
            sb.append("知识点/主题：").append(params.topic()).append("\n");
        }

        if (params.userInput() != null && !params.userInput().isBlank()) {
            sb.append("\n用户补充要求：").append(params.userInput()).append("\n");
        }

        if (Boolean.TRUE.equals(params.enableWebSearch())) {
            sb.append("\n请联网搜索最新时事热点，结合以上要求出题。题目应体现时效性。\n");
        }

        // 携带已生成题目摘要，要求 LLM 避免重复
        if (!generatedSummaries.isEmpty()) {
            sb.append("\n【去重要求——严格遵守】\n");
            sb.append("以下是本轮已生成的题目摘要。你必须确保新生成的题目满足：\n");
            sb.append("1. 题干内容不得与已有题目相同或高度相似（换数字/换名字也算雷同）\n");
            sb.append("2. 考察的核心知识点或解题方法应尽量与已有题目不同\n");
            sb.append("3. 题目情境/背景应有明显区别\n");
            sb.append("已生成题目：\n");
            for (int i = 0; i < generatedSummaries.size(); i++) {
                sb.append("  ").append(i + 1).append(". ").append(generatedSummaries.get(i)).append("\n");
            }
            sb.append("请生成一道与以上题目在内容、知识点、情境上都有显著差异的新题。\n");
        }

        return sb.toString();
    }

    // ==================== JSON 解析 ====================

    private List<Map<String, Object>> parseQuestionsFromResponse(String response) {
        String json = extractJson(response);
        if (json == null) {
            log.warn("无法从 LLM 响应中提取 JSON: {}", response.substring(0, Math.min(200, response.length())));
            return Collections.emptyList();
        }

        try {
            return objectMapper.readValue(json, new TypeReference<>() {});
        } catch (Exception e) {
            log.error("JSON 解析失败: {}", e.getMessage());
            log.debug("JSON 原文: {}", json.substring(0, Math.min(500, json.length())));
            return Collections.emptyList();
        }
    }

    /**
     * 从 LLM 响应中提取 JSON 数组
     */
    private String extractJson(String text) {
        if (text == null || text.isBlank()) return null;

        // 尝试直接解析
        String trimmed = text.trim();
        if (trimmed.startsWith("[")) {
            return trimmed;
        }

        // 从 markdown 代码块中提取
        int start = text.indexOf("```json");
        if (start >= 0) {
            start = text.indexOf('\n', start) + 1;
        } else {
            start = text.indexOf("```");
            if (start >= 0) {
                start = text.indexOf('\n', start) + 1;
            }
        }

        if (start > 0) {
            int end = text.indexOf("```", start);
            if (end > start) {
                return text.substring(start, end).trim();
            }
        }

        // 查找第一个 [ 到最后一个 ]
        int bracketStart = text.indexOf('[');
        int bracketEnd = text.lastIndexOf(']');
        if (bracketStart >= 0 && bracketEnd > bracketStart) {
            return text.substring(bracketStart, bracketEnd + 1);
        }

        return null;
    }

    // ==================== 工具方法 ====================

    private String getStringField(Map<String, Object> map, String key) {
        Object val = map.get(key);
        if (val == null) return null;
        String s = val.toString().trim();
        return s.isEmpty() ? null : s;
    }

    @SuppressWarnings("unchecked")
    private List<String> getKnowledgeTags(Map<String, Object> q) {
        Object tags = q.get("knowledgeTags");
        if (tags instanceof List<?> list) {
            return list.stream().map(Object::toString).toList();
        }
        return null;
    }

    @SuppressWarnings("unchecked")
    private String buildOptionsString(Map<String, Object> q) {
        Object options = q.get("options");
        if (options == null) return null;

        try {
            if (options instanceof List<?> list) {
                return objectMapper.writeValueAsString(list);
            }
            if (options instanceof String s) {
                return s;
            }
            return objectMapper.writeValueAsString(options);
        } catch (Exception e) {
            log.warn("序列化选项失败: {}", e.getMessage());
            return null;
        }
    }
}
