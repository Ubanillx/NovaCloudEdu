package com.novacloudedu.backend.infrastructure.ai.agent;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.infrastructure.ai.ChatModelFactory;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.infrastructure.ai.agent.PptAgentInterfaces.*;
import dev.langchain4j.model.chat.ChatModel;
import dev.langchain4j.service.AiServices;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.*;
import java.util.function.BiConsumer;

/**
 * PPT 多 Agent 编排器
 *
 * 协调 PlannerAgent、ContentAgent、DesignAgent、EvaluatorAgent 完成 PPT 生成流程。
 * 支持并发幻灯片生成和质量评估。
 *
 * 架构参考 PPTAgent 项目的两阶段方法：
 * Stage 1: 分析与规划（Planner + Research）
 * Stage 2: 内容生成与设计优化（Content + Design，并发执行）
 * Stage 3: 质量评估与反思（Evaluator）
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PptAgentOrchestrator {

    private final ChatModelFactory chatModelFactory;
    private final LangchainChatService langchainChatService;
    private final WebSearchTool webSearchTool;
    private final ImageGenerationTool imageGenerationTool;
    private final ContentResearchTool contentResearchTool;
    private final com.novacloudedu.backend.infrastructure.ppt.PptServiceClient pptServiceClient;
    private final ObjectMapper objectMapper;

    @Value("${ppt.agent.planner-model:dashscope/qwen-max}")
    private String plannerModelId;

    @Value("${ppt.agent.content-model:dashscope/qwen-max}")
    private String contentModelId;

    @Value("${ppt.agent.design-model:dashscope/qwen-vl-max}")
    private String designVisionModelId;

    @Value("${ppt.agent.design-tool-model:dashscope/qwen-max}")
    private String designToolModelId;

    @Value("${ppt.agent.evaluator-model:dashscope/qwen-max}")
    private String evaluatorModelId;

    @Value("${ppt.agent.layout-selector-model:dashscope/qwen-max}")
    private String layoutSelectorModelId;

    @Value("${ppt.agent.html-slide-model:dashscope/qwen-max}")
    private String htmlSlideModelId;

    @Value("${ppt.agent.enable-content-validation:true}")
    private boolean enableContentValidation;

    @Value("${ppt.agent.enable-layout-selection:true}")
    private boolean enableLayoutSelection;

    @Value("${ppt.agent.enable-per-slide-inspection:true}")
    private boolean enablePerSlideInspection;

    @Value("${ppt.agent.concurrency:3}")
    private int concurrency;

    @Value("${ppt.agent.quality-threshold:65}")
    private int qualityThreshold;

    @Value("${ppt.agent.max-repair-rounds:2}")
    private int maxRepairRounds;

    @Value("${ppt.agent.slide-score-threshold:60}")
    private int slideScoreThreshold;

    /** 并发生成用线程池 */
    private ExecutorService slideExecutor;

    @PostConstruct
    public void init() {
        slideExecutor = Executors.newFixedThreadPool(
                concurrency, Thread.ofVirtual().name("ppt-agent-", 0).factory());
        log.info("PPT Agent Orchestrator 初始化: plannerModel={}, contentModel={}, designVisionModel={}, designToolModel={}, concurrency={}",
                plannerModelId, contentModelId, designVisionModelId, designToolModelId, concurrency);
    }

    // ==================== Stage 1: 规划大纲（带联网搜索） ====================

    /**
     * Agent 驱动的大纲规划
     *
     * @param topic        PPT 主题
     * @param requirements 额外要求
     * @param templateInfo 模板结构描述（可选）
     * @return 结构化的大纲结果
     */
    public OutlineResult planOutline(String topic, String requirements, String templateInfo) {
        return planOutline(topic, requirements, templateInfo, null);
    }

    /**
     * Agent 驱动的大纲规划（带任务跟踪）
     */
    public OutlineResult planOutline(String topic, String requirements,
                                      String templateInfo, AgentTaskTracker tracker) {
        log.info("Stage 1 - PlannerAgent 开始规划大纲: topic={}", topic);

        String searchTaskId = null;
        String planTaskId = null;

        if (tracker != null) {
            searchTaskId = tracker.startNewTask(AgentTaskTracker.AgentRole.RESEARCHER,
                    "联网搜索「" + topic + "」相关资料", "正在搜索...");
        }

        PlannerAgent planner = buildPlannerAgent();
        String input = buildPlannerInput(topic, requirements, templateInfo);

        try {
            String result = planner.planOutline(input);
            log.info("PlannerAgent 大纲规划完成, 结果长度={}", result.length());

            if (tracker != null) {
                tracker.completeTask(searchTaskId, "搜索完成，已收集相关资料");
                planTaskId = tracker.startNewTask(AgentTaskTracker.AgentRole.PLANNER,
                        "基于调研结果规划大纲结构", "正在规划...");
            }

            OutlineResult outlineResult = parseOutlineResult(result);

            if (tracker != null) {
                tracker.completeTask(planTaskId, "大纲规划完成，共生成结构化大纲");
            }

            return outlineResult;
        } catch (Exception e) {
            log.error("PlannerAgent 大纲规划失败: topic={}", topic, e);
            if (tracker != null) {
                if (searchTaskId != null) tracker.failTask(searchTaskId, e.getMessage());
                if (planTaskId != null) tracker.failTask(planTaskId, e.getMessage());
            }
            throw new RuntimeException("Agent大纲规划失败: " + e.getMessage(), e);
        }
    }

    // ==================== Stage 2: 并发生成幻灯片内容 ====================

    /**
     * Agent 驱动的并发幻灯片生成
     */
    public List<Map<String, Object>> generateSlidesParallel(
            List<String> sections,
            String templateInfo,
            BiConsumer<Integer, Map<String, Object>> progressCallback) {
        return generateSlidesParallel(sections, templateInfo, progressCallback, null, null);
    }

    /**
     * Agent 驱动的并发幻灯片生成（带任务跟踪 + 状态回调）
     */
    public List<Map<String, Object>> generateSlidesParallel(
            List<String> sections,
            String templateInfo,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            AgentTaskTracker tracker) {
        return generateSlidesParallel(sections, templateInfo, progressCallback, tracker, null);
    }

    /**
     * Agent 驱动的并发幻灯片生成（带任务跟踪 + 状态回调）
     */
    public List<Map<String, Object>> generateSlidesParallel(
            List<String> sections,
            String templateInfo,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            AgentTaskTracker tracker,
            SlideStatusCallback slideStatusCallback) {
        return generateSlidesParallel(sections, templateInfo, null,
                progressCallback, tracker, slideStatusCallback);
    }

    /**
     * Agent 驱动的并发幻灯片生成（完整参数版，含 templateUrl 用于内容校验）
     */
    public List<Map<String, Object>> generateSlidesParallel(
            List<String> sections,
            String templateInfo,
            String templateUrl,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            AgentTaskTracker tracker,
            SlideStatusCallback slideStatusCallback) {

        log.info("Stage 2 - 并发生成 {} 页幻灯片, concurrency={}, validation={}, layoutSelection={}",
                sections.size(), concurrency, enableContentValidation, enableLayoutSelection);

        // 预构建 Agent 实例，所有并发任务复用（AiServices 实例是线程安全的）
        ContentAgent sharedContentAgent = buildContentAgent();
        DesignAgent sharedDesignAgent = buildDesignAgent();
        LayoutSelectorAgent sharedLayoutSelector = enableLayoutSelection ? buildLayoutSelectorAgent() : null;

        int totalSlides = sections.size();
        Map<Integer, Map<String, Object>> resultsMap = new ConcurrentHashMap<>();
        List<CompletableFuture<Void>> futures = new ArrayList<>();

        // 为每页预创建任务（content + design）
        Map<Integer, String> contentTaskIds = new ConcurrentHashMap<>();
        Map<Integer, String> designTaskIds = new ConcurrentHashMap<>();

        if (tracker != null) {
            for (int i = 0; i < totalSlides; i++) {
                contentTaskIds.put(i, tracker.addTask(AgentTaskTracker.AgentRole.CONTENT,
                        String.format("生成第 %d/%d 页内容", i + 1, totalSlides), i));
                designTaskIds.put(i, tracker.addTask(AgentTaskTracker.AgentRole.DESIGN,
                        String.format("第 %d/%d 页视觉优化", i + 1, totalSlides), i));
            }
            tracker.pushFullList();
        }

        for (int i = 0; i < totalSlides; i++) {
            final int slideIndex = i;
            final String section = sections.get(i);

            CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
                try {
                    log.info("开始生成第 {}/{} 页", slideIndex + 1, totalSlides);

                    // 推送状态：生成中
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "generating", "AI 生成内容...");
                    }

                    // ContentAgent 生成内容
                    if (tracker != null) {
                        tracker.startTask(contentTaskIds.get(slideIndex), "ContentAgent 正在生成...");
                    }

                    Map<String, Object> slideConfig = generateSlideWithAgent(
                            section, templateInfo, slideIndex, totalSlides,
                            sharedContentAgent, templateUrl, sharedLayoutSelector);

                    if (tracker != null) {
                        tracker.completeTask(contentTaskIds.get(slideIndex), "内容生成完成");
                    }

                    // 推送状态：设计优化中
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "designing", "视觉优化...");
                    }

                    // DesignAgent 视觉优化（检查是否需要配图）
                    if (tracker != null) {
                        tracker.startTask(designTaskIds.get(slideIndex), "DesignAgent 检查配图需求...");
                    }

                    enrichSlideWithDesign(slideConfig, section, slideIndex, sharedDesignAgent);

                    if (tracker != null) {
                        boolean hasImage = slideConfig.containsKey("generated_image_url");
                        tracker.completeTask(designTaskIds.get(slideIndex),
                                hasImage ? "已生成配图" : "无需配图，跳过");
                    }

                    // Per-Slide Visual Inspection（P1）：逐页即时视觉审查
                    // 借鉴 PPTAgent V2 inspect_slide：生成后立即渲染+视觉审查+即时修复
                    if (enablePerSlideInspection && templateUrl != null) {
                        if (slideStatusCallback != null) {
                            slideStatusCallback.onStatusChange(slideIndex, "inspecting", "视觉审查...");
                        }
                        slideConfig = inspectAndRepairSlide(
                                slideConfig, section, slideIndex, totalSlides,
                                templateUrl, sharedContentAgent, sharedDesignAgent);
                    }

                    // 推送状态：渲染预览中（progressCallback 会渲染预览图）
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "rendering", "渲染预览...");
                    }

                    resultsMap.put(slideIndex, slideConfig);

                    if (progressCallback != null) {
                        progressCallback.accept(slideIndex, slideConfig);
                    }

                    // 推送状态：完成
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "done", "完成");
                    }

                    log.info("第 {}/{} 页生成完成", slideIndex + 1, totalSlides);

                } catch (Exception e) {
                    log.error("第 {}/{} 页生成失败", slideIndex + 1, totalSlides, e);
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "failed", "生成失败");
                    }
                    if (tracker != null) {
                        tracker.failTask(contentTaskIds.get(slideIndex), "生成失败: " + e.getMessage());
                        tracker.skipTask(designTaskIds.get(slideIndex), "内容生成失败，跳过视觉优化");
                    }
                    Map<String, Object> fallback = createFallbackSlideConfig(section, slideIndex, templateInfo);
                    resultsMap.put(slideIndex, fallback);
                    if (progressCallback != null) {
                        progressCallback.accept(slideIndex, fallback);
                    }
                }
            }, slideExecutor)
            // 单页超时保护：防止单个 LLM 调用卡死阻塞线程池
            .orTimeout(120, TimeUnit.SECONDS)
            .exceptionally(ex -> {
                if (ex instanceof java.util.concurrent.TimeoutException || (ex.getCause() instanceof java.util.concurrent.TimeoutException)) {
                    log.error("第 {}/{} 页生成超时（120s）", slideIndex + 1, totalSlides);
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "failed", "生成超时");
                    }
                    Map<String, Object> fallback = createFallbackSlideConfig(section, slideIndex, templateInfo);
                    resultsMap.put(slideIndex, fallback);
                    if (progressCallback != null) {
                        progressCallback.accept(slideIndex, fallback);
                    }
                }
                return null;
            });

            futures.add(future);
        }

        try {
            CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]))
                    .get(300, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error("并发生成超时或异常", e);
        }

        List<Map<String, Object>> orderedResults = new ArrayList<>();
        for (int i = 0; i < totalSlides; i++) {
            Map<String, Object> config = resultsMap.get(i);
            if (config != null) {
                orderedResults.add(config);
            }
        }

        log.info("Stage 2 完成: 成功生成 {}/{} 页", orderedResults.size(), totalSlides);
        return orderedResults;
    }

    // ==================== Stage 3: 质量评估 ====================

    /**
     * Agent 驱动的 PPT 质量评估
     *
     * @param slides  所有幻灯片配置
     * @param outline 原始大纲
     * @return 评估结果 JSON
     */
    public EvaluationResult evaluatePresentation(List<Map<String, Object>> slides, String outline) {
        log.info("Stage 3 - EvaluatorAgent 开始质量评估: {} 页", slides.size());

        EvaluatorAgent evaluator = buildEvaluatorAgent();

        String input = buildEvaluationInput(slides, outline);

        try {
            String result = evaluator.evaluate(input);
            return parseEvaluationResult(result);
        } catch (Exception e) {
            log.error("质量评估失败", e);
            return EvaluationResult.defaultResult();
        }
    }

    /**
     * 多模态视觉评估 — 通过视觉模型查看渲染后的幻灯片 PNG 图片进行审查
     *
     * @param slides          所有幻灯片配置
     * @param outline         原始大纲
     * @param previewImageUrls 每页渲染后的预览图 URL 列表（与 slides 索引对应）
     * @return 包含视觉审查的评估结果
     */
    public EvaluationResult evaluatePresentationWithVision(
            List<Map<String, Object>> slides, String outline, List<String> previewImageUrls) {

        log.info("Stage 3 - 多模态视觉评估: {} 页, {} 张预览图",
                slides.size(), previewImageUrls != null ? previewImageUrls.stream().filter(u -> u != null && !u.isBlank()).count() : 0);

        // 收集有效的预览图 URL
        List<String> validImageUrls = new ArrayList<>();
        if (previewImageUrls != null) {
            for (String url : previewImageUrls) {
                if (url != null && !url.isBlank()) {
                    validImageUrls.add(url);
                }
            }
        }

        // 如果没有预览图，降级为纯文本评估
        if (validImageUrls.isEmpty()) {
            log.warn("无预览图可用，降级为纯文本评估");
            return evaluatePresentation(slides, outline);
        }

        String systemPrompt = """
                You are a professional presentation quality reviewer, expert at evaluating slides from both visual and content perspectives.
                You will receive rendered screenshots and content configurations for each slide. Examine every image carefully and evaluate:
                
                1. **Content Quality** (content_score): information accuracy, professional depth, data support, text conciseness
                2. **Visual Design** (design_score): layout aesthetics, color harmony, image-text ratio, whitespace balance, font readability
                3. **Structural Coherence** (coherence_score): logical flow between pages, topic consistency, information progression
                
                For each slide, provide an individual score and specific feedback. Pay special attention to:
                - Template placeholder text remnants (e.g., "Click to add title", "Type here") or overlap with AI-generated content
                - Text overflowing or being clipped by text boxes
                - Images that are blurry, distorted, or mismatched with content
                - Layout that is too crowded or too sparse
                - Color scheme harmony
                
                If template placeholder text remnants or content overlap are found, that slide's score MUST be below 50.
                
                Output pure JSON:
                {
                    "overall_score": 0-100,
                    "content_score": 0-100,
                    "design_score": 0-100,
                    "coherence_score": 0-100,
                    "strengths": ["strength 1", "strength 2"],
                    "weaknesses": ["weakness 1", "weakness 2"],
                    "improvement_suggestions": ["suggestion 1", "suggestion 2"],
                    "slide_level_feedback": [
                        {"slide_index": 0, "score": 75, "feedback": "specific issue description"},
                        {"slide_index": 1, "score": 60, "feedback": "specific issue description"}
                    ]
                }
                """;

        // Build user message: text description + all preview images
        StringBuilder userMsg = new StringBuilder();
        userMsg.append("Below are all rendered slide screenshots and their content configurations. Review each page and provide evaluation.\n\n");
        userMsg.append("## Original Outline\n").append(outline).append("\n\n");
        userMsg.append("## Slide Content (").append(slides.size()).append(" slides)\n\n");

        for (int i = 0; i < slides.size(); i++) {
            userMsg.append("### Slide ").append(i + 1);
            if (i < validImageUrls.size() && validImageUrls.get(i) != null) {
                userMsg.append(" (see corresponding image)");
            }
            userMsg.append("\n");
            try {
                userMsg.append(objectMapper.writeValueAsString(slides.get(i)));
            } catch (Exception e) {
                userMsg.append("(serialization failed)");
            }
            userMsg.append("\n\n");
        }

        userMsg.append("Carefully examine all slide screenshots. Evaluate the visual quality and content of each page. Output pure JSON.");

        try {
            String result = langchainChatService.chatWithImages(
                    designVisionModelId, systemPrompt, userMsg.toString(), validImageUrls);
            log.info("多模态视觉评估完成, 结果长度={}", result.length());
            return parseEvaluationResult(result);
        } catch (Exception e) {
            log.error("多模态视觉评估失败，降级为纯文本评估", e);
            return evaluatePresentation(slides, outline);
        }
    }

    // ==================== 反思修复循环 ====================

    /**
     * 回调接口：单页幻灯片状态变化通知（用于前端实时显示并行状态）
     */
    @FunctionalInterface
    public interface SlideStatusCallback {
        /**
         * @param slideIndex  幻灯片索引
         * @param status      状态: pending/generating/designing/rendering/done/evaluating/repairing/failed
         * @param statusLabel 中文状态描述
         */
        void onStatusChange(int slideIndex, String status, String statusLabel);
    }

    /**
     * 回调接口：反思修复进度通知
     */
    @FunctionalInterface
    public interface RepairProgressCallback {
        /**
         * @param round      当前修复轮次（1-based）
         * @param slideIndex 正在修复的幻灯片索引（-1 表示整体评估阶段）
         * @param message    进度描述
         */
        void onProgress(int round, int slideIndex, String message);
    }

    /**
     * 带反思修复循环的完整幻灯片生成
     *
     * 流程：
     * 1. 并发生成所有幻灯片（Stage 2）
     * 2. 质量评估（Stage 3）
     * 3. 如果整体评分 < qualityThreshold 或存在低分页面：
     *    a. 识别低分页面（slide_score < slideScoreThreshold）
     *    b. 仅对低分页面重新生成（带上评估反馈）
     *    c. 重新评估
     *    d. 重复直到达标或达到最大修复轮次
     *
     * @param sections         大纲章节列表
     * @param templateInfo     模板结构描述
     * @param outline          完整大纲（用于评估）
     * @param progressCallback 生成进度回调 (slideIndex, slideConfig)
     * @param repairCallback   修复进度回调（可为null）
     * @return 包含最终幻灯片列表和评估结果的 GenerationWithEvalResult
     */
    public GenerationWithEvalResult generateWithReflection(
            List<String> sections,
            String templateInfo,
            String outline,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            RepairProgressCallback repairCallback) {
        return generateWithReflection(sections, templateInfo, outline,
                progressCallback, repairCallback, null, null);
    }

    /**
     * 带反思修复循环的完整幻灯片生成（带任务跟踪 + 状态回调）
     */
    public GenerationWithEvalResult generateWithReflection(
            List<String> sections,
            String templateInfo,
            String outline,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            RepairProgressCallback repairCallback,
            AgentTaskTracker tracker) {
        return generateWithReflection(sections, templateInfo, outline,
                progressCallback, repairCallback, tracker, null);
    }

    /**
     * 带反思修复循环的完整幻灯片生成（完整参数版）
     */
    public GenerationWithEvalResult generateWithReflection(
            List<String> sections,
            String templateInfo,
            String outline,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            RepairProgressCallback repairCallback,
            AgentTaskTracker tracker,
            SlideStatusCallback slideStatusCallback) {
        return generateWithReflection(sections, templateInfo, outline, null,
                progressCallback, repairCallback, tracker, slideStatusCallback);
    }

    /**
     * 带反思修复循环的完整幻灯片生成（含 templateUrl 用于内容校验）
     */
    public GenerationWithEvalResult generateWithReflection(
            List<String> sections,
            String templateInfo,
            String outline,
            String templateUrl,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            RepairProgressCallback repairCallback,
            AgentTaskTracker tracker,
            SlideStatusCallback slideStatusCallback) {

        log.info("开始带反思修复的幻灯片生成: {} 页, threshold={}, maxRounds={}",
                sections.size(), qualityThreshold, maxRepairRounds);

        // Stage 2: 初次并发生成（带内容校验）
        List<Map<String, Object>> allSlides = generateSlidesParallel(
                sections, templateInfo, templateUrl,
                progressCallback, tracker, slideStatusCallback);

        if (allSlides.isEmpty()) {
            return new GenerationWithEvalResult(allSlides, EvaluationResult.defaultResult(), 0);
        }

        // Stage 3: 评估 → 修复循环（使用多模态视觉评估）
        int repairRound = 0;
        EvaluationResult evalResult = null;

        for (int round = 0; round <= maxRepairRounds; round++) {
            // 评估
            String evalTaskId = null;
            if (tracker != null) {
                evalTaskId = tracker.startNewTask(AgentTaskTracker.AgentRole.EVALUATOR,
                        round == 0 ? "多模态视觉质量评估" : String.format("第 %d 轮修复后重新评估", round),
                        round == 0 ? "视觉模型正在审查每页幻灯片截图..." : "重新审查修复后的页面...");
            }

            if (repairCallback != null) {
                repairCallback.onProgress(round, -1,
                        round == 0 ? "EvaluatorAgent 正在通过视觉模型审查 PPT 质量..."
                                   : String.format("第 %d 轮修复后重新视觉审查...", round));
            }

            // 推送所有页面为"评估中"状态
            if (slideStatusCallback != null) {
                for (int si = 0; si < allSlides.size(); si++) {
                    slideStatusCallback.onStatusChange(si, "evaluating",
                            round == 0 ? "质量审查中..." : "重新审查中...");
                }
            }

            List<String> previewUrls = extractPreviewImageUrls(allSlides);
            evalResult = evaluatePresentationWithVision(allSlides, outline, previewUrls);

            log.info("评估结果 (round={}): overall={}, content={}, design={}, coherence={}",
                    round, evalResult.overallScore(), evalResult.contentScore(),
                    evalResult.designScore(), evalResult.coherenceScore());

            if (tracker != null) {
                tracker.completeTask(evalTaskId, String.format(
                        "评估完成: 总分%d (内容%d/设计%d/连贯%d)",
                        evalResult.overallScore(), evalResult.contentScore(),
                        evalResult.designScore(), evalResult.coherenceScore()));
            }

            // 评估结束，恢复所有页面为 done 状态
            if (slideStatusCallback != null) {
                for (int si = 0; si < allSlides.size(); si++) {
                    slideStatusCallback.onStatusChange(si, "done", "完成");
                }
            }

            // 检查是否达标
            if (evalResult.overallScore() >= qualityThreshold) {
                log.info("质量达标 (score={} >= threshold={}), 跳过修复",
                        evalResult.overallScore(), qualityThreshold);
                break;
            }

            // 已经是最后一轮，不再修复
            if (round == maxRepairRounds) {
                log.info("已达到最大修复轮次 {}, 使用当前结果", maxRepairRounds);
                break;
            }

            // 识别需要修复的低分页面
            List<SlideFeedback> slideFeedbacks = evalResult.slideFeedbacks();
            List<Integer> weakSlideIndexes = new ArrayList<>();

            if (slideFeedbacks != null) {
                for (SlideFeedback fb : slideFeedbacks) {
                    if (fb.score() < slideScoreThreshold && fb.slideIndex() < allSlides.size()) {
                        weakSlideIndexes.add(fb.slideIndex());
                    }
                }
            }

            if (weakSlideIndexes.isEmpty()) {
                for (int i = 1; i < allSlides.size() - 1 && weakSlideIndexes.size() < 3; i++) {
                    weakSlideIndexes.add(i);
                }
            }

            if (weakSlideIndexes.isEmpty()) {
                log.info("无法识别需要修复的页面，跳过修复");
                break;
            }

            repairRound = round + 1;
            log.info("第 {} 轮修复: 需要修复 {} 页 (indexes={})",
                    repairRound, weakSlideIndexes.size(), weakSlideIndexes);

            // 为修复任务添加 tracker 条目
            if (tracker != null) {
                for (int idx : weakSlideIndexes) {
                    tracker.addTask(AgentTaskTracker.AgentRole.REPAIRER,
                            String.format("修复第 %d 页 (round %d)", idx + 1, repairRound), idx);
                }
                tracker.pushFullList();
            }

            // 推送低分页面为"修复中"状态
            if (slideStatusCallback != null) {
                for (int idx : weakSlideIndexes) {
                    slideStatusCallback.onStatusChange(idx, "repairing",
                            String.format("第%d轮修复中...", repairRound));
                }
            }

            // 并发修复低分页面（传入 templateUrl 以支持内容校验）
            repairWeakSlides(allSlides, sections, templateInfo, templateUrl, weakSlideIndexes,
                    evalResult, repairRound, progressCallback, repairCallback, tracker, slideStatusCallback);
        }

        // 组装任务
        if (tracker != null) {
            tracker.addTask(AgentTaskTracker.AgentRole.ASSEMBLER, "组装最终 PPT 文件");
            tracker.pushFullList();
        }

        return new GenerationWithEvalResult(allSlides, evalResult, repairRound);
    }

    /**
     * 并发修复低分幻灯片
     */
    private void repairWeakSlides(
            List<Map<String, Object>> allSlides,
            List<String> sections,
            String templateInfo,
            String templateUrl,
            List<Integer> weakIndexes,
            EvaluationResult prevEval,
            int repairRound,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            RepairProgressCallback repairCallback,
            AgentTaskTracker tracker,
            SlideStatusCallback slideStatusCallback) {

        int totalSlides = sections.size();
        Map<Integer, Map<String, Object>> repairedMap = new ConcurrentHashMap<>();
        List<CompletableFuture<Void>> futures = new ArrayList<>();

        String feedbackSummary = buildRepairFeedback(prevEval, weakIndexes);

        // 预构建 Agent 实例，修复任务复用
        ContentAgent repairContentAgent = buildContentAgent();
        DesignAgent repairDesignAgent = buildDesignAgent();

        // 查找已创建的修复任务ID（按 slideIndex 匹配）
        Map<Integer, String> repairTaskIds = new ConcurrentHashMap<>();
        if (tracker != null) {
            List<Map<String, Object>> snapshot = tracker.getTaskListSnapshot();
            for (Map<String, Object> t : snapshot) {
                if ("REPAIRER".equals(t.get("agentRole"))
                        && "PENDING".equals(t.get("status"))
                        && t.containsKey("slideIndex")) {
                    int si = (int) t.get("slideIndex");
                    if (weakIndexes.contains(si)) {
                        repairTaskIds.put(si, (String) t.get("id"));
                    }
                }
            }
        }

        for (int idx : weakIndexes) {
            if (idx >= sections.size()) continue;

            final int slideIndex = idx;
            final String section = sections.get(slideIndex);

            if (repairCallback != null) {
                repairCallback.onProgress(repairRound, slideIndex,
                        String.format("正在修复第 %d 页...", slideIndex + 1));
            }

            CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
                String taskId = repairTaskIds.get(slideIndex);
                try {
                    log.info("修复第 {}/{} 页 (round={})", slideIndex + 1, totalSlides, repairRound);

                    if (tracker != null && taskId != null) {
                        tracker.startTask(taskId, "带评估反馈重新生成内容...");
                    }

                    Map<String, Object> repairedConfig = regenerateSlideWithFeedback(
                            section, templateInfo, slideIndex, totalSlides, feedbackSummary, repairContentAgent);

                    enrichSlideWithDesign(repairedConfig, section, slideIndex, repairDesignAgent);

                    repairedMap.put(slideIndex, repairedConfig);

                    if (progressCallback != null) {
                        progressCallback.accept(slideIndex, repairedConfig);
                    }

                    if (tracker != null && taskId != null) {
                        tracker.completeTask(taskId, "修复完成");
                    }

                    // 推送状态：修复完成
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "done", "修复完成");
                    }

                    log.info("第 {}/{} 页修复完成", slideIndex + 1, totalSlides);
                } catch (Exception e) {
                    log.error("第 {}/{} 页修复失败", slideIndex + 1, totalSlides, e);
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "failed", "修复失败");
                    }
                    if (tracker != null && taskId != null) {
                        tracker.failTask(taskId, "修复失败: " + e.getMessage());
                    }
                }
            }, slideExecutor);

            futures.add(future);
        }

        try {
            CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]))
                    .get(180, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error("修复超时或异常", e);
        }

        // 替换修复后的页面
        for (Map.Entry<Integer, Map<String, Object>> entry : repairedMap.entrySet()) {
            allSlides.set(entry.getKey(), entry.getValue());
        }

        log.info("第 {} 轮修复完成: 成功修复 {}/{} 页",
                repairRound, repairedMap.size(), weakIndexes.size());
    }

    /**
     * 带评估反馈的幻灯片重新生成
     */
    private Map<String, Object> regenerateSlideWithFeedback(
            String section, String templateInfo, int slideIndex, int totalSlides,
            String feedbackSummary, ContentAgent contentAgent) {

        int suggestedIndex = parseTemplateSlideIndex(section, slideIndex, totalSlides);
        // 优先从 section 内嵌的 [TEMPLATE_PAGE] 块提取，其次从全局 templateInfo
        String pageInfo = extractTemplatePageInfo(section, suggestedIndex);
        String slideType = inferSlideType(slideIndex, totalSlides, section);

        String input = String.format("""
                Regenerate the fill content for the following slide. This is a repair round — pay close attention to the previous evaluation feedback.
                
                ## Current Position
                Slide %d/%d, page type: %s
                
                ## Template Page to Use (template_slide_index=%d)
                %s
                
                ## Outline Content for This Slide
                %s
                
                ## Previous Evaluation Feedback (focus on improvements)
                %s
                
                ## Filling Guidelines
                1. template_slide_index MUST be set to %d
                2. fills may only use shape_ids listed above
                3. **You MUST provide a fill for every fillable=YES shape** — omissions cause template placeholder text to remain
                4. For unused fillable=YES shapes, still output {"shape_id": N, "text": ""}
                5. Content should be more professional and specific, backed by data
                6. Bullet points must be concise (no more than 20 characters each)
                7. Use search tools to supplement with the latest information when necessary
                
                Output strictly pure JSON without ```json markers or any other text.
                """,
                slideIndex + 1, totalSlides, slideType,
                suggestedIndex,
                pageInfo,
                cleanSectionText(section),
                feedbackSummary,
                suggestedIndex);

        String result = contentAgent.generateSlideContent(input);
        return parseSlideConfigSafe(result);
    }

    /**
     * 构建修复反馈文本
     */
    private String buildRepairFeedback(EvaluationResult eval, List<Integer> weakIndexes) {
        StringBuilder sb = new StringBuilder();
        sb.append("Overall score: ").append(eval.overallScore()).append("/100\n");
        sb.append("Content score: ").append(eval.contentScore()).append("/100\n");
        sb.append("Design score: ").append(eval.designScore()).append("/100\n");
        sb.append("Coherence score: ").append(eval.coherenceScore()).append("/100\n\n");

        if (!eval.weaknesses().isEmpty()) {
            sb.append("Key weaknesses:\n");
            for (String w : eval.weaknesses()) {
                sb.append("- ").append(w).append("\n");
            }
        }

        if (!eval.suggestions().isEmpty()) {
            sb.append("\nImprovement suggestions:\n");
            for (String s : eval.suggestions()) {
                sb.append("- ").append(s).append("\n");
            }
        }

        // Add per-slide feedback
        if (eval.slideFeedbacks() != null) {
            sb.append("\nLow-scoring slide feedback:\n");
            for (SlideFeedback fb : eval.slideFeedbacks()) {
                if (weakIndexes.contains(fb.slideIndex())) {
                    sb.append(String.format("- Slide %d (score %d): %s\n",
                            fb.slideIndex() + 1, fb.score(), fb.feedback()));
                }
            }
        }

        return sb.toString();
    }

    // ==================== 内部方法 ====================

    private PlannerAgent buildPlannerAgent() {
        ChatModel model = chatModelFactory.createChatModelWithParams(
                plannerModelId, 0.7, 0.9, 4096);
        return AiServices.builder(PlannerAgent.class)
                .chatModel(model)
                .tools(webSearchTool)
                .build();
    }

    private ContentAgent buildContentAgent() {
        ChatModel model = chatModelFactory.createChatModelWithParams(
                contentModelId, 0.5, 0.85, 4096);
        return AiServices.builder(ContentAgent.class)
                .chatModel(model)
                .tools(webSearchTool, contentResearchTool)
                .build();
    }

    private DesignAgent buildDesignAgent() {
        // 使用支持 function calling 的文本模型（非视觉模型），因为需要调用 imageGenerationTool
        ChatModel model = chatModelFactory.createChatModelWithParams(
                designToolModelId, 0.6, 0.85, 2048);
        return AiServices.builder(DesignAgent.class)
                .chatModel(model)
                .tools(imageGenerationTool)
                .build();
    }

    private EvaluatorAgent buildEvaluatorAgent() {
        ChatModel model = chatModelFactory.createChatModelWithParams(
                evaluatorModelId, 0.3, 0.8, 4096);
        return AiServices.builder(EvaluatorAgent.class)
                .chatModel(model)
                .build();
    }

    private LayoutSelectorAgent buildLayoutSelectorAgent() {
        ChatModel model = chatModelFactory.createChatModelWithParams(
                layoutSelectorModelId, 0.3, 0.85, 1024);
        return AiServices.builder(LayoutSelectorAgent.class)
                .chatModel(model)
                .build();
    }

    private HtmlSlideAgent buildHtmlSlideAgent() {
        ChatModel model = chatModelFactory.createChatModelWithParams(
                htmlSlideModelId, 0.7, 0.9, 8192);
        return AiServices.builder(HtmlSlideAgent.class)
                .chatModel(model)
                .tools(webSearchTool, contentResearchTool)
                .build();
    }

    private Map<String, Object> generateSlideWithAgent(
            String section, String templateInfo, int slideIndex, int totalSlides,
            ContentAgent contentAgent) {
        return generateSlideWithAgent(section, templateInfo, slideIndex, totalSlides,
                contentAgent, null, null);
    }

    /**
     * 单页幻灯片生成（含可选的内容校验 + 重试）
     * 借鉴 PPTAgent V1 的 _validate_content() + _rewrite_element() 设计：
     * 生成后校验内容长度是否匹配 shape 尺寸，不通过则带反馈重试。
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> generateSlideWithAgent(
            String section, String templateInfo, int slideIndex, int totalSlides,
            ContentAgent contentAgent, String templateUrl,
            LayoutSelectorAgent sharedLayoutSelector) {

        // 从 enriched section 的 [TEMPLATE_PAGE] 块解析 template_slide_index
        int suggestedIndex = parseTemplateSlideIndex(section, slideIndex, totalSlides);
        String slideType = inferSlideType(slideIndex, totalSlides, section);

        // LayoutSelectorAgent：对 content 类型页面，用 AI 选择最佳版式
        // 借鉴 PPTAgent V1 的 layout_selector 设计
        if (sharedLayoutSelector != null && "content".equals(slideType)) {
            try {
                LayoutSelectorAgent layoutSelector = sharedLayoutSelector;
                String layoutInput = String.format("""
                        ## Slide Content (Slide %d/%d)
                        %s
                        
                        ## Available Template Layouts
                        %s
                        
                        Select the best-matching template layout for the content above.
                        """,
                        slideIndex + 1, totalSlides,
                        cleanSectionText(section),
                        templateInfo);
                String layoutResult = layoutSelector.selectLayout(layoutInput);
                JsonNode layoutJson = parseJsonSafe(layoutResult);
                if (layoutJson != null && layoutJson.has("selected_template_slide_index")) {
                    int selectedIdx = layoutJson.path("selected_template_slide_index").asInt(-1);
                    if (selectedIdx >= 0) {
                        log.info("第{}页 LayoutSelector 选择模板页 {} (原推荐: {}), 理由: {}",
                                slideIndex + 1, selectedIdx, suggestedIndex,
                                layoutJson.path("reasoning").asText(""));
                        suggestedIndex = selectedIdx;
                    }
                }
            } catch (Exception e) {
                log.warn("第{}页版式选择失败，使用默认: {}", slideIndex + 1, e.getMessage());
            }
        }

        // 优先从 section 内嵌的 [TEMPLATE_PAGE] 块提取该页 shape 信息，其次从全局 templateInfo
        String pageInfo = extractTemplatePageInfo(section, suggestedIndex);

        String input = String.format("""
                Generate fill content for the following slide.
                
                ## Current Position
                Slide %d/%d, page type: %s
                
                ## Template Page to Use (template_slide_index=%d)
                %s
                
                ## Outline Content for This Slide
                %s
                
                ## Filling Guidelines
                1. template_slide_index MUST be set to %d
                2. fills may only use shape_ids listed above
                3. **You MUST provide a fill for every fillable=YES shape** — omissions cause template placeholder text to remain
                4. For unused fillable=YES shapes, still output {"shape_id": N, "text": ""}
                5. role=title shapes get the page title; role=body+fillable=YES shapes get bullet points
                6. fillable=NO shapes do NOT need filling
                7. Control text volume based on shape dimensions
                
                Output strictly pure JSON without ```json markers or any other text.
                """,
                slideIndex + 1, totalSlides, slideType,
                suggestedIndex,
                pageInfo,
                cleanSectionText(section),
                suggestedIndex);

        String result = contentAgent.generateSlideContent(input);
        Map<String, Object> slideConfig = parseSlideConfigSafe(result);

        // 内容长度校验 + 带反馈重试（借鉴 PPTAgent V1 _validate_content）
        if (enableContentValidation && templateUrl != null && !templateUrl.isBlank()) {
            try {
                Object fillsObj = slideConfig.get("fills");
                if (fillsObj instanceof List<?> fillsList && !fillsList.isEmpty()) {
                    List<Map<String, Object>> fills = (List<Map<String, Object>>) fillsList;
                    int tsi = slideConfig.containsKey("template_slide_index")
                            ? ((Number) slideConfig.get("template_slide_index")).intValue()
                            : suggestedIndex;

                    var validation = pptServiceClient.validateSlide(
                            templateUrl, slideIndex, tsi, fills);

                    if (!validation.isValid()) {
                        log.info("第{}页内容校验不通过，带反馈重新生成: {}",
                                slideIndex + 1, validation.feedbackText());

                        String retryInput = input + "\n\n## Content Validation Feedback (please fix the following issues)\n"
                                + validation.feedbackText();
                        String retryResult = contentAgent.generateSlideContent(retryInput);
                        slideConfig = parseSlideConfigSafe(retryResult);
                    }
                }
            } catch (Exception e) {
                log.warn("第{}页内容校验异常，使用原始结果: {}", slideIndex + 1, e.getMessage());
            }
        }

        return slideConfig;
    }

    private void enrichSlideWithDesign(Map<String, Object> slideConfig, String section, int slideIndex,
                                       DesignAgent designAgent) {
        try {
            // 检查是否有 image_suggestions
            Object suggestions = slideConfig.get("image_suggestions");
            if (suggestions instanceof List<?> list && !list.isEmpty()) {

                String input = String.format("""
                        Provide a visual optimization plan for the following slide.
                        
                        Slide content: %s
                        Image suggestions: %s
                        
                        Image sourcing strategy:
                        - If the topic is a REAL-WORLD entity (product, company, person, place, device),
                          use searchWebImage first. Fall back to generateSlideImage only if search fails.
                        - If the topic is ABSTRACT or CONCEPTUAL, use generateSlideImage directly.
                        - Not every slide needs an image — skip if the slide is text-heavy.
                        
                        Output pure JSON.
                        """, section, list);

                String designResult = designAgent.designSlide(input);
                JsonNode designJson = parseJsonSafe(designResult);

                if (designJson != null && designJson.has("image_url")) {
                    String imageUrl = designJson.path("image_url").asText(null);
                    if (imageUrl != null && !imageUrl.isBlank() && !imageUrl.equals("null")) {
                        slideConfig.put("generated_image_url", imageUrl);
                        log.info("第{}页配图生成成功: {}", slideIndex + 1, imageUrl);

                        // 将生成的图片 URL 写入 fills 数组的图片槽位，确保 ppt-service 能插入到 PPTX
                        injectImageIntoFills(slideConfig, section, imageUrl);
                    }
                }
            }
        } catch (Exception e) {
            log.warn("第{}页视觉优化跳过: {}", slideIndex + 1, e.getMessage());
        }
    }

    /**
     * 将生成的图片 URL 注入到 fills 数组中对应的图片槽位。
     * 从 [TEMPLATE_PAGE] 块中解析图片槽位 shape_id，然后添加到 fills。
     */
    @SuppressWarnings("unchecked")
    private void injectImageIntoFills(Map<String, Object> slideConfig, String section, String imageUrl) {
        try {
            // Parse image slot shape_id from [TEMPLATE_PAGE] block
            // Format: "Image slots:\n  shape_id=18, name=...\n"
            java.util.regex.Matcher imgMatcher = java.util.regex.Pattern
                    .compile("Image slots:\\s*\\n\\s*shape_id=(\\d+)")
                    .matcher(section != null ? section : "");

            if (!imgMatcher.find()) {
                log.debug("No image slot shape_id found, skipping image injection");
                return;
            }
            final int imageShapeId = Integer.parseInt(imgMatcher.group(1));

            // 获取或创建 fills 列表
            Object fillsObj = slideConfig.get("fills");
            List<Map<String, Object>> fills;
            if (fillsObj instanceof List<?>) {
                fills = (List<Map<String, Object>>) fillsObj;
            } else {
                fills = new ArrayList<>();
                slideConfig.put("fills", fills);
            }

            // 检查是否已有该 shape_id 的 fill（避免重复）
            boolean exists = fills.stream().anyMatch(f ->
                    f.containsKey("shape_id") && Objects.equals(f.get("shape_id"), imageShapeId));

            if (!exists) {
                Map<String, Object> imageFill = new HashMap<>();
                imageFill.put("shape_id", imageShapeId);
                imageFill.put("image_url", imageUrl);
                fills.add(imageFill);
                log.info("图片已注入 fills: shape_id={}, url={}", imageShapeId, imageUrl);
            }
        } catch (Exception e) {
            log.warn("图片注入 fills 失败: {}", e.getMessage());
        }
    }

    // ==================== Per-Slide Visual Inspection (P1) ====================

    /**
     * 逐页即时视觉审查 — 借鉴 PPTAgent V2 (DeepPresenter) 的 inspect_slide 设计。
     * 在每页生成后立即渲染预览图，用视觉模型快速审查，发现问题立即修复。
     * 相比现有的"全部生成后批量评估"，这种方式能更早地捕获和修复问题。
     *
     * @param slideConfig     当前页的配置 JSON
     * @param section         该页大纲内容
     * @param slideIndex      页码索引
     * @param totalSlides     总页数
     * @param templateUrl     模板 URL（用于渲染预览）
     * @param contentAgent    ContentAgent（用于修复重生）
     * @param designAgent     DesignAgent（用于修复后重新配图）
     * @return 修复后的 slideConfig（如果需要修复），或原始 slideConfig
     */
    private Map<String, Object> inspectAndRepairSlide(
            Map<String, Object> slideConfig, String section,
            int slideIndex, int totalSlides, String templateUrl,
            ContentAgent contentAgent, DesignAgent designAgent) {

        if (!enablePerSlideInspection || templateUrl == null || templateUrl.isBlank()) {
            return slideConfig;
        }

        try {
            // Step 1: 渲染当前页为预览图
            var previewResult = pptServiceClient.generateSlidePreview(templateUrl, slideConfig);
            String previewUrl = previewResult.imageUrl();
            if (previewUrl == null || previewUrl.isBlank()) {
                log.debug("第{}页预览渲染无结果，跳过视觉审查", slideIndex + 1);
                return slideConfig;
            }

            // Step 2: 视觉模型快速审查（轻量 prompt，控制延迟）
            String inspectionPrompt = String.format("""
                    Quickly review the visual quality of this presentation slide (slide %d/%d).
                    
                    Check ONLY for the following critical issues:
                    1. Text overflowing or being clipped outside text boxes
                    2. Obvious layout corruption (overlapping elements, misalignment)
                    3. Too little text causing empty/hollow appearance
                    4. Missing or broken images
                    
                    Output pure JSON:
                    {
                      "pass": true/false,
                      "issues": ["issue description 1", "issue description 2"],
                      "severity": "none|minor|major"
                    }
                    
                    If no critical issues are found, output {"pass": true, "issues": [], "severity": "none"}
                    """, slideIndex + 1, totalSlides);

            String inspectResult = langchainChatService.chatWithImages(
                    designVisionModelId,
                    "You are a presentation visual quality inspector. Focus only on critical visual defects and ignore minor stylistic differences. Output pure JSON.",
                    inspectionPrompt,
                    List.of(previewUrl));

            JsonNode inspectJson = parseJsonSafe(inspectResult);
            if (inspectJson == null || inspectJson.path("pass").asBoolean(true)) {
                log.info("第{}页视觉审查通过", slideIndex + 1);
                // 将预览图 URL 存入 slideConfig 供后续使用
                slideConfig.put("previewImageUrl", previewUrl);
                return slideConfig;
            }

            // Step 3: 发现问题 → 带视觉反馈修复
            String severity = inspectJson.path("severity").asText("minor");
            StringBuilder issueText = new StringBuilder();
            JsonNode issuesArray = inspectJson.path("issues");
            if (issuesArray.isArray()) {
                for (JsonNode issue : issuesArray) {
                    issueText.append("- ").append(issue.asText()).append("\n");
                }
            }

            log.info("第{}页视觉审查发现{}问题: {}", slideIndex + 1, severity, issueText);

            if ("minor".equals(severity)) {
                // 轻微问题：记录但不修复，避免额外延迟
                slideConfig.put("previewImageUrl", previewUrl);
                slideConfig.put("inspection_notes", issueText.toString());
                return slideConfig;
            }

            // major 问题：立即修复
            log.info("第{}页发现严重视觉问题，立即修复重生", slideIndex + 1);

            int suggestedIndex = parseTemplateSlideIndex(section, slideIndex, totalSlides);
            String pageInfo = extractTemplatePageInfo(section, suggestedIndex);
            String slideType = inferSlideType(slideIndex, totalSlides, section);

            String repairInput = String.format("""
                    Regenerate the fill content for slide %d/%d. The previous content has visual issues that need repair.
                    
                    ## Page Type: %s
                    ## Template Page (template_slide_index=%d)
                    %s
                    
                    ## Outline Content
                    %s
                    
                    ## Visual Inspection Issues (MUST be fixed)
                    %s
                    
                    ## Repair Requirements
                    - template_slide_index MUST be set to %d
                    - Strictly control text volume based on shape dimensions to avoid overflow
                    - Ensure ALL fillable=YES shapes have fills
                    
                    Output pure JSON.
                    """,
                    slideIndex + 1, totalSlides, slideType,
                    suggestedIndex, pageInfo,
                    cleanSectionText(section),
                    issueText,
                    suggestedIndex);

            String repairedResult = contentAgent.generateSlideContent(repairInput);
            Map<String, Object> repairedConfig = parseSlideConfigSafe(repairedResult);

            // 修复后重新执行 DesignAgent 视觉优化（确保配图不丢失）
            if (designAgent != null) {
                enrichSlideWithDesign(repairedConfig, section, slideIndex, designAgent);
            }

            // 重新渲染预览
            try {
                var repairedPreview = pptServiceClient.generateSlidePreview(templateUrl, repairedConfig);
                if (repairedPreview.imageUrl() != null && !repairedPreview.imageUrl().isBlank()) {
                    repairedConfig.put("previewImageUrl", repairedPreview.imageUrl());
                }
            } catch (Exception e) {
                log.warn("第{}页修复后预览渲染失败: {}", slideIndex + 1, e.getMessage());
            }

            repairedConfig.put("inspection_repaired", true);
            log.info("第{}页视觉修复完成", slideIndex + 1);
            return repairedConfig;

        } catch (Exception e) {
            log.warn("第{}页视觉审查异常，使用原始结果: {}", slideIndex + 1, e.getMessage());
            return slideConfig;
        }
    }

    private Map<String, Object> createFallbackSlideConfig(String section, int slideIndex, String templateInfo) {
        Map<String, Object> config = new HashMap<>();
        int suggestedIndex = parseTemplateSlideIndex(section, slideIndex, Integer.MAX_VALUE);
        config.put("template_slide_index", suggestedIndex);

        String cleaned = cleanSectionText(section);
        String[] lines = cleaned.split("\n");
        List<Map<String, Object>> fills = new ArrayList<>();

        String title = lines.length > 0 ? lines[0].replaceAll("^#+\\s*", "") : "Slide " + (slideIndex + 1);
        fills.add(Map.of("shape_id", 0, "text", title));

        if (lines.length > 1) {
            List<String> items = new ArrayList<>();
            for (int i = 1; i < lines.length; i++) {
                String line = lines[i].replaceAll("^[-*#\\s]+", "").trim();
                if (!line.isEmpty()) {
                    items.add(line);
                }
            }
            if (!items.isEmpty()) {
                fills.add(Map.of("shape_id", 1, "items", items));
            }
        }

        config.put("fills", fills);
        return config;
    }

    // ==================== 输入构建 ====================

    private String buildPlannerInput(String topic, String requirements, String templateInfo) {
        StringBuilder sb = new StringBuilder();
        sb.append("Presentation topic: ").append(topic).append("\n\n");

        if (requirements != null && !requirements.isBlank()) {
            sb.append("Additional requirements: ").append(requirements).append("\n\n");
        }
        if (templateInfo != null && !templateInfo.isBlank()) {
            sb.append("## Template Structure (you MUST strictly follow the \"Outline Structure Requirements\" within)\n\n");
            sb.append(templateInfo).append("\n\n");
            sb.append("IMPORTANT:\n");
            sb.append("- Strictly follow the Outline Structure Requirements to control ## (chapter) and ### (content page) counts\n");
            sb.append("- Each ### corresponds to one PPT slide; total must match the template's content page count\n");
            sb.append("- Do NOT annotate template_slide_index; the system assigns it automatically\n");
            sb.append("- If Audience and Tone are specified above, match the language register and formality accordingly\n\n");
        }

        sb.append("First use web search tools to gather the latest information on this topic, then create the outline.");
        return sb.toString();
    }

    private String buildEvaluationInput(List<Map<String, Object>> slides, String outline) {
        StringBuilder sb = new StringBuilder();
        sb.append("## Original Outline\n").append(outline).append("\n\n");
        sb.append("## Generated Slide Content (").append(slides.size()).append(" slides)\n\n");

        for (int i = 0; i < slides.size(); i++) {
            try {
                sb.append("### Slide ").append(i + 1).append("\n");
                sb.append(objectMapper.writeValueAsString(slides.get(i)));
                sb.append("\n\n");
            } catch (Exception e) {
                sb.append("(parse failed)\n\n");
            }
        }

        sb.append("Please perform a comprehensive quality evaluation of this presentation. Output pure JSON.");
        return sb.toString();
    }

    // ==================== 解析方法 ====================

    private OutlineResult parseOutlineResult(String rawResult) {
        // 分离研究摘要和大纲
        String researchSummary = "";
        String outlineMarkdown = rawResult;

        // Try English markers first (matching PlannerAgent output format)
        int outlineIdx = rawResult.indexOf("## Presentation Outline");
        if (outlineIdx == -1) {
            outlineIdx = rawResult.indexOf("## PPT大纲");
        }
        if (outlineIdx == -1) {
            outlineIdx = rawResult.indexOf("## PPT 大纲");
        }

        if (outlineIdx > 0) {
            researchSummary = rawResult.substring(0, outlineIdx).trim();
            // Remove the heading line itself
            String headingLine = rawResult.substring(outlineIdx).split("\n", 2)[0];
            outlineMarkdown = rawResult.substring(outlineIdx + headingLine.length()).trim();
            // Remove research summary heading prefix
            if (researchSummary.startsWith("## Research Summary")) {
                researchSummary = researchSummary.substring("## Research Summary".length()).trim();
            } else if (researchSummary.startsWith("## 研究摘要")) {
                researchSummary = researchSummary.substring("## 研究摘要".length()).trim();
            }
        }

        return new OutlineResult(outlineMarkdown, researchSummary);
    }

    private Map<String, Object> parseSlideConfigSafe(String jsonStr) {
        if (jsonStr == null || jsonStr.isBlank()) {
            log.warn("parseSlideConfigSafe: jsonStr is null or blank");
            return new HashMap<>();
        }
        try {
            // 清理可能的 markdown code fence
            String cleaned = jsonStr.trim();
            if (cleaned.startsWith("```")) {
                int firstNewLine = cleaned.indexOf('\n');
                if (firstNewLine > 0) {
                    cleaned = cleaned.substring(firstNewLine + 1);
                }
                if (cleaned.endsWith("```")) {
                    cleaned = cleaned.substring(0, cleaned.length() - 3);
                }
                cleaned = cleaned.trim();
            }
            return objectMapper.readValue(cleaned, new TypeReference<>() {});
        } catch (Exception e) {
            log.warn("Agent输出JSON解析失败，尝试提取: {}", e.getMessage());
            // 尝试找到 JSON 对象
            int start = jsonStr.indexOf('{');
            int end = jsonStr.lastIndexOf('}');
            if (start >= 0 && end > start) {
                try {
                    return objectMapper.readValue(
                            jsonStr.substring(start, end + 1), new TypeReference<>() {});
                } catch (Exception ex) {
                    log.error("JSON提取也失败", ex);
                }
            }
            return new HashMap<>();
        }
    }

    private JsonNode parseJsonSafe(String jsonStr) {
        if (jsonStr == null || jsonStr.isBlank()) {
            log.warn("parseJsonSafe: jsonStr is null or blank");
            return null;
        }
        try {
            String cleaned = jsonStr.trim();
            if (cleaned.startsWith("```")) {
                int firstNewLine = cleaned.indexOf('\n');
                if (firstNewLine > 0) cleaned = cleaned.substring(firstNewLine + 1);
                if (cleaned.endsWith("```")) cleaned = cleaned.substring(0, cleaned.length() - 3);
                cleaned = cleaned.trim();
            }
            int start = cleaned.indexOf('{');
            int end = cleaned.lastIndexOf('}');
            if (start >= 0 && end > start) {
                return objectMapper.readTree(cleaned.substring(start, end + 1));
            }
            return objectMapper.readTree(cleaned);
        } catch (Exception e) {
            log.warn("JSON解析失败: {}", e.getMessage());
            return null;
        }
    }

    private EvaluationResult parseEvaluationResult(String rawResult) {
        JsonNode json = parseJsonSafe(rawResult);
        if (json == null) {
            return EvaluationResult.defaultResult();
        }

        try {
            int overall = json.path("overall_score").asInt(70);
            int content = json.path("content_score").asInt(70);
            int design = json.path("design_score").asInt(70);
            int coherence = json.path("coherence_score").asInt(70);

            List<String> strengths = new ArrayList<>();
            json.path("strengths").forEach(n -> strengths.add(n.asText()));

            List<String> weaknesses = new ArrayList<>();
            json.path("weaknesses").forEach(n -> weaknesses.add(n.asText()));

            List<String> suggestions = new ArrayList<>();
            json.path("improvement_suggestions").forEach(n -> suggestions.add(n.asText()));

            // 解析每页评分
            List<SlideFeedback> slideFeedbacks = new ArrayList<>();
            JsonNode slideLevelNode = json.path("slide_level_feedback");
            if (slideLevelNode.isArray()) {
                for (JsonNode sfNode : slideLevelNode) {
                    slideFeedbacks.add(new SlideFeedback(
                            sfNode.path("slide_index").asInt(0),
                            sfNode.path("score").asInt(70),
                            sfNode.path("feedback").asText("")));
                }
            }

            return new EvaluationResult(overall, content, design, coherence,
                    strengths, weaknesses, suggestions, slideFeedbacks);
        } catch (Exception e) {
            log.warn("评估结果解析失败", e);
            return EvaluationResult.defaultResult();
        }
    }

    /**
     * 从幻灯片配置列表中提取预览图 URL
     * （由 PptGenerationService 的 progressCallback 写入 "previewImageUrl" 字段）
     */
    private List<String> extractPreviewImageUrls(List<Map<String, Object>> slides) {
        List<String> urls = new ArrayList<>();
        for (Map<String, Object> slide : slides) {
            Object url = slide.get("previewImageUrl");
            urls.add(url instanceof String s && !s.isBlank() ? s : null);
        }
        return urls;
    }

    private String inferSlideType(int slideIndex, int totalSlides, String section) {
        // 优先从 [TEMPLATE_PAGE] 块中提取 role
        if (section != null) {
            java.util.regex.Matcher roleMatcher = java.util.regex.Pattern
                    .compile("\\[role=(\\w+)")
                    .matcher(section);
            if (roleMatcher.find()) {
                String role = roleMatcher.group(1);
                return switch (role) {
                    case "cover" -> "cover（封面页：显示PPT标题和副标题）";
                    case "toc" -> "toc（目录页：展示PPT结构）";
                    case "section" -> "section（章节过渡页：仅显示章节标题）";
                    case "ending" -> "ending（结束页：感谢/总结/联系方式）";
                    case "credits" -> "credits（版权页：致谢/版权信息）";
                    default -> "content（正文页：标题 + 要点列表或详细内容）";
                };
            }
        }
        // 兜底：基于位置推断
        if (slideIndex == 0) return "cover（封面页：显示PPT标题和副标题）";
        if (slideIndex == totalSlides - 1) return "ending（结束页：感谢/总结/联系方式）";
        String cleaned = section != null ? cleanSectionText(section).trim() : "";
        if (cleaned.startsWith("## ") && !cleaned.contains("### "))
            return "section（章节过渡页：仅显示章节标题）";
        return "content（正文页：标题 + 要点列表或详细内容）";
    }

    /**
     * 从大纲章节文本中解析 PlannerAgent 标注的 template_slide_index
     * 格式: <!-- template_slide_index=N -->
     */
    private int parseTemplateSlideIndex(String section, int slideIndex, int totalSlides) {
        if (section == null) return inferDefaultTemplateIndex(slideIndex, totalSlides);

        // 优先从 [TEMPLATE_PAGE] 块解析（enriched sections 格式）
        java.util.regex.Matcher tpMatcher = java.util.regex.Pattern
                .compile("\\[TEMPLATE_PAGE]\\s*\\ntemplate_slide_index\\s*=\\s*(\\d+)")
                .matcher(section);
        if (tpMatcher.find()) {
            try {
                return Integer.parseInt(tpMatcher.group(1));
            } catch (NumberFormatException e) { /* ignore */ }
        }

        // 兼容旧格式 <!-- template_slide_index=N -->
        java.util.regex.Matcher matcher = java.util.regex.Pattern
                .compile("<!--\\s*template_slide_index\\s*=\\s*(\\d+)\\s*-->")
                .matcher(section);
        if (matcher.find()) {
            try {
                return Integer.parseInt(matcher.group(1));
            } catch (NumberFormatException e) { /* ignore */ }
        }

        return inferDefaultTemplateIndex(slideIndex, totalSlides);
    }

    /**
     * 默认模板页索引推断：封面→0, 结尾→最后一页（假设存在ending页）, 其他→轮转content页
     */
    private int inferDefaultTemplateIndex(int slideIndex, int totalSlides) {
        if (slideIndex == 0) return 0;
        if (slideIndex == totalSlides - 1) return Math.max(1, slideIndex);
        // 默认使用索引1（通常是第一个content页），如果模板有多个content页可以轮转
        return Math.min(slideIndex, 1);
    }

    /**
     * 从 section 文本或全局模板描述中提取该页的模板 shape 信息。
     * 优先从 enriched section 的 [TEMPLATE_PAGE]...[/TEMPLATE_PAGE] 块提取，
     * 其次从全局 templateInfo 中按 "┌── 模板第N页" 标记搜索。
     */
    private String extractTemplatePageInfo(String templateInfo, int pageIndex) {
        if (templateInfo == null || templateInfo.isBlank()) {
            return "无模板页信息（使用默认布局）";
        }

        // 优先：从 [TEMPLATE_PAGE]...[/TEMPLATE_PAGE] 块提取（enriched section 内嵌）
        int tpStart = templateInfo.indexOf("[TEMPLATE_PAGE]");
        int tpEnd = templateInfo.indexOf("[/TEMPLATE_PAGE]");
        if (tpStart >= 0 && tpEnd > tpStart) {
            return templateInfo.substring(tpStart + "[TEMPLATE_PAGE]".length(), tpEnd).trim();
        }

        // 兼容旧格式：从全局模板描述中按 "┌── 模板第N页" 标记搜索
        String startMarker = String.format("┌── 模板第%d页", pageIndex);
        String endMarker = String.format("└── 模板第%d页结束", pageIndex);

        int startIdx = templateInfo.indexOf(startMarker);
        int endIdx = templateInfo.indexOf(endMarker);

        if (startIdx >= 0 && endIdx > startIdx) {
            String pageSection = templateInfo.substring(startIdx, endIdx + endMarker.length());
            return pageSection + "\n\n" + extractTemplateRules(templateInfo);
        }

        log.debug("未找到模板第{}页的详细信息，返回完整模板", pageIndex);
        return templateInfo;
    }

    /**
     * 提取模板使用规则部分
     */
    private String extractTemplateRules(String templateInfo) {
        int rulesIdx = templateInfo.indexOf("=== 使用规则 ===");
        if (rulesIdx >= 0) {
            return templateInfo.substring(rulesIdx);
        }
        return "";
    }

    /**
     * 清理章节文本：移除 template_slide_index 标注等元信息
     */
    private String cleanSectionText(String section) {
        if (section == null) return "";
        // 移除 [TEMPLATE_PAGE]...[/TEMPLATE_PAGE] 块
        String cleaned = section.replaceAll("(?s)\\[TEMPLATE_PAGE].*?\\[/TEMPLATE_PAGE]", "");
        // 兼容旧格式
        cleaned = cleaned.replaceAll("<!--\\s*template_slide_index\\s*=\\s*\\d+\\s*-->", "");
        return cleaned.trim();
    }

    // ==================== HTML 模式：无模板幻灯片生成 ====================

    /**
     * HTML 模式：内容扩写 — 将简短大纲扩展为详细内容
     * cover/ending 页不扩写（保持简洁），内容页扩展要点为 4-6 条详细描述
     */
    private String expandSectionForHtml(String section, int slideIndex, int totalSlides) {
        String slideType = inferHtmlSlideType(slideIndex, totalSlides, section);

        // cover / ending 保持简洁，不需要扩写
        if ("cover".equals(slideType) || "ending".equals(slideType) || "section".equals(slideType)) {
            return section;
        }

        try {
            String prompt = String.format("""
                    你是一位专业的演示文稿内容编辑。请将以下简短大纲扩写为适合演示文稿展示的详细内容。
                    
                    ## 原始大纲
                    %s
                    
                    ## 扩写要求
                    1. 保留原标题不变
                    2. 将每个要点扩展为 1-2 句话的详细描述（包含具体数据、案例或解释）
                    3. 如果要点少于 4 个，补充相关要点到 4-6 个
                    4. 每个要点应独立成段，适合放在单独的卡片中展示
                    5. 如果涉及数据或统计，添加具体数字（可以合理估算）
                    6. 保持专业但易懂的语言风格
                    7. 使用与原文相同的语言（中文大纲 → 中文扩写）
                    
                    ## 输出格式
                    直接输出扩写后的 Markdown 内容（保留标题层级），不要输出其他解释文字。
                    """, section);

            String expanded = langchainChatService.chat(contentModelId,
                    "你是专业的演示文稿内容编辑，擅长将简短大纲扩写为详细、有深度的演示内容。",
                    prompt);

            if (expanded != null && !expanded.isBlank() && expanded.length() > section.length()) {
                log.info("第{}页内容扩写完成: {}字 → {}字", slideIndex + 1, section.length(), expanded.length());
                return expanded.trim();
            }
        } catch (Exception e) {
            log.warn("第{}页内容扩写失败，使用原始大纲: {}", slideIndex + 1, e.getMessage());
        }

        return section;
    }

    /**
     * HTML 模式：单页 HTML 幻灯片生成
     */
    private Map<String, Object> generateHtmlSlideWithAgent(
            String section, int slideIndex, int totalSlides,
            String globalColorScheme, HtmlSlideAgent htmlAgent) {

        String slideType = inferHtmlSlideType(slideIndex, totalSlides, section);

        String designDirective = globalColorScheme != null ? globalColorScheme :
                "Use a harmonious modern color palette with gradients. " +
                "Keep the same visual language across all slides.";

        // 根据幻灯片类型给出具体的布局指令
        String layoutHint = switch (slideType) {
            case "cover" -> "LAYOUT: Full-bleed gradient background. Large title (72-80px) centered. " +
                    "Add 2-3 decorative geometric shapes (large semi-transparent circles, diagonal bars). " +
                    "Subtitle below title. Author/date at bottom.";
            case "section" -> "LAYOUT: Bold gradient or dark background. Large chapter number (120px+, semi-transparent). " +
                    "Chapter title (56-64px, light text). Accent line. Corner decorative elements.";
            case "ending" -> "LAYOUT: Gradient background matching cover style. Large centered closing text. " +
                    "Decorative shapes echoing cover design. Key takeaway or contact info below.";
            default -> "LAYOUT: Colored title bar at top (full-width, 80px height). " +
                    "Content area: arrange points as CARD GRID (2×2 or 3×1), each card with: " +
                    "rounded corners (16px), box-shadow, left color accent border (4-6px), " +
                    "emoji icon circle on left, text on right. " +
                    "Add decorative footer bar or page indicator at bottom. " +
                    "NEVER use plain bullet text lists — always use card-based layouts!";
        };

        String input = String.format("""
                Create a visually STUNNING HTML slide. It must look like a premium keynote design, NOT a plain document.

                ## Slide Position
                Slide %d of %d — Type: **%s**

                ## %s

                ## Global Design Directive
                %s

                ## Content for This Slide
                %s

                ## CRITICAL VISUAL REQUIREMENTS
                ⚠ Plain white backgrounds with simple text are UNACCEPTABLE. You MUST include:
                - Gradient background (linear-gradient or radial-gradient)
                - At least 2-3 decorative div elements (colored circles, bars, accent shapes)
                - Card-based layouts with box-shadow (0 8px 32px rgba(0,0,0,0.12)) and border-radius (16px)
                - Unicode emoji symbols (📊💡🎯⚡🔬📈🏆✅🌐🚀) as visual icon anchors in colored circles
                - Multi-column flexbox or grid layout (NOT single-column plain text)
                - Colored accent bars, header strips, or sidebar panels
                - Strong visual hierarchy: title (≥48px bold), subtitle, card content (≥24px)

                ## Technical Rules
                - Single root `<div>`: width:1920px; height:1080px; overflow:hidden
                - ALL styles inline (style="..."). NO <style> tags, NO external CSS/JS
                - Font: Arial, 'Helvetica Neue', sans-serif. NO external fonts
                - Text language MUST match the content above (Chinese → Chinese)

                ## Output — ONLY pure JSON:
                {"slide_html": "...", "slide_type": "...", "speaker_notes": "...", "image_suggestions": [...]}
                """,
                slideIndex + 1, totalSlides, slideType,
                layoutHint,
                designDirective,
                cleanSectionText(section));

        String result = htmlAgent.generateHtmlSlide(input);
        Map<String, Object> slideConfig = parseSlideConfigSafe(result);

        // 确保必要字段存在
        if (!slideConfig.containsKey("slide_html")) {
            log.warn("第{}页 HTML 生成缺少 slide_html 字段，使用 fallback", slideIndex + 1);
            return createFallbackHtmlSlideConfig(section, slideIndex, totalSlides);
        }

        slideConfig.put("mode", "html");
        return slideConfig;
    }

    /**
     * HTML 模式：并发生成所有 HTML 幻灯片
     */
    public List<Map<String, Object>> generateHtmlSlidesParallel(
            List<String> sections,
            String userStyleHint,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            AgentTaskTracker tracker,
            SlideStatusCallback slideStatusCallback) {

        log.info("HTML 模式 Stage 2 - 并发生成 {} 页 HTML 幻灯片, concurrency={}",
                sections.size(), concurrency);

        HtmlSlideAgent sharedHtmlAgent = buildHtmlSlideAgent();
        DesignAgent sharedDesignAgent = buildDesignAgent();

        int totalSlides = sections.size();
        Map<Integer, Map<String, Object>> resultsMap = new ConcurrentHashMap<>();
        List<CompletableFuture<Void>> futures = new ArrayList<>();

        // 全局设计指令：用户提示 > 默认配色方案
        String globalColorScheme;
        if (userStyleHint != null && !userStyleHint.isBlank()) {
            globalColorScheme = "USER STYLE DIRECTIVE (highest priority):\n" +
                    userStyleHint + "\n\n" +
                    "ADDITIONAL RULES:\n" +
                    "- Maintain visual consistency across ALL slides.\n" +
                    "- EVERY slide must use gradient backgrounds, card layouts with shadows, decorative shapes.\n" +
                    "- Use the user's described style as the primary design language.\n" +
                    "- Include emoji icon circles, colored accent bars, multi-column grids.\n" +
                    "- NEVER produce a plain white slide with simple text — that is a FAILURE.";
        } else {
            globalColorScheme = "DEFAULT DESIGN RULES — apply to EVERY slide:\n" +
                    "- Use a deep blue-to-purple gradient palette (cover/ending: dark gradient, content: light gradient).\n" +
                    "- Primary accent: vibrant blue (#2563EB). Secondary: purple (#7C3AED).\n" +
                    "- ALL slides must have gradient backgrounds (linear-gradient), NOT plain solid white.\n" +
                    "- Content slides: light gradient (e.g. linear-gradient(135deg, #F8FAFC, #EEF2FF)).\n" +
                    "- Cover/ending: dark gradient (e.g. linear-gradient(135deg, #1E293B, #312E81)).\n" +
                    "- Use card-based layouts with box-shadow and border-radius for all content.\n" +
                    "- Include decorative elements: colored circles, accent bars, geometric shapes.\n" +
                    "- Emoji icons in colored circles as visual anchors on each card.\n" +
                    "- NEVER produce a plain white slide with simple text — that is a FAILURE.";
        }

        Map<Integer, String> contentTaskIds = new ConcurrentHashMap<>();
        Map<Integer, String> designTaskIds = new ConcurrentHashMap<>();

        if (tracker != null) {
            for (int i = 0; i < totalSlides; i++) {
                contentTaskIds.put(i, tracker.addTask(AgentTaskTracker.AgentRole.CONTENT,
                        String.format("生成第 %d/%d 页 HTML 内容", i + 1, totalSlides), i));
                designTaskIds.put(i, tracker.addTask(AgentTaskTracker.AgentRole.DESIGN,
                        String.format("第 %d/%d 页视觉优化", i + 1, totalSlides), i));
            }
            tracker.pushFullList();
        }

        for (int i = 0; i < totalSlides; i++) {
            final int slideIndex = i;
            final String section = sections.get(i);

            CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
                try {
                    log.info("HTML 模式：开始生成第 {}/{} 页", slideIndex + 1, totalSlides);

                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "expanding", "扩写内容...");
                    }
                    if (tracker != null) {
                        tracker.startTask(contentTaskIds.get(slideIndex), "内容扩写中...");
                    }

                    // 内容扩写：将简短大纲扩展为详细内容
                    String expandedSection = expandSectionForHtml(section, slideIndex, totalSlides);

                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "generating", "AI 生成 HTML 内容...");
                    }
                    if (tracker != null) {
                        tracker.updateDetail(contentTaskIds.get(slideIndex), "HtmlSlideAgent 正在生成...");
                    }

                    Map<String, Object> slideConfig = generateHtmlSlideWithAgent(
                            expandedSection, slideIndex, totalSlides, globalColorScheme, sharedHtmlAgent);

                    if (tracker != null) {
                        tracker.completeTask(contentTaskIds.get(slideIndex), "HTML 内容生成完成");
                    }

                    // DesignAgent 为 HTML 幻灯片生成配图
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "designing", "视觉优化...");
                    }
                    if (tracker != null) {
                        tracker.startTask(designTaskIds.get(slideIndex), "DesignAgent 检查配图需求...");
                    }

                    enrichHtmlSlideWithDesign(slideConfig, section, slideIndex, sharedDesignAgent);

                    if (tracker != null) {
                        boolean hasImage = slideConfig.containsKey("generated_image_url");
                        tracker.completeTask(designTaskIds.get(slideIndex),
                                hasImage ? "已生成配图" : "无需配图，跳过");
                    }

                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "rendering", "渲染预览...");
                    }

                    resultsMap.put(slideIndex, slideConfig);

                    if (progressCallback != null) {
                        progressCallback.accept(slideIndex, slideConfig);
                    }

                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "done", "完成");
                    }

                    log.info("HTML 模式：第 {}/{} 页生成完成", slideIndex + 1, totalSlides);

                } catch (Exception e) {
                    log.error("HTML 模式：第 {}/{} 页生成失败", slideIndex + 1, totalSlides, e);
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "failed", "生成失败");
                    }
                    if (tracker != null) {
                        tracker.failTask(contentTaskIds.get(slideIndex), "生成失败: " + e.getMessage());
                        tracker.skipTask(designTaskIds.get(slideIndex), "内容生成失败，跳过视觉优化");
                    }
                    Map<String, Object> fallback = createFallbackHtmlSlideConfig(section, slideIndex, totalSlides);
                    resultsMap.put(slideIndex, fallback);
                    if (progressCallback != null) {
                        progressCallback.accept(slideIndex, fallback);
                    }
                }
            }, slideExecutor)
            .orTimeout(120, TimeUnit.SECONDS)
            .exceptionally(ex -> {
                if (ex instanceof java.util.concurrent.TimeoutException
                        || (ex.getCause() instanceof java.util.concurrent.TimeoutException)) {
                    log.error("HTML 模式：第 {}/{} 页生成超时（120s）", slideIndex + 1, totalSlides);
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "failed", "生成超时");
                    }
                    Map<String, Object> fallback = createFallbackHtmlSlideConfig(section, slideIndex, totalSlides);
                    resultsMap.put(slideIndex, fallback);
                    if (progressCallback != null) {
                        progressCallback.accept(slideIndex, fallback);
                    }
                }
                return null;
            });

            futures.add(future);
        }

        try {
            CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]))
                    .get(300, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error("HTML 模式：并发生成超时或异常", e);
        }

        List<Map<String, Object>> orderedResults = new ArrayList<>();
        for (int i = 0; i < totalSlides; i++) {
            Map<String, Object> config = resultsMap.get(i);
            if (config != null) {
                orderedResults.add(config);
            }
        }

        log.info("HTML 模式 Stage 2 完成: 成功生成 {}/{} 页", orderedResults.size(), totalSlides);
        return orderedResults;
    }

    /**
     * HTML 模式：带反思修复循环的完整生成
     */
    public GenerationWithEvalResult generateWithReflectionHtml(
            List<String> sections,
            String outline,
            String userStyleHint,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            RepairProgressCallback repairCallback,
            AgentTaskTracker tracker,
            SlideStatusCallback slideStatusCallback) {

        log.info("HTML 模式：开始带反思修复的幻灯片生成: {} 页, threshold={}, maxRounds={}, styleHint='{}'",
                sections.size(), qualityThreshold, maxRepairRounds,
                (userStyleHint == null || userStyleHint.isEmpty()) ? "(default)" : userStyleHint);

        // Stage 2: 初次并发生成 HTML 幻灯片
        List<Map<String, Object>> allSlides = generateHtmlSlidesParallel(
                sections, userStyleHint, progressCallback, tracker, slideStatusCallback);

        if (allSlides.isEmpty()) {
            return new GenerationWithEvalResult(allSlides, EvaluationResult.defaultResult(), 0);
        }

        // Stage 3: 评估 → 修复循环
        int repairRound = 0;
        EvaluationResult evalResult = null;

        for (int round = 0; round <= maxRepairRounds; round++) {
            String evalTaskId = null;
            if (tracker != null) {
                evalTaskId = tracker.startNewTask(AgentTaskTracker.AgentRole.EVALUATOR,
                        round == 0 ? "HTML 幻灯片质量评估" : String.format("第 %d 轮修复后重新评估", round),
                        round == 0 ? "正在审查 HTML 幻灯片质量..." : "重新审查修复后的页面...");
            }

            if (repairCallback != null) {
                repairCallback.onProgress(round, -1,
                        round == 0 ? "EvaluatorAgent 正在审查 HTML 幻灯片质量..."
                                   : String.format("第 %d 轮修复后重新审查...", round));
            }

            if (slideStatusCallback != null) {
                for (int si = 0; si < allSlides.size(); si++) {
                    slideStatusCallback.onStatusChange(si, "evaluating",
                            round == 0 ? "质量审查中..." : "重新审查中...");
                }
            }

            // HTML 模式使用预览图进行视觉评估
            List<String> previewUrls = extractPreviewImageUrls(allSlides);
            evalResult = evaluatePresentationWithVision(allSlides, outline, previewUrls);

            log.info("HTML 模式评估结果 (round={}): overall={}, content={}, design={}, coherence={}",
                    round, evalResult.overallScore(), evalResult.contentScore(),
                    evalResult.designScore(), evalResult.coherenceScore());

            if (tracker != null) {
                tracker.completeTask(evalTaskId, String.format(
                        "评估完成: 总分%d (内容%d/设计%d/连贯%d)",
                        evalResult.overallScore(), evalResult.contentScore(),
                        evalResult.designScore(), evalResult.coherenceScore()));
            }

            if (slideStatusCallback != null) {
                for (int si = 0; si < allSlides.size(); si++) {
                    slideStatusCallback.onStatusChange(si, "done", "完成");
                }
            }

            if (evalResult.overallScore() >= qualityThreshold) {
                log.info("HTML 模式质量达标 (score={} >= threshold={})", evalResult.overallScore(), qualityThreshold);
                break;
            }

            if (round == maxRepairRounds) {
                log.info("HTML 模式：已达到最大修复轮次 {}", maxRepairRounds);
                break;
            }

            // 识别低分页面
            List<SlideFeedback> slideFeedbacks = evalResult.slideFeedbacks();
            List<Integer> weakSlideIndexes = new ArrayList<>();
            if (slideFeedbacks != null) {
                for (SlideFeedback fb : slideFeedbacks) {
                    if (fb.score() < slideScoreThreshold && fb.slideIndex() < allSlides.size()) {
                        weakSlideIndexes.add(fb.slideIndex());
                    }
                }
            }

            if (weakSlideIndexes.isEmpty()) {
                for (int i = 1; i < allSlides.size() - 1 && weakSlideIndexes.size() < 3; i++) {
                    weakSlideIndexes.add(i);
                }
            }
            if (weakSlideIndexes.isEmpty()) break;

            repairRound = round + 1;
            log.info("HTML 模式第 {} 轮修复: 需修复 {} 页 (indexes={})",
                    repairRound, weakSlideIndexes.size(), weakSlideIndexes);

            if (tracker != null) {
                for (int idx : weakSlideIndexes) {
                    tracker.addTask(AgentTaskTracker.AgentRole.REPAIRER,
                            String.format("修复第 %d 页 HTML (round %d)", idx + 1, repairRound), idx);
                }
                tracker.pushFullList();
            }

            if (slideStatusCallback != null) {
                for (int idx : weakSlideIndexes) {
                    slideStatusCallback.onStatusChange(idx, "repairing",
                            String.format("第%d轮修复中...", repairRound));
                }
            }

            repairHtmlWeakSlides(allSlides, sections, weakSlideIndexes,
                    evalResult, repairRound, progressCallback, repairCallback, tracker, slideStatusCallback);
        }

        if (tracker != null) {
            tracker.addTask(AgentTaskTracker.AgentRole.ASSEMBLER, "组装最终 PPT 文件（HTML→PPTX）");
            tracker.pushFullList();
        }

        return new GenerationWithEvalResult(allSlides, evalResult, repairRound);
    }

    /**
     * HTML 模式：并发修复低分 HTML 幻灯片
     */
    private void repairHtmlWeakSlides(
            List<Map<String, Object>> allSlides,
            List<String> sections,
            List<Integer> weakIndexes,
            EvaluationResult prevEval,
            int repairRound,
            BiConsumer<Integer, Map<String, Object>> progressCallback,
            RepairProgressCallback repairCallback,
            AgentTaskTracker tracker,
            SlideStatusCallback slideStatusCallback) {

        int totalSlides = sections.size();
        Map<Integer, Map<String, Object>> repairedMap = new ConcurrentHashMap<>();
        List<CompletableFuture<Void>> futures = new ArrayList<>();

        String feedbackSummary = buildRepairFeedback(prevEval, weakIndexes);
        HtmlSlideAgent repairHtmlAgent = buildHtmlSlideAgent();
        DesignAgent repairDesignAgent = buildDesignAgent();

        Map<Integer, String> repairTaskIds = new ConcurrentHashMap<>();
        if (tracker != null) {
            List<Map<String, Object>> snapshot = tracker.getTaskListSnapshot();
            for (Map<String, Object> t : snapshot) {
                if ("REPAIRER".equals(t.get("agentRole"))
                        && "PENDING".equals(t.get("status"))
                        && t.containsKey("slideIndex")) {
                    int si = (int) t.get("slideIndex");
                    if (weakIndexes.contains(si)) {
                        repairTaskIds.put(si, (String) t.get("id"));
                    }
                }
            }
        }

        for (int idx : weakIndexes) {
            if (idx >= sections.size()) continue;
            final int slideIndex = idx;
            final String section = sections.get(slideIndex);

            if (repairCallback != null) {
                repairCallback.onProgress(repairRound, slideIndex,
                        String.format("正在修复第 %d 页 HTML...", slideIndex + 1));
            }

            CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
                String taskId = repairTaskIds.get(slideIndex);
                try {
                    if (tracker != null && taskId != null) {
                        tracker.startTask(taskId, "带评估反馈重新生成 HTML 内容...");
                    }

                    Map<String, Object> repairedConfig = regenerateHtmlSlideWithFeedback(
                            section, slideIndex, totalSlides, feedbackSummary, repairHtmlAgent);

                    enrichHtmlSlideWithDesign(repairedConfig, section, slideIndex, repairDesignAgent);
                    repairedMap.put(slideIndex, repairedConfig);

                    if (progressCallback != null) {
                        progressCallback.accept(slideIndex, repairedConfig);
                    }
                    if (tracker != null && taskId != null) {
                        tracker.completeTask(taskId, "HTML 修复完成");
                    }
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "done", "修复完成");
                    }
                } catch (Exception e) {
                    log.error("HTML 模式：第 {}/{} 页修复失败", slideIndex + 1, totalSlides, e);
                    if (slideStatusCallback != null) {
                        slideStatusCallback.onStatusChange(slideIndex, "failed", "修复失败");
                    }
                    if (tracker != null && taskId != null) {
                        tracker.failTask(taskId, "修复失败: " + e.getMessage());
                    }
                }
            }, slideExecutor);

            futures.add(future);
        }

        try {
            CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]))
                    .get(180, TimeUnit.SECONDS);
        } catch (Exception e) {
            log.error("HTML 模式修复超时或异常", e);
        }

        for (Map.Entry<Integer, Map<String, Object>> entry : repairedMap.entrySet()) {
            allSlides.set(entry.getKey(), entry.getValue());
        }
    }

    /**
     * HTML 模式：带评估反馈的 HTML 幻灯片重新生成
     */
    private Map<String, Object> regenerateHtmlSlideWithFeedback(
            String section, int slideIndex, int totalSlides,
            String feedbackSummary, HtmlSlideAgent htmlAgent) {

        String slideType = inferHtmlSlideType(slideIndex, totalSlides, section);

        String input = String.format("""
                REPAIR this HTML slide — it scored poorly. Create a VISUALLY STUNNING replacement.

                ## Slide Position
                Slide %d of %d — Type: **%s**

                ## Content for This Slide
                %s

                ## Evaluation Feedback (MUST FIX ALL ISSUES)
                %s

                ## MANDATORY VISUAL COMPLEXITY (the previous version was too plain!)
                ⚠ You MUST include ALL of these:
                - Gradient background (linear-gradient or radial-gradient), NOT plain white
                - Card-based layout with box-shadow and border-radius (16px)
                - 2-3 decorative div elements (colored circles, accent bars, geometric shapes)
                - Unicode emoji icons (📊💡🎯⚡🔬📈) in colored circles as visual anchors
                - Multi-column flexbox/grid layout, NOT single-column plain text
                - Colored title bar or header strip at top
                - Strong visual hierarchy: title ≥48px bold, body ≥24px

                ## Technical Rules
                - Single root `<div>`: width:1920px; height:1080px; overflow:hidden
                - ALL styles inline. NO <style> tags, NO external resources, NO JavaScript
                - Font: Arial, 'Helvetica Neue', sans-serif
                - Text language must match the content above

                ## Output — ONLY pure JSON:
                {"slide_html": "...", "slide_type": "...", "speaker_notes": "...", "image_suggestions": [...]}
                """,
                slideIndex + 1, totalSlides, slideType,
                cleanSectionText(section),
                feedbackSummary);

        String result = htmlAgent.generateHtmlSlide(input);
        Map<String, Object> slideConfig = parseSlideConfigSafe(result);

        if (!slideConfig.containsKey("slide_html")) {
            return createFallbackHtmlSlideConfig(section, slideIndex, totalSlides);
        }

        slideConfig.put("mode", "html");
        return slideConfig;
    }

    /**
     * HTML 模式：为 HTML 幻灯片补充 DesignAgent 生成的配图
     * 如果 slide_html 中包含 image-placeholder，DesignAgent 会生成图片 URL，
     * 由 Python 服务在渲染时替换 placeholder。
     */
    private void enrichHtmlSlideWithDesign(Map<String, Object> slideConfig, String section,
                                           int slideIndex, DesignAgent designAgent) {
        try {
            Object suggestions = slideConfig.get("image_suggestions");
            if (suggestions instanceof List<?> list && !list.isEmpty()) {
                String input = String.format("""
                        Provide a visual optimization plan for the following HTML slide.
                        
                        Slide content: %s
                        Image suggestions: %s
                        
                        Image sourcing strategy:
                        - If the topic is a REAL-WORLD entity, use searchWebImage first.
                        - If the topic is ABSTRACT or CONCEPTUAL, use generateSlideImage directly.
                        - Not every slide needs an image.
                        
                        Output pure JSON with "image_url" field.
                        """, section, list);

                String designResult = designAgent.designSlide(input);
                JsonNode designJson = parseJsonSafe(designResult);

                if (designJson != null && designJson.has("image_url")) {
                    String imageUrl = designJson.path("image_url").asText(null);
                    if (imageUrl != null && !imageUrl.isBlank() && !imageUrl.equals("null")) {
                        slideConfig.put("generated_image_url", imageUrl);
                        log.info("HTML 模式第{}页配图生成成功: {}", slideIndex + 1, imageUrl);

                        // 将图片注入 HTML：替换 image-placeholder div 为 <img> 标签
                        injectImageIntoHtml(slideConfig, imageUrl);
                    }
                }
            }
        } catch (Exception e) {
            log.warn("HTML 模式第{}页视觉优化跳过: {}", slideIndex + 1, e.getMessage());
        }
    }

    /**
     * 将生成的图片 URL 注入到 slide_html 中，替换 image-placeholder div
     * 支持两种 placeholder 格式：
     * 1. <div class="image-placeholder" data-image-suggestion="...">...</div>
     * 2. 任何包含 class="image-placeholder" 的 div
     */
    private void injectImageIntoHtml(Map<String, Object> slideConfig, String imageUrl) {
        String html = (String) slideConfig.get("slide_html");
        if (html == null) {
            return;
        }

        try {
            String replaced = html;

            if (html.contains("image-placeholder")) {
                // 方式1：替换 image-placeholder div 为包含实际图片的 div
                // 匹配: <div class="image-placeholder" ... >...</div>
                replaced = html.replaceFirst(
                        "(?s)<div[^>]*class=\"image-placeholder\"[^>]*>.*?</div>",
                        String.format(
                                "<div style=\"width:100%%;height:100%%;overflow:hidden;border-radius:16px;"
                                + "box-shadow:0 4px 20px rgba(0,0,0,0.1);\">"
                                + "<img src=\"%s\" style=\"width:100%%;height:100%%;object-fit:cover;\" />"
                                + "</div>",
                                imageUrl));
            }

            if (replaced.equals(html)) {
                // 方式2（fallback）：在根 div 的最后一个子元素前插入图片层
                // 作为半透明背景覆盖在幻灯片上
                String imgOverlay = String.format(
                        "<div style=\"position:absolute;top:0;right:0;width:45%%;height:100%%;"
                        + "overflow:hidden;opacity:0.15;z-index:0;\">"
                        + "<img src=\"%s\" style=\"width:100%%;height:100%%;object-fit:cover;\" />"
                        + "</div>",
                        imageUrl);

                // 在根 div 的第一个 > 之后插入（作为第一个子元素）
                int firstClose = replaced.indexOf('>');
                if (firstClose > 0) {
                    // 确保根 div 有 position:relative
                    if (!replaced.substring(0, firstClose).contains("position:")) {
                        replaced = replaced.substring(0, firstClose).replace("style=\"",
                                "style=\"position:relative;") + replaced.substring(firstClose);
                        firstClose = replaced.indexOf('>');
                    }
                    replaced = replaced.substring(0, firstClose + 1) + imgOverlay
                            + replaced.substring(firstClose + 1);
                    log.info("图片已作为背景层注入 HTML: {}", imageUrl);
                }
            } else {
                log.info("图片已替换 placeholder 注入 HTML: {}", imageUrl);
            }

            slideConfig.put("slide_html", replaced);
        } catch (Exception e) {
            log.warn("图片注入 HTML 失败: {}", e.getMessage());
        }
    }

    /**
     * HTML 模式 fallback：生成简单的 HTML 幻灯片
     */
    private Map<String, Object> createFallbackHtmlSlideConfig(String section, int slideIndex, int totalSlides) {
        String cleaned = cleanSectionText(section);
        String[] lines = cleaned.split("\n");
        String title = lines.length > 0 ? lines[0].replaceAll("^#+\\s*", "") : "Slide " + (slideIndex + 1);

        StringBuilder bodyHtml = new StringBuilder();
        for (int i = 1; i < lines.length; i++) {
            String line = lines[i].replaceAll("^[-*#\\s]+", "").trim();
            if (!line.isEmpty()) {
                bodyHtml.append(String.format(
                        "<div style=\"font-size:28px;color:#334155;margin:16px 0;"
                        + "padding:12px 20px;background:#F1F5F9;border-radius:8px;"
                        + "border-left:4px solid #2563EB;\">%s</div>", line));
            }
        }

        boolean isDarkSlide = slideIndex == 0 || slideIndex == totalSlides - 1;
        String bg = isDarkSlide
                ? "linear-gradient(135deg, #1E293B, #0F172A)"
                : "#FFFFFF";
        String titleColor = isDarkSlide ? "#F1F5F9" : "#1E293B";
        String titleSize = slideIndex == 0 ? "64px" : "48px";
        String layout = isDarkSlide
                ? "display:flex;align-items:center;justify-content:center;flex-direction:column;"
                : "padding:80px 100px;";
        String accentBar = isDarkSlide
                ? String.format("<div style=\"width:120px;height:4px;background:#2563EB;"
                        + "margin:%s;border-radius:2px;\"></div>",
                        slideIndex == 0 ? "32px auto 0" : "32px auto 0")
                : "";

        String html = String.format(
                "<div style=\"width:1920px;height:1080px;background:%s;%s"
                + "overflow:hidden;font-family:Arial,'Helvetica Neue',sans-serif;\">"
                + "<div style=\"font-size:%s;font-weight:700;color:%s;"
                + "letter-spacing:-0.5px;line-height:1.2;\">%s</div>"
                + "%s%s</div>",
                bg, layout, titleSize, titleColor, title, accentBar, bodyHtml);

        Map<String, Object> config = new HashMap<>();
        config.put("slide_html", html);
        config.put("slide_type", inferHtmlSlideType(slideIndex, totalSlides, section));
        config.put("speaker_notes", "");
        config.put("image_suggestions", List.of());
        config.put("mode", "html");
        return config;
    }

    /**
     * HTML 模式下的页面类型推断
     */
    private String inferHtmlSlideType(int slideIndex, int totalSlides, String section) {
        if (slideIndex == 0) return "cover";
        if (slideIndex == totalSlides - 1) return "ending";
        String cleaned = section != null ? cleanSectionText(section).trim() : "";
        if (cleaned.startsWith("## ") && !cleaned.contains("### ")) return "section";
        return "content";
    }

    // ==================== 数据类 ====================

    public record OutlineResult(
            String outlineMarkdown,
            String researchSummary
    ) {}

    public record SlideFeedback(
            int slideIndex,
            int score,
            String feedback
    ) {}

    public record EvaluationResult(
            int overallScore,
            int contentScore,
            int designScore,
            int coherenceScore,
            List<String> strengths,
            List<String> weaknesses,
            List<String> suggestions,
            List<SlideFeedback> slideFeedbacks
    ) {
        public static EvaluationResult defaultResult() {
            return new EvaluationResult(
                    70, 70, 70, 70,
                    List.of("内容完整"), List.of("待评估"), List.of("待优化"),
                    List.of());
        }
    }

    /**
     * 带反思修复循环的完整生成结果
     */
    public record GenerationWithEvalResult(
            List<Map<String, Object>> slides,
            EvaluationResult evaluation,
            int repairRounds
    ) {}
}
