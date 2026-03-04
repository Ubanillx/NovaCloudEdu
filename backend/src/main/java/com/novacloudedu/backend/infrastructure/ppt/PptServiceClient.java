package com.novacloudedu.backend.infrastructure.ppt;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

/**
 * PPT Python 服务 HTTP 客户端
 * 调用 ppt-service 的 /api/templates/parse 和 /api/generate 接口
 */
@Slf4j
@Service
public class PptServiceClient {

    @Value("${ppt-service.url:http://localhost:8100}")
    private String baseUrl;

    private final ObjectMapper objectMapper = new ObjectMapper();

    private final HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_1_1)
            .connectTimeout(Duration.ofSeconds(15))
            .followRedirects(HttpClient.Redirect.NORMAL)
            .build();

    /**
     * 解析模板：下载并解析 PPTX，返回结构 JSON + 封面 URL
     */
    public ParseTemplateResult parseTemplate(String templateUrl) {
        try {
            String body = objectMapper.writeValueAsString(
                    Map.of("template_url", templateUrl));

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/templates/parse"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(120))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            log.info("ppt-service 解析响应: status={}, body={}", response.statusCode(),
                    response.body().length() > 500 ? response.body().substring(0, 500) + "..." : response.body());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                String msg = json.path("message").asText("解析失败");
                throw new BusinessException(50000, "模板解析失败: " + msg);
            }

            return new ParseTemplateResult(
                    json.path("cover_url").asText(""),
                    json.path("slide_count").asInt(0),
                    response.body()
            );

        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            log.error("调用 ppt-service 解析模板失败", e);
            throw new BusinessException(50000, "调用PPT服务失败: " + e.getMessage());
        }
    }

    /**
     * 语义增强解析模板：下载 PPTX → 解析 → 渲染每页 PNG → 多模态视觉分析
     * 返回 EnrichedTemplateConfig JSON（语义字段 + data 原始数据）
     */
    public ParseEnrichedResult parseTemplateEnriched(String templateUrl) {
        try {
            String body = objectMapper.writeValueAsString(
                    Map.of("template_url", templateUrl));

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/templates/parse-enriched"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(300))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            log.info("ppt-service 语义增强解析响应: status={}, bodyLen={}",
                    response.statusCode(), response.body().length());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                String msg = json.path("message").asText("语义增强解析失败");
                throw new BusinessException(50000, "模板语义增强解析失败: " + msg);
            }

            // 提取 slide_images（每页的 preview_image_url）
            java.util.List<SlideImage> slideImages = new java.util.ArrayList<>();
            JsonNode slides = json.path("slides");
            if (slides.isArray()) {
                for (JsonNode slide : slides) {
                    int index = slide.path("index").asInt();
                    String imageUrl = slide.path("preview_image_url").asText("");
                    if (!imageUrl.isBlank()) {
                        slideImages.add(new SlideImage(index, imageUrl));
                    }
                }
            }

            return new ParseEnrichedResult(
                    json.path("cover_url").asText(""),
                    json.path("slide_count").asInt(0),
                    response.body(),
                    new RenderSlidesResult(slideImages)
            );

        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            log.error("调用 ppt-service 语义增强解析模板失败", e);
            throw new BusinessException(50000, "调用PPT服务失败: " + e.getMessage());
        }
    }

    /**
     * 生成 PPTX：基于模板 + 填充内容生成，返回 OSS URL
     */
    public GenerateResult generate(Map<String, Object> generateRequest) {
        try {
            String body = objectMapper.writeValueAsString(generateRequest);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/generate"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(180))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                String msg = json.path("message").asText("生成失败");
                throw new BusinessException(50000, "PPT生成失败: " + msg);
            }

            return new GenerateResult(
                    json.path("file_url").asText(""),
                    json.path("file_name").asText(""),
                    json.path("slide_count").asInt(0)
            );

        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            log.error("调用 ppt-service 生成PPT失败", e);
            throw new BusinessException(50000, "调用PPT服务失败: " + e.getMessage());
        }
    }

    /**
     * 渲染每页幻灯片为 PNG 图片，上传 OSS 返回 URL 列表
     */
    public RenderSlidesResult renderSlideImages(String templateUrl) {
        try {
            String body = objectMapper.writeValueAsString(
                    Map.of("template_url", templateUrl));

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/templates/render-slides"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(120))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                String msg = json.path("message").asText("渲染失败");
                throw new BusinessException(50000, "幻灯片渲染失败: " + msg);
            }

            JsonNode imagesNode = json.path("slide_images");
            java.util.List<SlideImage> images = new java.util.ArrayList<>();
            if (imagesNode.isArray()) {
                for (JsonNode item : imagesNode) {
                    images.add(new SlideImage(
                            item.path("index").asInt(),
                            item.path("image_url").asText("")
                    ));
                }
            }
            return new RenderSlidesResult(images);

        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            log.error("调用 ppt-service 渲染幻灯片失败", e);
            throw new BusinessException(50000, "调用PPT服务失败: " + e.getMessage());
        }
    }

    /**
     * 渲染模板指定单页为高清 PNG 图片，上传 OSS 返回 URL
     */
    public SingleSlideResult renderSingleSlide(String templateUrl, int slideIndex) {
        try {
            String body = objectMapper.writeValueAsString(
                    Map.of("template_url", templateUrl, "slide_index", slideIndex));

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/templates/render-slide"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(120))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                String msg = json.path("message").asText("渲染失败");
                throw new BusinessException(50000, "单页渲染失败: " + msg);
            }

            return new SingleSlideResult(json.path("image_url").asText(""));

        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            log.error("调用 ppt-service 渲染单页失败", e);
            throw new BusinessException(50000, "调用PPT服务失败: " + e.getMessage());
        }
    }

    /**
     * 生成单页预览图：克隆模板页 + 填充内容 + LibreOffice 渲染为 PNG，上传 OSS 返回 URL
     */
    public SlidePreviewResult generateSlidePreview(String templateUrl, Map<String, Object> slideConfig) {
        try {
            Map<String, Object> requestBody = Map.of(
                    "template_url", templateUrl,
                    "slide", slideConfig);
            String body = objectMapper.writeValueAsString(requestBody);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/generate-slide-preview"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(120))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                String msg = json.path("message").asText("预览渲染失败");
                throw new BusinessException(50000, "单页预览渲染失败: " + msg);
            }

            return new SlidePreviewResult(json.path("image_url").asText(""));

        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            log.error("调用 ppt-service 生成单页预览失败", e);
            throw new BusinessException(50000, "调用PPT服务失败: " + e.getMessage());
        }
    }

    /**
     * 校验单页填充内容是否匹配模板 shape 尺寸。
     * 借鉴 PPTAgent V1 的 _validate_content() 设计，在渲染前进行内容长度校验。
     *
     * @param templateUrl          模板 URL
     * @param slideIndex           幻灯片索引
     * @param templateSlideIndex   要克隆的模板页索引
     * @param fills                填充内容列表
     * @return 校验结果，包含问题列表和修改建议
     */
    public ContentValidationResult validateSlide(
            String templateUrl, int slideIndex, int templateSlideIndex,
            java.util.List<Map<String, Object>> fills) {
        try {
            Map<String, Object> requestBody = new java.util.HashMap<>();
            requestBody.put("template_url", templateUrl);
            requestBody.put("slide_index", slideIndex);
            requestBody.put("template_slide_index", templateSlideIndex);
            requestBody.put("fills", fills);

            String body = objectMapper.writeValueAsString(requestBody);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/validate-slide"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(30))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                log.warn("内容校验调用失败: {}", json.path("message").asText());
                return ContentValidationResult.valid();
            }

            boolean isValid = json.path("is_valid").asBoolean(true);
            String feedbackText = json.path("feedback_text").asText("");

            java.util.List<String> suggestions = new java.util.ArrayList<>();
            JsonNode suggestionsNode = json.path("suggestions");
            if (suggestionsNode.isArray()) {
                for (JsonNode s : suggestionsNode) {
                    suggestions.add(s.asText());
                }
            }

            return new ContentValidationResult(isValid, feedbackText, suggestions);

        } catch (Exception e) {
            log.warn("内容校验异常，跳过校验: {}", e.getMessage());
            return ContentValidationResult.valid();
        }
    }

    /**
     * HTML 模式：将 HTML 幻灯片列表转换为 PPTX 文件
     * Python 服务使用 Playwright 渲染 HTML → PNG，然后组装为 PPTX
     */
    public GenerateResult generateFromHtml(Map<String, Object> generateRequest) {
        try {
            String body = objectMapper.writeValueAsString(generateRequest);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/generate-html"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(300))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                String msg = json.path("message").asText("HTML PPT生成失败");
                throw new BusinessException(50000, "HTML PPT生成失败: " + msg);
            }

            return new GenerateResult(
                    json.path("file_url").asText(""),
                    json.path("file_name").asText(""),
                    json.path("slide_count").asInt(0)
            );

        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            log.error("调用 ppt-service HTML 生成失败", e);
            throw new BusinessException(50000, "调用PPT服务(HTML模式)失败: " + e.getMessage());
        }
    }

    /**
     * HTML 模式：渲染单页 HTML 幻灯片为 PNG 预览图
     */
    public SlidePreviewResult generateHtmlSlidePreview(String slideHtml) {
        return generateHtmlSlidePreview(slideHtml, null);
    }

    /**
     * HTML 模式：渲染单页 HTML 幻灯片为 PNG 预览图（支持配图 URL 兜底注入）
     */
    public SlidePreviewResult generateHtmlSlidePreview(String slideHtml, String generatedImageUrl) {
        try {
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("slide_html", slideHtml);
            if (generatedImageUrl != null && !generatedImageUrl.isBlank()) {
                requestBody.put("generated_image_url", generatedImageUrl);
            }
            String body = objectMapper.writeValueAsString(requestBody);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/generate-html-slide-preview"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(60))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                String msg = json.path("message").asText("HTML预览渲染失败");
                throw new BusinessException(50000, "HTML预览渲染失败: " + msg);
            }

            return new SlidePreviewResult(json.path("image_url").asText(""));

        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            log.error("调用 ppt-service HTML 预览渲染失败", e);
            throw new BusinessException(50000, "调用PPT服务(HTML预览)失败: " + e.getMessage());
        }
    }

    /**
     * 模板视觉分析：借鉴 PPTAgent V1 SlideInducter，
     * 对模板每页进行语义分析，输出版式分类、适合内容类型、空间分布等。
     *
     * @param templateUrl 模板 URL
     * @return 视觉分析结果，包含 agent 可读的文本描述
     */
    public TemplateVisionAnalysisResult analyzeTemplate(String templateUrl) {
        try {
            String body = objectMapper.writeValueAsString(
                    Map.of("template_url", templateUrl));

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(baseUrl + "/api/analyze-template"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .timeout(Duration.ofSeconds(60))
                    .build();

            HttpResponse<String> response = httpClient.send(
                    request, HttpResponse.BodyHandlers.ofString());

            JsonNode json = objectMapper.readTree(response.body());
            if (!json.path("success").asBoolean(false)) {
                log.warn("模板视觉分析调用失败: {}", json.path("message").asText());
                return TemplateVisionAnalysisResult.empty();
            }

            String agentDescription = json.path("agent_description").asText("");
            String profileJson = json.path("profile").toString();

            return new TemplateVisionAnalysisResult(agentDescription, profileJson);

        } catch (Exception e) {
            log.warn("模板视觉分析异常: {}", e.getMessage());
            return TemplateVisionAnalysisResult.empty();
        }
    }

    /**
     * 模板视觉分析结果
     */
    public record TemplateVisionAnalysisResult(
            String agentDescription,
            String profileJson
    ) {
        public static TemplateVisionAnalysisResult empty() {
            return new TemplateVisionAnalysisResult("", "{}");
        }

        public boolean hasContent() {
            return agentDescription != null && !agentDescription.isBlank();
        }
    }

    /**
     * 内容校验结果
     */
    public record ContentValidationResult(
            boolean isValid,
            String feedbackText,
            java.util.List<String> suggestions
    ) {
        public static ContentValidationResult valid() {
            return new ContentValidationResult(true, "", java.util.List.of());
        }
    }

    /**
     * 单页预览渲染结果
     */
    public record SlidePreviewResult(
            String imageUrl
    ) {}

    /**
     * 单页渲染结果
     */
    public record SingleSlideResult(
            String imageUrl
    ) {}

    /**
     * 模板解析结果
     */
    public record ParseTemplateResult(
            String coverUrl,
            int slideCount,
            String fullResponseJson
    ) {}

    /**
     * 语义增强模板解析结果
     */
    public record ParseEnrichedResult(
            String coverUrl,
            int slideCount,
            String fullResponseJson,
            RenderSlidesResult renderResult
    ) {}

    /**
     * PPT生成结果
     */
    public record GenerateResult(
            String fileUrl,
            String fileName,
            int slideCount
    ) {}

    /**
     * 单页幻灯片图片
     */
    public record SlideImage(
            int index,
            String imageUrl
    ) {}

    /**
     * 幻灯片渲染结果
     */
    public record RenderSlidesResult(
            java.util.List<SlideImage> slideImages
    ) {}
}
