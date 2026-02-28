package com.novacloudedu.backend.infrastructure.ai.agent;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.agent.tool.P;
import dev.langchain4j.agent.tool.Tool;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import com.novacloudedu.backend.infrastructure.ai.ImageGenerationService;
import com.novacloudedu.backend.infrastructure.ai.ImageGenerationService.ImageResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 图片工具 — 供 DesignAgent 自主调用
 *
 * 提供两种图片获取方式：
 * 1. searchWebImage   — 从互联网搜索真实图片（产品照、实物图、风景照等）
 * 2. generateSlideImage — 用 AI 文生图创建插画/概念图
 *
 * 搜到/生成的图片均自动上传到 OSS 并返回持久化 URL。
 */
@Slf4j
@Component
public class ImageGenerationTool {

    private final ImageGenerationService imageGenerationService;
    private final OssService ossService;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${ppt.agent.image-search.provider:bing}")
    private String imageSearchProvider;

    @Value("${ppt.agent.image-search.api-key:}")
    private String imageSearchApiKey;

    @Value("${ppt.agent.image-search.enabled:false}")
    private boolean imageSearchEnabled;

    public ImageGenerationTool(ImageGenerationService imageGenerationService, OssService ossService) {
        this.imageGenerationService = imageGenerationService;
        this.ossService = ossService;
    }

    // ==================== Web Image Search ====================

    @Tool("Search the web for a real photograph or image matching the query. " +
          "Best for: real-world subjects (products, people, buildings, nature, logos). " +
          "Returns an OSS URL of the downloaded image, or an error message if not found.")
    public String searchWebImage(
            @P("Image search query in English, e.g. 'Xiaomi SU7 Ultra electric car'") String query) {

        log.info("Agent searchWebImage: query={}", query);

        if (!imageSearchEnabled || imageSearchApiKey == null || imageSearchApiKey.isBlank()) {
            return "Web image search is not configured. Use generateSlideImage instead.";
        }

        try {
            String imageUrl = switch (imageSearchProvider.toLowerCase()) {
                case "bing" -> searchBingImages(query);
                case "google" -> searchGoogleImages(query);
                default -> null;
            };

            if (imageUrl == null || imageUrl.isBlank()) {
                return "No suitable image found for: " + query;
            }

            // Download and upload to OSS for persistence
            String ossUrl = downloadAndUploadToOss(imageUrl);
            log.info("Web image search success: query={}, ossUrl={}", query, ossUrl);
            return ossUrl;

        } catch (Exception e) {
            log.warn("Web image search failed: query={}, error={}", query, e.getMessage());
            return "Search failed: " + e.getMessage();
        }
    }

    // ==================== AI Image Generation ====================

    @Tool("Generate an AI illustration from a text description. " +
          "Best for: abstract concepts, diagrams, artistic illustrations, icons. " +
          "Returns an OSS URL. Use English prompts for best results.")
    public String generateImage(
            @P("Image description in English, e.g. 'A futuristic classroom with holographic displays, minimal flat design, 16:9'") String prompt) {

        log.info("Agent generateImage: prompt={}", prompt);

        if (!imageGenerationService.isEnabled()) {
            return "Image generation is not enabled";
        }

        try {
            ImageResult result = imageGenerationService.generateImage(prompt);
            if (result.success()) {
                log.info("Image generated: url={}", result.imageUrl());
                return result.imageUrl();
            } else {
                log.warn("Image generation failed: {}", result.errorMessage());
                return "Generation failed: " + result.errorMessage();
            }
        } catch (Exception e) {
            log.error("Image generation error: prompt={}", prompt, e);
            return "Generation error: " + e.getMessage();
        }
    }

    @Tool("Generate an AI illustration optimized for a PPT slide. " +
          "Automatically adds professional style keywords. " +
          "Best for: abstract/conceptual topics where no real photo exists.")
    public String generateSlideImage(
            @P("Slide topic, e.g. 'AI in education'") String slideTopic,
            @P("Style description, e.g. 'professional, modern, flat design'") String style) {

        log.info("Agent generateSlideImage: topic={}, style={}", slideTopic, style);

        String optimizedPrompt = String.format(
                "%s, %s, presentation slide illustration, " +
                "clean background, high quality, 16:9 aspect ratio, " +
                "professional business style, no text overlay",
                slideTopic, style != null ? style : "modern minimalist");

        return generateImage(optimizedPrompt);
    }

    // ==================== Bing Image Search ====================

    private String searchBingImages(String query) {
        String encoded = URLEncoder.encode(query, StandardCharsets.UTF_8);
        String url = "https://api.bing.microsoft.com/v7.0/images/search"
                + "?q=" + encoded
                + "&count=3&mkt=en-US&safeSearch=Strict"
                + "&aspect=Wide&imageType=Photo";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Ocp-Apim-Subscription-Key", imageSearchApiKey);

        ResponseEntity<String> resp = restTemplate.exchange(
                url, HttpMethod.GET, new HttpEntity<>(headers), String.class);

        if (resp.getStatusCode().is2xxSuccessful() && resp.getBody() != null) {
            JsonNode root = parseJsonSafe(resp.getBody());
            if (root != null && root.has("value")) {
                for (JsonNode img : root.path("value")) {
                    String contentUrl = img.path("contentUrl").asText(null);
                    if (contentUrl != null && !contentUrl.isBlank()) {
                        return contentUrl;
                    }
                }
            }
        }
        return null;
    }

    // ==================== Google Custom Search ====================

    private String searchGoogleImages(String query) {
        // Google Custom Search requires both API key and CX (search engine ID)
        // Format: api-key:cx  (stored together in imageSearchApiKey)
        String[] parts = imageSearchApiKey.split(":", 2);
        if (parts.length < 2) {
            log.warn("Google image search requires api-key:cx format");
            return null;
        }
        String apiKey = parts[0];
        String cx = parts[1];

        String encoded = URLEncoder.encode(query, StandardCharsets.UTF_8);
        String url = "https://www.googleapis.com/customsearch/v1"
                + "?q=" + encoded
                + "&key=" + apiKey
                + "&cx=" + cx
                + "&searchType=image&num=3&imgSize=large&imgType=photo";

        ResponseEntity<String> resp = restTemplate.getForEntity(url, String.class);
        if (resp.getStatusCode().is2xxSuccessful() && resp.getBody() != null) {
            JsonNode root = parseJsonSafe(resp.getBody());
            if (root != null && root.has("items")) {
                for (JsonNode item : root.path("items")) {
                    String link = item.path("link").asText(null);
                    if (link != null && !link.isBlank()) {
                        return link;
                    }
                }
            }
        }
        return null;
    }

    // ==================== Utils ====================

    private String downloadAndUploadToOss(String imageUrl) {
        try {
            byte[] imageBytes = new java.net.URI(imageUrl).toURL().openStream().readAllBytes();
            if (imageBytes.length < 1024) {
                throw new RuntimeException("Downloaded image too small (" + imageBytes.length + " bytes)");
            }
            String ext = ".jpg";
            if (imageUrl.contains(".png")) ext = ".png";
            else if (imageUrl.contains(".webp")) ext = ".webp";
            return ossService.uploadBytes(imageBytes, ext, FileBusinessType.AI_GENERATED_IMAGE);
        } catch (Exception e) {
            throw new RuntimeException("Failed to download/upload image: " + e.getMessage(), e);
        }
    }

    private JsonNode parseJsonSafe(String json) {
        try {
            return objectMapper.readTree(json);
        } catch (Exception e) {
            return null;
        }
    }
}
