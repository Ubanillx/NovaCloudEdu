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
import com.novacloudedu.backend.exception.BusinessException;
import com.novacloudedu.backend.infrastructure.ai.LangchainChatService;
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

                // 将模板结构信息喂给 AI
                if (session.getTemplateJson() != null && !session.getTemplateJson().isBlank()) {
                    JsonNode templateRoot = objectMapper.readTree(session.getTemplateJson());
                    String templateDesc = buildTemplateSlidesDescription(templateRoot);
                    userMessage.append("\n\n以下是PPT模板的页面结构，请根据此结构规划大纲：\n");
                    userMessage.append(templateDesc);
                    userMessage.append("\n\n模板完整JSON（供参考）：\n");
                    userMessage.append(session.getTemplateJson());
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
     */
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
     * 将 Markdown 大纲拆分为章节列表，每个章节对应一页 PPT
     */
    private List<String> parseOutlineToSections(String markdown) {
        List<String> sections = new ArrayList<>();
        StringBuilder current = new StringBuilder();

        for (String line : markdown.split("\n")) {
            String trimmed = line.trim();
            if ((trimmed.startsWith("# ") || trimmed.startsWith("## ")) && !current.isEmpty()) {
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
     * 构建模板页结构描述（供 AI 参考选择合适的模板页）
     */
    private String buildTemplateSlidesDescription(JsonNode templateRoot) {
        JsonNode slides = templateRoot.path("slides");
        if (!slides.isArray()) return "无模板页信息";

        StringBuilder sb = new StringBuilder();
        for (JsonNode slide : slides) {
            int index = slide.path("index").asInt();
            String role = slide.path("role").asText("content");
            sb.append(String.format("\n--- 模板第%d页 (role: %s) ---\n", index, role));

            JsonNode textSlots = slide.path("text_slots");
            if (textSlots.isArray()) {
                for (JsonNode slot : textSlots) {
                    sb.append(String.format("  文本槽位: shape_id=%d, role=%s, sample=\"%s\"\n",
                            slot.path("shape_id").asInt(),
                            slot.path("role").asText(),
                            truncate(slot.path("sample_text").asText(), 30)));
                }
            }
        }
        return sb.toString();
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
        log.error("PPT生成异常: sessionId={}", session.getId(), e);
        session.failed();
        try {
            sessionRepository.save(session);
        } catch (Exception ex) {
            log.error("保存失败状态异常", ex);
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

}
