package com.novacloudedu.backend.application.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.ppt.entity.PptGenerationSession;
import com.novacloudedu.backend.domain.ppt.entity.PptTemplate;
import com.novacloudedu.backend.domain.ppt.repository.PptGenerationSessionRepository;
import com.novacloudedu.backend.domain.ppt.repository.PptTemplateRepository;
import com.novacloudedu.backend.domain.ppt.valueobject.PptTemplateId;
import com.novacloudedu.backend.domain.membership.service.AiUsageLimitService;
import com.novacloudedu.backend.domain.membership.valueobject.AiFeatureType;
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
import com.novacloudedu.backend.infrastructure.ai.agent.AgentTaskTracker;
import com.novacloudedu.backend.infrastructure.ai.agent.PptAgentOrchestrator;
import com.novacloudedu.backend.infrastructure.ppt.PptServiceClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * PPT生成助手编排服务
 *
 * 多步骤流程：
 * 1. AI 流式生成 Markdown 大纲
 * 2. 用户确认/修改大纲
 * 3. 选择模板 → 调 Python 解析
 * 4. AI 逐页生成填充 JSON
 * 5. 组装 → 调 Python 生成 PPTX → 返回 OSS URL
 *
 * 所有步骤通过 SSE 实时推送到前端。
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PptGenerationService {

    private final PptGenerationSessionRepository sessionRepository;
    private final PptTemplateRepository templateRepository;
    private final LangchainChatService langchainChatService;
    private final PptServiceClient pptServiceClient;
    private final AiUsageLimitService aiUsageLimitService;
    private final PptAgentOrchestrator pptAgentOrchestrator;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final ExecutorService executor = Executors.newCachedThreadPool();

    // ==================== 意图识别 Prompt ====================

    private static final String INTENT_SYSTEM_PROMPT = """
            你是一个意图识别助手。分析用户的消息，判断用户是否想要生成PPT/演示文稿。

            如果用户想要生成PPT，请：
            1. 用友好的语气确认用户的需求
            2. 提炼出PPT的核心主题
            3. 在回复的最后一行，输出一个JSON标记：<<PPT_INTENT:{"topic":"提炼的主题"}>>

            如果用户不是想要生成PPT，请正常回复用户的问题，不要输出任何标记。

            示例1：
            用户：帮我做一个关于人工智能在教育领域应用的PPT
            回复：好的，我来帮你生成一个关于「人工智能在教育领域的应用」的PPT。我会先为你生成一份大纲，你确认后再进行制作。
            <<PPT_INTENT:{"topic":"人工智能在教育领域的应用"}>>

            示例2：
            用户：今天天气怎么样
            回复：抱歉，我无法查询天气信息。如果你需要制作PPT，可以告诉我主题，我来帮你生成。
            """;

    // ==================== 大纲生成用模型（超长上下文） ====================

    private static final String PPT_OUTLINE_MODEL = "dashscope/qwen-long";

    // ==================== 逐页填充用视觉模型 ====================

    private static final String PPT_SLIDE_VISION_MODEL = "dashscope/qwen-vl-max";

    // ==================== 大纲 Prompt ====================

    private static final String OUTLINE_SYSTEM_PROMPT = """
            你是一个专业的PPT大纲设计师。你需要根据用户的主题、要求以及PPT模板的页面结构来生成一个结构化的Markdown大纲。

            模板页面结构会在用户消息中以JSON描述的形式提供。你需要根据模板拥有的页面类型（封面cover、章节section、正文content、结束ending）来合理规划大纲结构。

            要求：
            1. 使用 Markdown 格式：# 为PPT标题（封面），## 为章节/分节标题，### 为该节的要点
            2. 每个章节包含 2-4 个要点，要点内容简洁有力
            3. 必须包含封面页（# 标题）和结束页（## 感谢/结语）
            4. 大纲的章节数量应适配模板页面数量，不要生成过多或过少的章节
            5. 参考模板中每页的文本槽位数量来调整每页的内容量
            6. 内容专业、有逻辑性，适合PPT展示
            7. 不要输出任何非大纲的内容（不要解释说明）
            """;

    private static final String REVISE_SYSTEM_PROMPT = """
            你是一个专业的PPT大纲设计师。用户对之前的大纲不满意，请根据反馈修改大纲。

            修改要求：
            1. 保持 Markdown 格式不变
            2. 根据用户的具体反馈进行针对性修改
            3. 只输出修改后的完整大纲，不要解释
            """;

    // ==================== 逐页填充 Prompt（视觉模型增强） ====================

    private static final String SLIDE_FILL_SYSTEM_PROMPT = """
            你是一个PPT内容填充助手。你会收到一张模板页的高清截图和该页的槽位结构信息。
            请仔细观察截图中的布局、样式、文字位置，结合大纲内容，生成合理的填充配置 JSON。

            视觉理解要求：
            1. 观察截图了解页面的视觉布局和设计风格
            2. 根据截图中文字的位置和大小，判断每个槽位适合放多少文字
            3. 标题类槽位文字简短有力，内容类槽位可以适当详细

            严格要求：
            1. 只输出纯JSON，不要输出markdown代码块标记，不要解释
            2. template_slide_index 必须是模板中实际存在的页索引
            3. shape_id 必须使用模板页中列出的 shape_id
            4. 根据页面角色选择合适的模板页：cover→封面页, content→正文页, section→章节页, ending→结束页
            5. 文本长度要简洁，适合PPT展示
            6. 如果是要点列表，用 items 数组而非 text
            """;

    // ==================== 公共方法 ====================

    /**
     * 处理前端的各种 action 请求，返回 SSE 流
     */
    public SseEmitter handleAction(String action, Map<String, Object> params, Long userId) {
        return switch (action) {
            case "detect_intent" -> doDetectIntent(params, userId);
            case "generate_outline" -> doGenerateOutline(params, userId);
            case "revise_outline" -> doReviseOutline(params, userId);
            case "confirm_outline" -> doConfirmOutline(params, userId);
            case "select_template" -> doSelectTemplate(params, userId);
            case "generate_ppt" -> doGeneratePpt(params, userId);
            case "agent_generate_outline" -> doAgentGenerateOutline(params, userId);
            case "agent_generate_ppt" -> doAgentGeneratePpt(params, userId);
            case "assemble_ppt" -> doAssemblePpt(params, userId);
            default -> throw new BusinessException(40000, "未知的操作: " + action);
        };
    }

    // ==================== 步骤 0：意图识别 ====================

    private SseEmitter doDetectIntent(Map<String, Object> params, Long userId) {
        String message = (String) params.get("message");
        if (message == null || message.isBlank()) {
            throw new BusinessException(40000, "缺少 message 参数");
        }

        EmitterHolder holder = createEmitter(60_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                StringBuilder fullResponse = new StringBuilder();
                List<Map<String, String>> messages = List.of(
                        Map.of("role", "system", "content", INTENT_SYSTEM_PROMPT),
                        Map.of("role", "user", "content", message)
                );

                langchainChatService.streamChat(null, messages, token -> {
                    if (!alive.get()) return;
                    try {
                        fullResponse.append(token);
                        emitter.send(SseEmitter.event().name("message").data(token));
                    } catch (IOException e) {
                        alive.set(false);
                        log.debug("SSE发送失败，客户端可能已断开");
                    }
                });

                // 解析 AI 回复中的意图标记
                String aiResponse = fullResponse.toString();
                String intentMarker = extractIntentMarker(aiResponse);

                if (intentMarker != null) {
                    JsonNode intentJson = objectMapper.readTree(intentMarker);
                    String topic = intentJson.path("topic").asText("");

                    PptGenerationSession session = PptGenerationSession.create(userId, topic);
                    sessionRepository.save(session);

                    sendEvent(emitter, alive, "intent", Map.of(
                            "detected", true,
                            "topic", topic,
                            "sessionId", session.getId()
                    ));
                } else {
                    sendEvent(emitter, alive, "intent", Map.of(
                            "detected", false
                    ));
                }

                sendDone(emitter, alive);

            } catch (Exception e) {
                log.error("意图识别异常", e);
                if (alive.get()) {
                    try {
                        emitter.send(SseEmitter.event().name("error").data(e.getMessage()));
                    } catch (IOException ioException) {
                        log.debug("客户端已断开，无法发送错误消息");
                    }
                    try { emitter.completeWithError(e); } catch (Exception ignored) {}
                }
                alive.set(false);
            }
        });

        return emitter;
    }

    /**
     * 从 AI 回复中提取 PPT_INTENT 标记
     */
    private String extractIntentMarker(String response) {
        String prefix = "<<PPT_INTENT:";
        String suffix = ">>";
        int start = response.indexOf(prefix);
        if (start < 0) return null;
        int jsonStart = start + prefix.length();
        int end = response.indexOf(suffix, jsonStart);
        if (end < 0) return null;
        return response.substring(jsonStart, end).trim();
    }

    // ==================== 步骤 1：生成大纲 ====================

    private SseEmitter doGenerateOutline(Map<String, Object> params, Long userId) {
        aiUsageLimitService.checkAndConsume(userId, AiFeatureType.AI_PPT);
        Long sessionId = toLong(params.get("sessionId"));
        String requirements = (String) params.getOrDefault("requirements", "");

        PptGenerationSession session = getSessionAndVerify(sessionId, userId);
        session.startGeneratingOutline();
        sessionRepository.save(session);

        EmitterHolder holder = createEmitter(300_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                sendEvent(emitter, alive, "status",
                        Map.of("phase", "generating_outline", "message", "正在根据模板结构生成大纲..."));

                // 构建包含模板结构的用户消息
                StringBuilder userMessage = new StringBuilder();
                userMessage.append("主题：").append(session.getTopic());
                if (requirements != null && !requirements.isBlank()) {
                    userMessage.append("\n额外要求：").append(requirements);
                }

                // 将模板结构摘要喂给 AI（精准控制页数）
                if (session.getTemplateJson() != null && !session.getTemplateJson().isBlank()) {
                    JsonNode templateRoot = objectMapper.readTree(session.getTemplateJson());
                    TemplateAnalysis ta = analyzeTemplate(templateRoot);
                    String templatePrompt = buildTemplatePlannerPrompt(ta);
                    userMessage.append("\n\nBelow is the presentation template page structure. Plan the outline according to this structure:\n");
                    userMessage.append(templatePrompt);
                }

                StringBuilder fullOutline = new StringBuilder();
                List<Map<String, String>> messages = List.of(
                        Map.of("role", "system", "content", OUTLINE_SYSTEM_PROMPT),
                        Map.of("role", "user", "content", userMessage.toString())
                );

                // 使用超长上下文模型
                langchainChatService.streamChat(PPT_OUTLINE_MODEL, messages, token -> {
                    if (!alive.get()) return;
                    try {
                        fullOutline.append(token);
                        emitter.send(SseEmitter.event().name("message").data(token));
                    } catch (IOException e) {
                        alive.set(false);
                        log.debug("SSE发送失败，客户端可能已断开");
                    }
                });

                // 大纲生成完成，保存
                session.outlineReady(fullOutline.toString());
                sessionRepository.save(session);

                sendEvent(emitter, alive, "outline", Map.of(
                        "sessionId", session.getId(),
                        "markdown", fullOutline.toString()
                ));
                sendDone(emitter, alive);

            } catch (Exception e) {
                handleError(emitter, alive, session, e);
            }
        });

        return emitter;
    }

    // ==================== 步骤 2：修改大纲 ====================

    private SseEmitter doReviseOutline(Map<String, Object> params, Long userId) {
        Long sessionId = toLong(params.get("sessionId"));
        String feedback = (String) params.get("feedback");

        PptGenerationSession session = getSessionAndVerify(sessionId, userId);
        session.startGeneratingOutline();
        sessionRepository.save(session);

        EmitterHolder holder = createEmitter(300_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                sendEvent(emitter, alive, "status",
                        Map.of("phase", "generating_outline", "message", "正在根据反馈修改大纲..."));

                String userMessage = "原大纲：\n" + session.getOutlineMarkdown()
                        + "\n\n用户反馈：\n" + feedback;

                StringBuilder fullOutline = new StringBuilder();
                List<Map<String, String>> messages = List.of(
                        Map.of("role", "system", "content", REVISE_SYSTEM_PROMPT),
                        Map.of("role", "user", "content", userMessage)
                );

                langchainChatService.streamChat(null, messages, token -> {
                    if (!alive.get()) return;
                    try {
                        fullOutline.append(token);
                        emitter.send(SseEmitter.event().name("message").data(token));
                    } catch (IOException e) {
                        alive.set(false);
                        log.debug("SSE发送失败，客户端可能已断开");
                    }
                });

                session.outlineReady(fullOutline.toString());
                sessionRepository.save(session);

                sendEvent(emitter, alive, "outline", Map.of(
                        "sessionId", session.getId(),
                        "markdown", fullOutline.toString()
                ));
                sendDone(emitter, alive);

            } catch (Exception e) {
                handleError(emitter, alive, session, e);
            }
        });

        return emitter;
    }

    // ==================== 步骤 3：确认大纲 ====================

    private SseEmitter doConfirmOutline(Map<String, Object> params, Long userId) {
        Long sessionId = toLong(params.get("sessionId"));

        PptGenerationSession session = getSessionAndVerify(sessionId, userId);
        // 新流程：模板已在大纲之前选好，确认大纲后直接进入可生成状态
        sessionRepository.save(session);

        EmitterHolder holder = createEmitter(30_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                sendEvent(emitter, alive, "status",
                        Map.of("phase", "template_ready", "message", "大纲已确认，准备生成幻灯片"));
                sendEvent(emitter, alive, "outline_confirmed", Map.of(
                        "sessionId", session.getId()
                ));
                sendDone(emitter, alive);
            } catch (Exception e) {
                handleError(emitter, alive, session, e);
            }
        });

        return emitter;
    }

    // ==================== 步骤 4：选择模板 ====================

    private SseEmitter doSelectTemplate(Map<String, Object> params, Long userId) {
        Long sessionId = toLong(params.get("sessionId"));
        Long templateId = params.get("templateId") != null ? toLong(params.get("templateId")) : null;
        String templateUrl = (String) params.get("templateUrl");

        PptGenerationSession session = getSessionAndVerify(sessionId, userId);

        EmitterHolder holder = createEmitter(120_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                // 确定 templateUrl
                String resolvedUrl = templateUrl;
                if (templateId != null && (resolvedUrl == null || resolvedUrl.isBlank())) {
                    PptTemplate template = templateRepository.findById(PptTemplateId.of(templateId))
                            .orElseThrow(() -> new BusinessException(40400, "模板不存在"));

                    // 如果已有解析结果，直接使用
                    if (template.getStructureJson() != null && !template.getStructureJson().isBlank()) {
                        session.startParsingTemplate(templateId, template.getTemplateUrl());
                        session.templateReady(template.getStructureJson());
                        sessionRepository.save(session);

                        sendEvent(emitter, alive, "status",
                                Map.of("phase", "template_ready", "message", "模板已就绪，正在渲染预览..."));

                        // 渲染幻灯片图片
                        PptServiceClient.RenderSlidesResult renderResult =
                                pptServiceClient.renderSlideImages(template.getTemplateUrl());

                        sendEvent(emitter, alive, "template_parsed",
                                parseTemplateJsonForFrontend(template.getStructureJson(),
                                        template.getTemplateUrl(), renderResult));
                        sendDone(emitter, alive);
                        return;
                    }
                    resolvedUrl = template.getTemplateUrl();
                }

                if (resolvedUrl == null || resolvedUrl.isBlank()) {
                    throw new BusinessException(40000, "请提供模板ID或模板URL");
                }

                session.startParsingTemplate(templateId, resolvedUrl);
                sessionRepository.save(session);
                sendEvent(emitter, alive, "status",
                        Map.of("phase", "parsing_template", "message", "正在解析模板..."));

                // 调 Python 解析模板
                PptServiceClient.ParseTemplateResult parseResult =
                        pptServiceClient.parseTemplate(resolvedUrl);

                session.templateReady(parseResult.fullResponseJson());
                sessionRepository.save(session);

                sendEvent(emitter, alive, "status",
                        Map.of("phase", "template_ready", "message", "模板解析完成，正在渲染预览..."));

                // 渲染幻灯片图片
                PptServiceClient.RenderSlidesResult renderResult =
                        pptServiceClient.renderSlideImages(resolvedUrl);

                sendEvent(emitter, alive, "template_parsed",
                        parseTemplateJsonForFrontend(parseResult.fullResponseJson(),
                                resolvedUrl, renderResult));
                sendDone(emitter, alive);

            } catch (Exception e) {
                handleError(emitter, alive, session, e);
            }
        });

        return emitter;
    }

    // ==================== 步骤 5：生成 PPT（逐页渲染预览 + 自动组装） ====================

    private SseEmitter doGeneratePpt(Map<String, Object> params, Long userId) {
        Long sessionId = toLong(params.get("sessionId"));
        PptGenerationSession session = getSessionAndVerify(sessionId, userId);

        if (session.getTemplateJson() == null || session.getTemplateJson().isBlank()) {
            throw new BusinessException(40000, "请先选择模板");
        }
        if (session.getOutlineMarkdown() == null || session.getOutlineMarkdown().isBlank()) {
            throw new BusinessException(40000, "大纲为空");
        }

        EmitterHolder holder = createEmitter(600_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                session.startGeneratingSlides();
                sessionRepository.save(session);
                sendEvent(emitter, alive, "status",
                        Map.of("phase", "generating_slides", "message", "AI 正在逐页生成内容..."));

                // 1. 解析大纲为章节列表
                List<String> sections = parseOutlineToSections(session.getOutlineMarkdown());
                int totalSlides = sections.size();

                // 2. 解析模板结构
                JsonNode templateRoot = objectMapper.readTree(session.getTemplateJson());
                String templateSlidesInfo = buildTemplateSlidesDescription(templateRoot);

                // 3. 逐页：AI 生成配置 → 渲染预览图 → 推送前端
                List<Map<String, Object>> allSlides = new ArrayList<>();
                String templateUrl = session.getTemplateUrl();

                for (int i = 0; i < totalSlides; i++) {
                    if (!alive.get()) {
                        log.info("客户端已断开，停止生成: sessionId={}, 已完成 {}/{} 页",
                                session.getId(), i, totalSlides);
                        break;
                    }

                    String section = sections.get(i);
                    sendEvent(emitter, alive, "status",
                            Map.of("phase", "generating_slides",
                                    "message", String.format("正在生成第 %d/%d 页...", i + 1, totalSlides)));

                    // AI 生成单页填充 JSON（纯文本模式）
                    String slideJson = generateSlideConfig(
                            section, templateSlidesInfo, i, totalSlides, null);
                    Map<String, Object> slideConfig = parseSlideJson(slideJson);

                    if (slideConfig != null) {
                        // 调 Python 克隆+填充+渲染该页为 PNG 预览图
                        String previewImageUrl = null;
                        try {
                            PptServiceClient.SlidePreviewResult previewResult =
                                    pptServiceClient.generateSlidePreview(templateUrl, slideConfig);
                            previewImageUrl = previewResult.imageUrl();
                        } catch (Exception e) {
                            log.warn("第{}页预览图渲染失败: {}", i + 1, e.getMessage());
                        }

                        // 将预览图 URL 写入 slideConfig，以便持久化到 slidesJson
                        if (previewImageUrl != null) {
                            slideConfig.put("previewImageUrl", previewImageUrl);
                        }
                        allSlides.add(slideConfig);

                        Map<String, Object> progressData = new HashMap<>();
                        progressData.put("current", i + 1);
                        progressData.put("total", totalSlides);
                        progressData.put("previewImageUrl", previewImageUrl != null ? previewImageUrl : "");
                        sendEvent(emitter, alive, "slide_progress", progressData);
                    } else {
                        log.warn("第{}页JSON解析失败，跳过", i + 1);
                    }
                }

                if (allSlides.isEmpty()) {
                    throw new RuntimeException("未生成任何有效的幻灯片配置");
                }

                // 5. 保存 slidesJson
                session.saveSlidesJson(objectMapper.writeValueAsString(allSlides));
                sessionRepository.save(session);

                // 6. 自动组装完整 PPTX
                sendEvent(emitter, alive, "status",
                        Map.of("phase", "assembling", "message", "正在生成PPT文件..."));
                session.startAssembling(session.getSlidesJson());
                sessionRepository.save(session);

                String title = extractTitle(session.getOutlineMarkdown());
                Map<String, Object> generateRequest = new HashMap<>();
                generateRequest.put("template_url", templateUrl);
                generateRequest.put("title", title);
                generateRequest.put("author", "");
                generateRequest.put("slides", allSlides);

                PptServiceClient.GenerateResult result = pptServiceClient.generate(generateRequest);

                session.completed(result.fileUrl());
                sessionRepository.save(session);

                sendEvent(emitter, alive, "status",
                        Map.of("phase", "completed", "message", "PPT生成完成！"));
                sendEvent(emitter, alive, "result", Map.of(
                        "fileUrl", result.fileUrl(),
                        "fileName", result.fileName(),
                        "slideCount", result.slideCount()
                ));
                sendDone(emitter, alive);

            } catch (Exception e) {
                handleError(emitter, alive, session, e);
            }
        });

        return emitter;
    }

    // ==================== Agent 模式：智能大纲生成（带联网搜索） ====================

    private SseEmitter doAgentGenerateOutline(Map<String, Object> params, Long userId) {
        aiUsageLimitService.checkAndConsume(userId, AiFeatureType.AI_PPT);
        Long sessionId = toLong(params.get("sessionId"));
        String requirements = (String) params.getOrDefault("requirements", "");

        PptGenerationSession session = getSessionAndVerify(sessionId, userId);
        session.startGeneratingOutline();
        sessionRepository.save(session);

        EmitterHolder holder = createEmitter(600_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                // 创建任务跟踪器，通过 SSE 推送 agent_todo 事件
                AgentTaskTracker tracker = new AgentTaskTracker(event -> {
                    if (alive.get()) {
                        try {
                            sendEvent(emitter, alive, "agent_todo", event);
                        } catch (IOException ex) {
                            log.warn("推送 agent_todo 事件失败", ex);
                            alive.set(false);
                        }
                    }
                });

                sendEvent(emitter, alive, "status",
                        Map.of("phase", "agent_researching", "message",
                                "AI Agent 正在联网搜索相关资料..."));

                // 获取模板结构摘要（精简版供 PlannerAgent 使用，精准控制页数）
                String templateSummary = null;
                if (session.getTemplateJson() != null && !session.getTemplateJson().isBlank()) {
                    JsonNode templateRoot = objectMapper.readTree(session.getTemplateJson());
                    TemplateAnalysis ta = analyzeTemplate(templateRoot);
                    templateSummary = buildTemplatePlannerPrompt(ta);
                }

                // Vision-based 模板智能分析：借鉴 PPTAgent V1 SlideInducter，
                // 为 PlannerAgent 提供更丰富的模板语义理解（版式分类/适合内容类型/空间分布）
                if (session.getTemplateUrl() != null && !session.getTemplateUrl().isBlank()) {
                    try {
                        var visionResult = pptServiceClient.analyzeTemplate(session.getTemplateUrl());
                        if (visionResult.hasContent()) {
                            templateSummary = (templateSummary != null ? templateSummary + "\n\n" : "")
                                    + visionResult.agentDescription();
                            log.info("模板视觉分析已附加到 PlannerAgent 输入");
                        }
                    } catch (Exception e) {
                        log.warn("模板视觉分析失败，使用纯结构信息: {}", e.getMessage());
                    }
                }

                // PlannerAgent 联网搜索 + 规划大纲（带任务跟踪）
                PptAgentOrchestrator.OutlineResult outlineResult =
                        pptAgentOrchestrator.planOutline(session.getTopic(), requirements, templateSummary, tracker);

                // 推送研究摘要
                if (outlineResult.researchSummary() != null && !outlineResult.researchSummary().isBlank()) {
                    sendEvent(emitter, alive, "research_summary",
                            Map.of("summary", outlineResult.researchSummary()));
                }

                sendEvent(emitter, alive, "status",
                        Map.of("phase", "generating_outline", "message", "Agent 已完成调研，正在生成大纲..."));

                // 流式推送大纲内容（模拟逐字输出，提升体验）
                String outlineMarkdown = outlineResult.outlineMarkdown();
                int chunkSize = 20;
                for (int i = 0; i < outlineMarkdown.length() && alive.get(); i += chunkSize) {
                    String chunk = outlineMarkdown.substring(i, Math.min(i + chunkSize, outlineMarkdown.length()));
                    try {
                        emitter.send(SseEmitter.event().name("message").data(chunk));
                        Thread.sleep(30);
                    } catch (IOException e) {
                        alive.set(false);
                        break;
                    }
                }

                // 保存大纲
                session.outlineReady(outlineMarkdown);
                sessionRepository.save(session);

                sendEvent(emitter, alive, "outline", Map.of(
                        "sessionId", session.getId(),
                        "markdown", outlineMarkdown,
                        "researchSummary", outlineResult.researchSummary() != null
                                ? outlineResult.researchSummary() : ""
                ));
                sendDone(emitter, alive);

            } catch (Exception e) {
                handleError(emitter, alive, session, e);
            }
        });

        return emitter;
    }

    // ==================== Agent 模式：并发智能生成 PPT（搜索+文生图+评估+反思修复） ====================

    private SseEmitter doAgentGeneratePpt(Map<String, Object> params, Long userId) {
        Long sessionId = toLong(params.get("sessionId"));
        PptGenerationSession session = getSessionAndVerify(sessionId, userId);

        if (session.getTemplateJson() == null || session.getTemplateJson().isBlank()) {
            throw new BusinessException(40000, "请先选择模板");
        }
        if (session.getOutlineMarkdown() == null || session.getOutlineMarkdown().isBlank()) {
            throw new BusinessException(40000, "大纲为空");
        }

        EmitterHolder holder = createEmitter(900_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                session.startGeneratingSlides();
                sessionRepository.save(session);

                // SSE 发送锁：SseEmitter.send() 不是线程安全的，并发回调必须串行化发送
                final Object sseLock = new Object();

                // 创建任务跟踪器，通过 SSE 推送 agent_todo 事件
                AgentTaskTracker tracker = new AgentTaskTracker(event -> {
                    if (alive.get()) {
                        try {
                            synchronized (sseLock) {
                                sendEvent(emitter, alive, "agent_todo", event);
                            }
                        } catch (IOException ex) {
                            log.warn("推送 agent_todo 事件失败", ex);
                            alive.set(false);
                        }
                    }
                });

                sendEvent(emitter, alive, "status",
                        Map.of("phase", "agent_generating",
                                "message", "Multi-Agent 正在并发生成幻灯片（联网搜索 + 文生图）..."));

                // 1. 解析大纲为章节列表
                List<String> rawSections = parseOutlineToSections(session.getOutlineMarkdown());

                // 2. 解析模板结构 → 分析 → 分配 → 绑定
                JsonNode templateRoot = objectMapper.readTree(session.getTemplateJson());
                TemplateAnalysis ta = analyzeTemplate(templateRoot);
                Map<Integer, String> pageDescriptions = buildPerPageDescriptions(templateRoot);

                // 程序化分配 template_slide_index（根据 section 标题级别 → 模板角色）
                List<Integer> templateIndexes = assignTemplateSlideIndexes(rawSections, ta);

                // 将每个 section 与其对应模板页详情绑定（ContentAgent 只需看本页 shape 信息）
                List<String> sections = enrichSectionsWithTemplateInfo(rawSections, templateIndexes, pageDescriptions);
                int totalSlides = sections.size();

                // templateSlidesInfo 仅作为概览（ContentAgent 主要用 [TEMPLATE_PAGE] 块中的信息）
                String templateSlidesInfo = buildTemplatePlannerPrompt(ta);
                String templateUrl = session.getTemplateUrl();

                log.info("Agent PPT 生成: 大纲 {} 个 section, 模板 {} 页 (cover={}, toc={}, section={}, content={}, ending={}, credits={})",
                        totalSlides, ta.totalPages(), ta.coverCount(), ta.tocCount(),
                        ta.sectionCount(), ta.contentCount(), ta.endingCount(), ta.creditsCount());

                sendEvent(emitter, alive, "status",
                        Map.of("phase", "agent_generating",
                                "message", String.format("共 %d 页，Agent 并发生成中...", totalSlides)));

                // 2.5 推送所有幻灯片占位符（让前端立即显示全部占位符+状态）
                List<Map<String, Object>> placeholders = new ArrayList<>();
                for (int i = 0; i < totalSlides; i++) {
                    placeholders.add(Map.of(
                            "index", i,
                            "status", "pending",
                            "statusLabel", "等待生成"
                    ));
                }
                sendEvent(emitter, alive, "slide_placeholders",
                        Map.of("total", totalSlides, "slides", placeholders));

                // 3. 使用带反思修复循环的 Agent 生成（含任务跟踪）
                // 生成 → 评估 → 识别低分页 → 修复重生 → 再评估 → 直到达标或达最大轮次
                PptAgentOrchestrator.GenerationWithEvalResult genResult =
                        pptAgentOrchestrator.generateWithReflection(
                                sections,
                                templateSlidesInfo,
                                session.getOutlineMarkdown(),
                                templateUrl,
                                // 生成/修复进度回调：为每页渲染预览并推送 SSE
                                (slideIndex, slideConfig) -> {
                                    if (!alive.get()) return;
                                    try {
                                        // 如果逐页视觉审查已渲染预览图，复用它避免重复渲染
                                        String previewImageUrl = slideConfig.containsKey("previewImageUrl")
                                                ? (String) slideConfig.get("previewImageUrl") : null;
                                        if (previewImageUrl == null || previewImageUrl.isBlank()) {
                                            try {
                                                PptServiceClient.SlidePreviewResult previewResult =
                                                        pptServiceClient.generateSlidePreview(templateUrl, slideConfig);
                                                previewImageUrl = previewResult.imageUrl();
                                            } catch (Exception e) {
                                                log.warn("Agent模式：第{}页预览图渲染失败: {}",
                                                        slideIndex + 1, e.getMessage());
                                            }
                                        }

                                        if (previewImageUrl != null && !previewImageUrl.isBlank()) {
                                            slideConfig.put("previewImageUrl", previewImageUrl);
                                        }

                                        Map<String, Object> progressData = new HashMap<>();
                                        progressData.put("current", slideIndex + 1);
                                        progressData.put("total", totalSlides);
                                        progressData.put("previewImageUrl",
                                                previewImageUrl != null ? previewImageUrl : "");
                                        progressData.put("hasGeneratedImage",
                                                slideConfig.containsKey("generated_image_url"));
                                        synchronized (sseLock) {
                                            sendEvent(emitter, alive, "slide_progress", progressData);
                                        }
                                    } catch (Exception e) {
                                        log.warn("Agent模式：推送第{}页进度失败", slideIndex + 1, e);
                                    }
                                },
                                // 反思修复进度回调：推送修复状态到前端
                                (round, slideIndex, message) -> {
                                    if (!alive.get()) return;
                                    try {
                                        String phase = slideIndex == -1 ? "evaluating" : "repairing";
                                        Map<String, Object> repairData = new HashMap<>();
                                        repairData.put("phase", phase);
                                        repairData.put("round", round);
                                        repairData.put("message", message);
                                        if (slideIndex >= 0) {
                                            repairData.put("slideIndex", slideIndex);
                                        }
                                        synchronized (sseLock) {
                                            sendEvent(emitter, alive, "repair_progress", repairData);
                                        }
                                    } catch (Exception e) {
                                        log.warn("推送修复进度失败", e);
                                    }
                                },
                                tracker,
                                // 单页状态回调：推送 slide_status SSE 事件
                                (slideIdx, status, statusLabel) -> {
                                    if (!alive.get()) return;
                                    try {
                                        Map<String, Object> statusData = new HashMap<>();
                                        statusData.put("index", slideIdx);
                                        statusData.put("status", status);
                                        statusData.put("statusLabel", statusLabel);
                                        synchronized (sseLock) {
                                            sendEvent(emitter, alive, "slide_status", statusData);
                                        }
                                    } catch (Exception e) {
                                        log.warn("推送第{}页状态失败", slideIdx + 1, e);
                                    }
                                });

                List<Map<String, Object>> allSlides = genResult.slides();
                PptAgentOrchestrator.EvaluationResult evalResult = genResult.evaluation();
                int repairRounds = genResult.repairRounds();

                if (allSlides.isEmpty()) {
                    throw new RuntimeException("Agent 未生成任何有效的幻灯片配置");
                }

                // 4. 推送最终评估结果
                Map<String, Object> evalData = new HashMap<>();
                evalData.put("overallScore", evalResult.overallScore());
                evalData.put("contentScore", evalResult.contentScore());
                evalData.put("designScore", evalResult.designScore());
                evalData.put("coherenceScore", evalResult.coherenceScore());
                evalData.put("strengths", evalResult.strengths());
                evalData.put("weaknesses", evalResult.weaknesses());
                evalData.put("suggestions", evalResult.suggestions());
                evalData.put("repairRounds", repairRounds);
                if (evalResult.slideFeedbacks() != null) {
                    List<Map<String, Object>> sfList = new ArrayList<>();
                    for (var sf : evalResult.slideFeedbacks()) {
                        sfList.add(Map.of("slideIndex", sf.slideIndex(),
                                "score", sf.score(), "feedback", sf.feedback()));
                    }
                    evalData.put("slideFeedbacks", sfList);
                }
                sendEvent(emitter, alive, "evaluation_result", evalData);

                // 5. 保存 slidesJson
                session.saveSlidesJson(objectMapper.writeValueAsString(allSlides));
                sessionRepository.save(session);

                // 6. 自动组装完整 PPTX
                sendEvent(emitter, alive, "status",
                        Map.of("phase", "assembling", "message", "正在组装最终 PPT 文件..."));
                session.startAssembling(session.getSlidesJson());
                sessionRepository.save(session);

                String title = extractTitle(session.getOutlineMarkdown());
                Map<String, Object> generateRequest = new HashMap<>();
                generateRequest.put("template_url", templateUrl);
                generateRequest.put("title", title);
                generateRequest.put("author", "");
                generateRequest.put("slides", allSlides);

                PptServiceClient.GenerateResult result = pptServiceClient.generate(generateRequest);

                session.completed(result.fileUrl());
                sessionRepository.save(session);

                sendEvent(emitter, alive, "status",
                        Map.of("phase", "completed", "message", "PPT 生成完成！"));
                sendEvent(emitter, alive, "result", Map.of(
                        "fileUrl", result.fileUrl(),
                        "fileName", result.fileName(),
                        "slideCount", result.slideCount(),
                        "repairRounds", repairRounds,
                        "evaluation", Map.of(
                                "overallScore", evalResult.overallScore(),
                                "contentScore", evalResult.contentScore(),
                                "designScore", evalResult.designScore(),
                                "coherenceScore", evalResult.coherenceScore()
                        )
                ));
                sendDone(emitter, alive);

            } catch (Exception e) {
                handleError(emitter, alive, session, e);
            }
        });

        return emitter;
    }

    // ==================== 步骤 6：组装导出 PPT ====================

    private SseEmitter doAssemblePpt(Map<String, Object> params, Long userId) {
        Long sessionId = toLong(params.get("sessionId"));
        PptGenerationSession session = getSessionAndVerify(sessionId, userId);

        if (session.getSlidesJson() == null || session.getSlidesJson().isBlank()) {
            throw new BusinessException(40000, "尚未生成幻灯片内容");
        }

        // 如果前端传来了编辑后的 slides，更新 session
        Object slidesParam = params.get("slides");
        if (slidesParam != null) {
            try {
                String updatedSlidesJson = objectMapper.writeValueAsString(slidesParam);
                session.saveSlidesJson(updatedSlidesJson);
                sessionRepository.save(session);
            } catch (Exception e) {
                log.warn("解析前端传来的 slides 失败，使用数据库中的版本", e);
            }
        }

        EmitterHolder holder = createEmitter(600_000L);
        SseEmitter emitter = holder.emitter();
        AtomicBoolean alive = holder.alive();

        executor.execute(() -> {
            try {
                session.startAssembling(session.getSlidesJson());
                sessionRepository.save(session);
                sendEvent(emitter, alive, "status",
                        Map.of("phase", "assembling", "message", "正在生成PPT文件..."));

                List<Map<String, Object>> allSlides = objectMapper.readValue(
                        session.getSlidesJson(),
                        new TypeReference<List<Map<String, Object>>>() {});

                String title = extractTitle(session.getOutlineMarkdown());
                Map<String, Object> generateRequest = new HashMap<>();
                generateRequest.put("template_url", session.getTemplateUrl());
                generateRequest.put("title", title);
                generateRequest.put("author", "");
                generateRequest.put("slides", allSlides);

                PptServiceClient.GenerateResult result = pptServiceClient.generate(generateRequest);

                session.completed(result.fileUrl());
                sessionRepository.save(session);

                sendEvent(emitter, alive, "status",
                        Map.of("phase", "completed", "message", "PPT生成完成！"));
                sendEvent(emitter, alive, "result", Map.of(
                        "fileUrl", result.fileUrl(),
                        "fileName", result.fileName(),
                        "slideCount", result.slideCount()
                ));
                sendDone(emitter, alive);

            } catch (Exception e) {
                handleError(emitter, alive, session, e);
            }
        });

        return emitter;
    }

    // ==================== AI 单页生成（视觉模型增强） ====================

    private String generateSlideConfig(String section, String templateSlidesInfo,
                                        int slideIndex, int totalSlides, String slideImageUrl) {
        String pageType;
        if (slideIndex == 0) {
            pageType = "这是封面页，请选择 role 为 cover 的模板页";
        } else if (slideIndex == totalSlides - 1) {
            pageType = "这是结束页，请选择 role 为 ending 的模板页";
        } else {
            pageType = "这是正文页，请选择 role 为 content 或 section 的模板页";
        }

        String userMessage = String.format("""
                可用模板页结构：
                %s

                当前页类型提示：%s

                需要填充的大纲内容（第%d页，共%d页）：
                %s

                请输出该页的填充JSON：
                {"template_slide_index": <int>, "fills": [{"shape_id": <int>, "text": "..."}, ...]}
                """, templateSlidesInfo, pageType, slideIndex + 1, totalSlides, section);

        // 有截图时使用视觉模型，否则退化为纯文本模型
        if (slideImageUrl != null && !slideImageUrl.isBlank()) {
            return langchainChatService.chatWithImage(
                    PPT_SLIDE_VISION_MODEL, SLIDE_FILL_SYSTEM_PROMPT, userMessage, slideImageUrl);
        } else {
            return langchainChatService.chat(null, SLIDE_FILL_SYSTEM_PROMPT, userMessage);
        }
    }

    /**
     * 根据页面位置预判最合适的候选模板页索引（用于渲染截图给视觉模型）
     * @deprecated 已被 assignTemplateSlideIndexes 替代
     */
    @SuppressWarnings("unused")
    private int pickCandidateTemplateIndex(int slideIndex, int totalSlides,
                                            Map<String, List<Integer>> roleToIndexes,
                                            Map<Integer, JsonNode> templateSlideMap) {
        String targetRole;
        if (slideIndex == 0) {
            targetRole = "cover";
        } else if (slideIndex == totalSlides - 1) {
            targetRole = "ending";
        } else {
            targetRole = "content";
        }

        // 优先选择目标角色的模板页
        List<Integer> candidates = roleToIndexes.get(targetRole);
        if (candidates != null && !candidates.isEmpty()) {
            return candidates.get(0);
        }

        // content 不存在时尝试 section
        if ("content".equals(targetRole)) {
            candidates = roleToIndexes.get("section");
            if (candidates != null && !candidates.isEmpty()) {
                return candidates.get(0);
            }
        }

        // ending 不存在时尝试 content
        if ("ending".equals(targetRole)) {
            candidates = roleToIndexes.get("content");
            if (candidates != null && !candidates.isEmpty()) {
                return candidates.get(0);
            }
        }

        // 兜底：返回第一个模板页索引
        return templateSlideMap.keySet().stream().findFirst().orElse(0);
    }

    // ==================== 工具方法 ====================

    private PptGenerationSession getSessionAndVerify(Long sessionId, Long userId) {
        PptGenerationSession session = sessionRepository.findById(sessionId)
                .orElseThrow(() -> new BusinessException(40400, "会话不存在"));
        session.verifyOwner(userId);
        return session;
    }

    /**
     * 将 Markdown 大纲拆分为章节列表，每个章节对应一页 PPT。
     * 分割规则：每个 #、##、### 级标题都成为独立 section（= 一页幻灯片）。
     * - # 总标题 → 封面页
     * - ## 章节标题 → 章节过渡页
     * - ### 内容页标题 → 正文页
     */
    private List<String> parseOutlineToSections(String markdown) {
        List<String> sections = new ArrayList<>();
        StringBuilder current = new StringBuilder();

        for (String line : markdown.split("\n")) {
            String trimmed = line.trim();
            // #、##、### 级标题均作为新 section 的开始
            boolean isHeading = trimmed.startsWith("# ") || trimmed.startsWith("## ") || trimmed.startsWith("### ");
            if (isHeading && !current.isEmpty()) {
                sections.add(current.toString().trim());
                current = new StringBuilder();
            }
            current.append(line).append("\n");
        }
        if (!current.isEmpty()) {
            sections.add(current.toString().trim());
        }
        return sections;
    }

    /**
     * 根据大纲 section 内容推断其对应的模板角色，然后按顺序分配 template_slide_index。
     * 返回值: List<Integer>，每个元素是对应 section 的 template_slide_index。
     */
    private List<Integer> assignTemplateSlideIndexes(List<String> sections, TemplateAnalysis ta) {
        List<Integer> assignments = new ArrayList<>();

        // 各角色的可用索引队列（按模板中的顺序）
        Queue<Integer> coverQueue = new LinkedList<>(ta.roleToIndexes().getOrDefault("cover", List.of()));
        // toc 页面也加入 content 队列（可作为内容页使用）
        Queue<Integer> sectionQueue = new LinkedList<>(ta.roleToIndexes().getOrDefault("section", List.of()));
        Queue<Integer> contentQueue = new LinkedList<>(ta.roleToIndexes().getOrDefault("content", List.of()));
        Queue<Integer> endingQueue = new LinkedList<>(ta.roleToIndexes().getOrDefault("ending", List.of()));

        for (int i = 0; i < sections.size(); i++) {
            String section = sections.get(i).trim();
            String firstLine = section.split("\n")[0].trim();

            Integer assigned = null;

            if (firstLine.startsWith("# ") && !firstLine.startsWith("## ") && !firstLine.startsWith("### ")) {
                // # 总标题 → cover
                assigned = coverQueue.poll();
                if (assigned == null) assigned = contentQueue.poll();
            } else if (firstLine.startsWith("## ")) {
                // ## 章节标题
                boolean isEnding = i >= sections.size() - 2; // 最后1-2个 ## 视为结尾
                String lower = firstLine.toLowerCase();
                boolean looksLikeEnding = lower.contains("感谢") || lower.contains("总结")
                        || lower.contains("thank") || lower.contains("q&a") || lower.contains("结语");

                if ((isEnding || looksLikeEnding) && !endingQueue.isEmpty()) {
                    assigned = endingQueue.poll();
                } else {
                    assigned = sectionQueue.poll();
                    if (assigned == null) assigned = contentQueue.poll();
                }
            } else if (firstLine.startsWith("### ")) {
                // ### 内容页 → content
                assigned = contentQueue.poll();
            }

            // 兜底：用任何可用的 content 页，或用第一个模板页
            if (assigned == null) {
                assigned = contentQueue.poll();
            }
            if (assigned == null) {
                // 全部用完了，循环使用 content 页
                List<Integer> contentIndexes = ta.roleToIndexes().getOrDefault("content", List.of());
                if (!contentIndexes.isEmpty()) {
                    assigned = contentIndexes.get(i % contentIndexes.size());
                } else {
                    assigned = i % ta.totalPages();
                }
            }

            assignments.add(assigned);
        }

        return assignments;
    }

    // ==================== 模板分析中间结构 ====================

    /**
     * 模板分析结果：按角色分组的页面索引映射 + 统计信息
     * 作为中间量保存，供 PlannerAgent 和页面分配使用
     */
    record TemplateAnalysis(
            int totalPages,
            Map<String, List<Integer>> roleToIndexes,  // role → [index, index, ...]
            int coverCount, int tocCount, int sectionCount, int contentCount,
            int endingCount, int creditsCount
    ) {
        /** 可用于内容填充的 content 页数量 */
        int usableContentPages() { return contentCount; }
        /** 章节过渡页数量 */
        int chapterCount() { return sectionCount; }
    }

    /**
     * 解析模板 JSON 为 TemplateAnalysis 中间结构
     */
    private TemplateAnalysis analyzeTemplate(JsonNode templateRoot) {
        JsonNode slides = templateRoot.path("slides");
        Map<String, List<Integer>> roleToIndexes = new LinkedHashMap<>();
        int cover = 0, toc = 0, section = 0, content = 0, ending = 0, credits = 0;

        if (slides.isArray()) {
            for (JsonNode slide : slides) {
                int index = slide.path("index").asInt();
                String role = slide.path("role").asText("content");
                roleToIndexes.computeIfAbsent(role, k -> new ArrayList<>()).add(index);
                switch (role) {
                    case "cover" -> cover++;
                    case "toc" -> toc++;
                    case "section" -> section++;
                    case "content" -> content++;
                    case "ending" -> ending++;
                    case "credits" -> credits++;
                }
            }
        }

        return new TemplateAnalysis(
                templateRoot.path("slide_count").asInt(),
                roleToIndexes, cover, toc, section, content, ending, credits);
    }

    /**
     * 构建 PlannerAgent 的模板提示词（精准控制页数）
     * 不列出所有页面细节，而是给出明确的数量要求 + 结构规范
     */
    private String buildTemplatePlannerPrompt(TemplateAnalysis ta) {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format("## Template Page Structure (%d pages total)\n\n", ta.totalPages()));

        // List page distribution by role
        sb.append("Page role distribution:\n");
        if (ta.coverCount() > 0)
            sb.append(String.format("- Cover: %d page(s)\n", ta.coverCount()));
        if (ta.tocCount() > 0)
            sb.append(String.format("- Table of Contents: %d page(s)\n", ta.tocCount()));
        if (ta.sectionCount() > 0)
            sb.append(String.format("- Section Transition: %d page(s)\n", ta.sectionCount()));
        if (ta.contentCount() > 0)
            sb.append(String.format("- Body Content: %d page(s)\n", ta.contentCount()));
        if (ta.endingCount() > 0)
            sb.append(String.format("- Ending: %d page(s)\n", ta.endingCount()));
        if (ta.creditsCount() > 0)
            sb.append(String.format("- Credits: %d page(s) (auto-filled, no planning needed)\n", ta.creditsCount()));

        // Explicit outline structure requirements
        int effectiveContentPages = ta.usableContentPages();
        int chapters = ta.chapterCount();
        int pagesPerChapter = chapters > 0 ? effectiveContentPages / chapters : effectiveContentPages;

        sb.append(String.format("\n## Outline Structure Requirements (MUST follow strictly)\n\n"));
        sb.append(String.format("You MUST generate an outline with the following structure:\n"));
        sb.append(String.format("1. `# Main Title` — exactly 1, for the cover slide\n"));
        if (chapters > 0) {
            sb.append(String.format("2. `## Chapter Title` — exactly %d, each for a section transition slide\n", chapters));
            sb.append(String.format("3. `### Content Page Title` — approximately %d per ## chapter (total %d), each for a body content slide\n",
                    pagesPerChapter, effectiveContentPages));
        } else {
            sb.append(String.format("2. `### Content Page Title` — total %d, each for a body content slide\n", effectiveContentPages));
        }
        sb.append(String.format("4. The last `## Thank You / Summary` — for the ending slide\n\n"));

        sb.append("Under each ###, write 2-4 bullet points (using - list format).\n");
        sb.append("Do NOT annotate template_slide_index; the system assigns it automatically.\n");

        return sb.toString();
    }

    /**
     * 构建模板页结构摘要（精简版，供 PlannerAgent 规划大纲用）
     * @deprecated 使用 buildTemplatePlannerPrompt + TemplateAnalysis 代替
     */
    @SuppressWarnings("unused")
    private String buildTemplateSlideSummary(JsonNode templateRoot) {
        TemplateAnalysis ta = analyzeTemplate(templateRoot);
        return buildTemplatePlannerPrompt(ta);
    }

    /**
     * 构建模板页结构描述（详细版，供 ContentAgent 按 shape 精准填充用）
     * 包含每页的角色、布局名称、所有文本槽位（shape_id/role/是否可填充/示例文本/尺寸）和图片槽位
     */
    private String buildTemplateSlidesDescription(JsonNode templateRoot) {
        JsonNode slides = templateRoot.path("slides");
        if (!slides.isArray()) return "No template page info available";

        StringBuilder sb = new StringBuilder();
        sb.append("=== Template Structure Overview ===\n");
        sb.append(String.format("Total pages: %d, Slide dimensions: %dx%d EMU\n\n",
                templateRoot.path("slide_count").asInt(),
                templateRoot.path("slide_width").asInt(),
                templateRoot.path("slide_height").asInt()));

        for (JsonNode slide : slides) {
            int index = slide.path("index").asInt();
            String role = slide.path("role").asText("content");
            String layoutName = slide.path("layout_name").asText("");
            int fillableCount = slide.path("fillable_count").asInt(0);

            sb.append(String.format("┌── Template Page %d [role=%s, layout=\"%s\", fillable_slots=%d] ──┐\n",
                    index, role, layoutName, fillableCount));

            // 文本槽位详情
            JsonNode textSlots = slide.path("text_slots");
            if (textSlots.isArray() && !textSlots.isEmpty()) {
                sb.append("│ Text slots:\n");
                for (JsonNode slot : textSlots) {
                    int shapeId = slot.path("shape_id").asInt();
                    String slotRole = slot.path("role").asText("body");
                    boolean fillable = slot.path("is_fillable").asBoolean(false);
                    String sampleText = slot.path("sample_text").asText("");
                    int width = slot.path("width").asInt(0);
                    int height = slot.path("height").asInt(0);

                    // EMU → cm (1cm = 914400 EMU)
                    String sizeCm = String.format("%.1fcm x %.1fcm",
                            width / 914400.0, height / 914400.0);

                    sb.append(String.format("│   shape_id=%d, role=%s, fillable=%s, size=%s\n",
                            shapeId, slotRole, fillable ? "YES" : "no", sizeCm));
                    sb.append(String.format("│     sample: \"%s\"\n",
                            truncate(sampleText, 50)));

                    // Provide fill guidance per role
                    String hint = switch (slotRole) {
                        case "title" -> "→ Fill with the page title (concise, ≤15 chars)";
                        case "subtitle" -> "→ Fill with subtitle or supplementary text";
                        case "body" -> fillable
                                ? "→ Fillable area: use text for paragraph or items for bullet list"
                                : "→ Body area";
                        case "label" -> "→ Short label/number, usually keep original or use brief text";
                        case "section_number" -> "→ Chapter number (e.g. PART 01), usually keep as-is";
                        default -> "→ Fill as needed";
                    };
                    sb.append(String.format("│     %s\n", hint));
                }
            }

            // 图片槽位详情
            JsonNode imageSlots = slide.path("image_slots");
            if (imageSlots.isArray() && !imageSlots.isEmpty()) {
                sb.append("│ Image slots:\n");
                for (JsonNode imgSlot : imageSlots) {
                    int shapeId = imgSlot.path("shape_id").asInt();
                    String name = imgSlot.path("name").asText("");
                    int width = imgSlot.path("width").asInt(0);
                    int height = imgSlot.path("height").asInt(0);
                    String sizeCm = String.format("%.1fcm x %.1fcm",
                            width / 914400.0, height / 914400.0);
                    sb.append(String.format("│   shape_id=%d, name=\"%s\", size=%s\n",
                            shapeId, truncate(name, 20), sizeCm));
                    sb.append("│     → Can be replaced with AI-generated image via image_url\n");
                }
            }

            sb.append(String.format("└── End of Template Page %d ──┘\n\n", index));
        }

        // Usage rules summary
        sb.append("=== Usage Rules ===\n");
        sb.append("1. template_slide_index MUST be one of the template page indexes listed above\n");
        sb.append("2. shape_ids in fills MUST use only the shape_ids listed for that template page\n");
        sb.append("3. Cover → fill title+subtitle; Section → fill chapter title; ");
        sb.append("Content → fill title+bullet points; Ending → fill thank-you text\n");
        sb.append("4. Slots with is_fillable=YES are the primary fill targets\n");
        sb.append("5. Slots with role=label/section_number usually keep original text or minor tweaks\n");

        return sb.toString();
    }

    /**
     * 构建每页的模板描述 Map（pageIndex → 单页描述字符串）
     * 供 ContentAgent 按 shape 精准填充用，只包含指定页的详细信息
     */
    private Map<Integer, String> buildPerPageDescriptions(JsonNode templateRoot) {
        Map<Integer, String> result = new LinkedHashMap<>();
        JsonNode slides = templateRoot.path("slides");
        if (!slides.isArray()) return result;

        for (JsonNode slide : slides) {
            int index = slide.path("index").asInt();
            String role = slide.path("role").asText("content");
            String layoutName = slide.path("layout_name").asText("");
            int fillableCount = slide.path("fillable_count").asInt(0);

            StringBuilder sb = new StringBuilder();
            sb.append(String.format("Template Page %d [role=%s, layout=\"%s\", fillable_slots=%d]\n",
                    index, role, layoutName, fillableCount));

            JsonNode textSlots = slide.path("text_slots");
            if (textSlots.isArray() && !textSlots.isEmpty()) {
                sb.append("Text slots:\n");
                for (JsonNode slot : textSlots) {
                    int shapeId = slot.path("shape_id").asInt();
                    String slotRole = slot.path("role").asText("body");
                    boolean fillable = slot.path("is_fillable").asBoolean(false);
                    String sampleText = slot.path("sample_text").asText("");
                    sb.append(String.format("  shape_id=%d, role=%s, fillable=%s, sample=\"%s\"\n",
                            shapeId, slotRole, fillable ? "YES" : "no", truncate(sampleText, 40)));
                }
            }

            JsonNode imageSlots = slide.path("image_slots");
            if (imageSlots.isArray() && !imageSlots.isEmpty()) {
                sb.append("Image slots:\n");
                for (JsonNode imgSlot : imageSlots) {
                    int shapeId = imgSlot.path("shape_id").asInt();
                    String name = imgSlot.path("name").asText("");
                    sb.append(String.format("  shape_id=%d, name=\"%s\"\n",
                            shapeId, truncate(name, 20)));
                }
            }

            result.put(index, sb.toString());
        }
        return result;
    }

    /**
     * 将大纲 section 列表与模板页描述绑定，生成 enriched sections。
     * 每个 section 的文本后追加 [TEMPLATE_PAGE] 块，包含该页的 template_slide_index 和详细 shape 描述。
     */
    private List<String> enrichSectionsWithTemplateInfo(
            List<String> sections, List<Integer> templateIndexes, Map<Integer, String> pageDescriptions) {
        List<String> enriched = new ArrayList<>();
        for (int i = 0; i < sections.size(); i++) {
            String section = sections.get(i);
            int templateIdx = templateIndexes.get(i);
            String pageDesc = pageDescriptions.getOrDefault(templateIdx, "");

            StringBuilder sb = new StringBuilder(section);
            sb.append("\n\n[TEMPLATE_PAGE]\n");
            sb.append("template_slide_index=").append(templateIdx).append("\n");
            sb.append(pageDesc);
            sb.append("[/TEMPLATE_PAGE]\n");

            enriched.add(sb.toString());
        }
        return enriched;
    }

    private String extractTitle(String markdown) {
        for (String line : markdown.split("\n")) {
            String trimmed = line.trim();
            if (trimmed.startsWith("# ")) {
                return trimmed.substring(2).trim();
            }
        }
        return "演示文稿";
    }

    /**
     * 从 AI 输出中提取 JSON（可能包含 markdown 代码块标记）
     */
    private String extractJson(String text) {
        // 尝试提取 ```json ... ``` 块
        int start = text.indexOf("{");
        int end = text.lastIndexOf("}");
        if (start >= 0 && end > start) {
            return text.substring(start, end + 1);
        }
        return null;
    }

    /**
     * 解析 AI 生成的单页 JSON（容错处理 markdown 代码块等）
     */
    private Map<String, Object> parseSlideJson(String rawJson) {
        // 先尝试直接解析
        try {
            return objectMapper.readValue(rawJson, new TypeReference<>() {});
        } catch (JsonProcessingException ignored) {}

        // 尝试提取 JSON 块
        String extracted = extractJson(rawJson);
        if (extracted != null) {
            try {
                return objectMapper.readValue(extracted, new TypeReference<>() {});
            } catch (JsonProcessingException ignored) {}
        }
        return null;
    }

    private Map<String, Object> parseTemplateJsonForFrontend(
            String templateJson, String templateUrl,
            PptServiceClient.RenderSlidesResult renderResult) {
        try {
            JsonNode root = objectMapper.readTree(templateJson);
            Map<String, Object> result = new HashMap<>();
            result.put("slideCount", root.path("slide_count").asInt());
            result.put("templateUrl", templateUrl);

            // 返回完整的 slide 结构（含 text_slots / image_slots）供前端渲染
            List<Map<String, Object>> slideDetails = new ArrayList<>();
            JsonNode slides = root.path("slides");
            if (slides.isArray()) {
                for (JsonNode slide : slides) {
                    slideDetails.add(objectMapper.convertValue(
                            slide, new TypeReference<Map<String, Object>>() {}));
                }
            }
            result.put("slides", slideDetails);

            // 附带渲染的幻灯片图片 URL
            if (renderResult != null && renderResult.slideImages() != null) {
                List<Map<String, Object>> images = new ArrayList<>();
                for (PptServiceClient.SlideImage img : renderResult.slideImages()) {
                    images.add(Map.of("index", img.index(), "imageUrl", img.imageUrl()));
                }
                result.put("slideImages", images);
            }

            return result;
        } catch (Exception e) {
            return Map.of("raw", templateJson);
        }
    }

    private String truncate(String text, int maxLen) {
        if (text == null) return "";
        return text.length() > maxLen ? text.substring(0, maxLen) + "..." : text;
    }

    private Long toLong(Object value) {
        if (value == null) throw new BusinessException(40000, "缺少 sessionId");
        if (value instanceof Number n) return n.longValue();
        return Long.parseLong(value.toString());
    }

    // ==================== 会话管理 ====================

    public List<Map<String, Object>> listSessions(Long userId) {
        return sessionRepository.findByUserId(userId).stream().map(s -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", s.getId());
            map.put("topic", s.getTopic());
            map.put("state", s.getState().name());
            map.put("resultUrl", s.getResultUrl());
            map.put("createTime", s.getCreateTime());
            map.put("updateTime", s.getUpdateTime());
            return map;
        }).collect(java.util.stream.Collectors.toList());
    }

    public Map<String, Object> getSessionDetail(Long sessionId, Long userId) {
        PptGenerationSession session = getSessionAndVerify(sessionId, userId);
        Map<String, Object> map = new HashMap<>();
        map.put("id", session.getId());
        map.put("topic", session.getTopic());
        map.put("state", session.getState().name());
        map.put("outlineMarkdown", session.getOutlineMarkdown());
        map.put("templateId", session.getTemplateId());
        map.put("templateUrl", session.getTemplateUrl());
        map.put("templateJson", session.getTemplateJson());
        map.put("slidesJson", session.getSlidesJson());
        map.put("resultUrl", session.getResultUrl());
        map.put("createTime", session.getCreateTime());
        map.put("updateTime", session.getUpdateTime());
        return map;
    }

    public void deleteSession(Long sessionId, Long userId) {
        PptGenerationSession session = getSessionAndVerify(sessionId, userId);
        sessionRepository.deleteById(session.getId());
    }

    // ==================== SSE 工具方法 ====================

    /**
     * 创建 SseEmitter 并注册生命周期回调，返回 emitter 和 alive 标志
     */
    private record EmitterHolder(SseEmitter emitter, AtomicBoolean alive) {}

    private EmitterHolder createEmitter(long timeout) {
        SseEmitter emitter = new SseEmitter(timeout);
        AtomicBoolean alive = new AtomicBoolean(true);
        emitter.onCompletion(() -> alive.set(false));
        emitter.onError(e -> alive.set(false));
        emitter.onTimeout(() -> alive.set(false));
        return new EmitterHolder(emitter, alive);
    }

    private void sendEvent(SseEmitter emitter, AtomicBoolean alive, String name, Object data) throws IOException {
        if (!alive.get()) return;
        try {
            emitter.send(SseEmitter.event().name(name).data(data));
        } catch (IOException e) {
            alive.set(false);
            throw e;
        }
    }

    private void sendDone(SseEmitter emitter, AtomicBoolean alive) {
        if (!alive.get()) return;
        try {
            emitter.send(SseEmitter.event().name("done").data("[DONE]"));
            emitter.complete();
        } catch (IOException e) {
            alive.set(false);
            log.debug("客户端已断开，跳过 done 事件");
        }
    }

    private void handleError(SseEmitter emitter, AtomicBoolean alive, PptGenerationSession session, Exception e) {
        // 判断是否为客户端断开连接（Broken pipe），此类异常不应标记会话为失败
        boolean isClientDisconnect = isBrokenPipe(e);
        if (isClientDisconnect) {
            log.info("PPT生成：客户端已断开连接 (Broken pipe), sessionId={}", session.getId());
        } else {
            log.error("PPT生成异常: sessionId={}", session.getId(), e);
            session.failed();
            try {
                sessionRepository.save(session);
            } catch (Exception ex) {
                log.error("保存失败状态异常", ex);
            }
        }
        if (alive.get()) {
            try {
                emitter.send(SseEmitter.event().name("error").data(e.getMessage()));
            } catch (IOException ioException) {
                log.debug("客户端已断开，无法发送错误消息");
            }
            try {
                emitter.completeWithError(e);
            } catch (Exception ignored) {}
        }
        alive.set(false);
    }

    private boolean isBrokenPipe(Throwable e) {
        if (e == null) return false;
        String msg = e.getMessage();
        if (msg != null && msg.contains("Broken pipe")) return true;
        String className = e.getClass().getSimpleName();
        if ("AsyncRequestNotUsableException".equals(className)) return true;
        return isBrokenPipe(e.getCause());
    }

}
