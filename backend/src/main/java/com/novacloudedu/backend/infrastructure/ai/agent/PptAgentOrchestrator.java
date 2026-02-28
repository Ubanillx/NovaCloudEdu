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
                你是一位专业的PPT质量评审专家，擅长从视觉和内容两个维度评估幻灯片质量。
                你会收到PPT每页的渲染截图和对应的内容配置。请仔细查看每张图片，评估：
                
                1. **内容质量** (content_score): 信息准确性、专业深度、数据支撑、文字精炼度
                2. **视觉设计** (design_score): 排版美观度、颜色搭配、图文比例、留白合理性、字体大小可读性
                3. **结构连贯** (coherence_score): 页面间逻辑衔接、主题一致性、信息递进关系
                
                对每一页都给出单独评分和具体反馈，特别关注：
                - 是否有模板原始占位文字残留（如"单击此处"、"添加标题"等）或与AI生成内容重叠
                - 文字是否溢出文本框或被截断
                - 图片是否模糊、变形或与内容不匹配
                - 排版是否拥挤或过于空旷
                - 配色是否和谐
                
                如果发现模板原始文字残留或内容重叠，该页评分必须低于50分。
                
                输出纯JSON，格式：
                {
                    "overall_score": 0-100,
                    "content_score": 0-100,
                    "design_score": 0-100,
                    "coherence_score": 0-100,
                    "strengths": ["优点1", "优点2"],
                    "weaknesses": ["不足1", "不足2"],
                    "improvement_suggestions": ["建议1", "建议2"],
                    "slide_level_feedback": [
                        {"slide_index": 0, "score": 75, "feedback": "具体问题描述"},
                        {"slide_index": 1, "score": 60, "feedback": "具体问题描述"}
                    ]
                }
                """;

        // 构建用户消息：文本描述 + 所有预览图
        StringBuilder userMsg = new StringBuilder();
        userMsg.append("以下是一份PPT的所有页面渲染截图和对应内容。请逐页审查并给出评估。\n\n");
        userMsg.append("## 原始大纲\n").append(outline).append("\n\n");
        userMsg.append("## 幻灯片内容（共").append(slides.size()).append("页）\n\n");

        for (int i = 0; i < slides.size(); i++) {
            userMsg.append("### 第").append(i + 1).append("页");
            if (i < validImageUrls.size() && validImageUrls.get(i) != null) {
                userMsg.append("（见对应图片）");
            }
            userMsg.append("\n");
            try {
                userMsg.append(objectMapper.writeValueAsString(slides.get(i)));
            } catch (Exception e) {
                userMsg.append("（内容序列化失败）");
            }
            userMsg.append("\n\n");
        }

        userMsg.append("请仔细查看所有幻灯片截图，对每页的视觉效果和内容质量进行评估，输出纯JSON。");

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

        String title = lines.length > 0 ? lines[0].replaceAll("^#+\\s*", "") : "第" + (slideIndex + 1) + "页";
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
        sb.append("PPT主题：").append(topic).append("\n\n");

        if (requirements != null && !requirements.isBlank()) {
            sb.append("额外要求：").append(requirements).append("\n\n");
        }
        if (templateInfo != null && !templateInfo.isBlank()) {
            sb.append("## 模板结构（你必须严格按照其中的「大纲结构要求」来规划）\n\n");
            sb.append(templateInfo).append("\n\n");
            sb.append("重要提示：\n");
            sb.append("- 请严格按照上面的「大纲结构要求」控制 ##（章节）和 ###（内容页）的数量\n");
            sb.append("- 每个 ### 对应一页PPT，总数必须匹配模板的 content 页数量\n");
            sb.append("- 不需要标注 template_slide_index，系统会自动分配模板页\n\n");
        }

        sb.append("请先使用联网搜索工具收集该主题的最新信息，然后制定大纲。");
        return sb.toString();
    }

    private String buildEvaluationInput(List<Map<String, Object>> slides, String outline) {
        StringBuilder sb = new StringBuilder();
        sb.append("## 原始大纲\n").append(outline).append("\n\n");
        sb.append("## 生成的幻灯片内容（共").append(slides.size()).append("页）\n\n");

        for (int i = 0; i < slides.size(); i++) {
            try {
                sb.append("### 第").append(i + 1).append("页\n");
                sb.append(objectMapper.writeValueAsString(slides.get(i)));
                sb.append("\n\n");
            } catch (Exception e) {
                sb.append("（解析失败）\n\n");
            }
        }

        sb.append("请对这份PPT进行全面的质量评估，输出纯JSON。");
        return sb.toString();
    }

    // ==================== 解析方法 ====================

    private OutlineResult parseOutlineResult(String rawResult) {
        // 分离研究摘要和大纲
        String researchSummary = "";
        String outlineMarkdown = rawResult;

        int outlineIdx = rawResult.indexOf("## PPT大纲");
        if (outlineIdx == -1) {
            outlineIdx = rawResult.indexOf("## PPT 大纲");
        }

        if (outlineIdx > 0) {
            researchSummary = rawResult.substring(0, outlineIdx).trim();
            outlineMarkdown = rawResult.substring(outlineIdx + "## PPT大纲".length()).trim();
            // 移除 "## 研究摘要" 前缀
            if (researchSummary.startsWith("## 研究摘要")) {
                researchSummary = researchSummary.substring("## 研究摘要".length()).trim();
            }
        }

        return new OutlineResult(outlineMarkdown, researchSummary);
    }

    private Map<String, Object> parseSlideConfigSafe(String jsonStr) {
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
