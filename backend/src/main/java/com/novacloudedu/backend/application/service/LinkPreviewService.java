package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.common.ErrorCode;
import com.novacloudedu.backend.exception.BusinessException;
import lombok.Builder;
import lombok.RequiredArgsConstructor;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

import java.net.IDN;
import java.net.InetAddress;
import java.net.URI;
import java.time.Duration;
import java.util.Locale;

/**
 * 链接预览服务：服务端抓取页面元信息，避免前端 CORS 限制。
 */
@Service
@RequiredArgsConstructor
public class LinkPreviewService {

    private static final int MAX_REDIRECTS = 3;
    private static final int MAX_BODY_SIZE = 1024 * 1024;
    private static final int TIMEOUT_MS = (int) Duration.ofSeconds(5).toMillis();
    private static final String USER_AGENT = "Mozilla/5.0 NovaCloudEdu LinkPreviewBot";

    public LinkPreview fetch(String rawUrl) {
        URI startUri = normalizeUri(rawUrl);
        validatePublicHttpUri(startUri);

        try {
            URI currentUri = startUri;
            Connection.Response response = null;
            for (int i = 0; i <= MAX_REDIRECTS; i++) {
                response = Jsoup.connect(currentUri.toString())
                        .userAgent(USER_AGENT)
                        .timeout(TIMEOUT_MS)
                        .maxBodySize(MAX_BODY_SIZE)
                        .followRedirects(false)
                        .ignoreHttpErrors(true)
                        .execute();

                int status = response.statusCode();
                String location = response.header("Location");
                if (status >= 300 && status < 400 && location != null && !location.isBlank()) {
                    currentUri = currentUri.resolve(location);
                    validatePublicHttpUri(currentUri);
                    continue;
                }
                break;
            }

            if (response == null) {
                throw new BusinessException(ErrorCode.OPERATION_ERROR, "链接预览失败");
            }

            String contentType = response.contentType();
            if (contentType == null || !contentType.toLowerCase(Locale.ROOT).contains("text/html")) {
                return basicPreview(currentUri);
            }

            Document doc = response.parse();
            String title = firstNonBlank(
                    meta(doc, "meta[property=og:title]", "content"),
                    meta(doc, "meta[name=twitter:title]", "content"),
                    doc.title(),
                    currentUri.getHost()
            );
            String description = firstNonBlank(
                    meta(doc, "meta[property=og:description]", "content"),
                    meta(doc, "meta[name=description]", "content"),
                    meta(doc, "meta[name=twitter:description]", "content"),
                    ""
            );
            String imageUrl = firstNonBlank(
                    meta(doc, "meta[property=og:image]", "content"),
                    meta(doc, "meta[name=twitter:image]", "content"),
                    ""
            );
            String iconUrl = firstNonBlank(
                    attr(doc, "link[rel~=(?i)^(shortcut icon|icon|apple-touch-icon)$]", "href"),
                    ""
            );

            URI finalUri = currentUri;
            return LinkPreview.builder()
                    .url(finalUri.toString())
                    .siteName(firstNonBlank(meta(doc, "meta[property=og:site_name]", "content"), hostLabel(finalUri)))
                    .title(truncate(title, 160))
                    .description(truncate(description, 260))
                    .imageUrl(resolveUrl(finalUri, imageUrl))
                    .iconUrl(resolveUrl(finalUri, iconUrl))
                    .build();
        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            return basicPreview(startUri);
        }
    }

    private LinkPreview basicPreview(URI uri) {
        return LinkPreview.builder()
                .url(uri.toString())
                .siteName(hostLabel(uri))
                .title(hostLabel(uri))
                .description(uri.toString())
                .build();
    }

    private URI normalizeUri(String rawUrl) {
        if (rawUrl == null || rawUrl.isBlank()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "链接不能为空");
        }
        String value = rawUrl.trim();
        if (value.startsWith("www.")) {
            value = "https://" + value;
        }
        try {
            URI uri = URI.create(value);
            String scheme = uri.getScheme();
            String host = uri.getHost();
            if (scheme == null || host == null) {
                throw new IllegalArgumentException("invalid url");
            }
            return uri;
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "链接格式不正确");
        }
    }

    private void validatePublicHttpUri(URI uri) {
        String scheme = uri.getScheme();
        if (!"http".equalsIgnoreCase(scheme) && !"https".equalsIgnoreCase(scheme)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "仅支持 HTTP/HTTPS 链接");
        }
        String host = uri.getHost();
        if (host == null || host.isBlank()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "链接格式不正确");
        }
        try {
            String asciiHost = IDN.toASCII(host);
            InetAddress[] addresses = InetAddress.getAllByName(asciiHost);
            for (InetAddress address : addresses) {
                if (address.isAnyLocalAddress()
                        || address.isLoopbackAddress()
                        || address.isLinkLocalAddress()
                        || address.isSiteLocalAddress()
                        || address.isMulticastAddress()) {
                    throw new BusinessException(ErrorCode.PARAMS_ERROR, "不支持预览内网链接");
                }
            }
        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "链接域名不可解析");
        }
    }

    private String meta(Document doc, String selector, String attr) {
        return attr(doc, selector, attr);
    }

    private String attr(Document doc, String selector, String attr) {
        var element = doc.selectFirst(selector);
        if (element == null) return "";
        return element.attr(attr).trim();
    }

    private String resolveUrl(URI base, String value) {
        if (value == null || value.isBlank()) return null;
        try {
            return base.resolve(value.trim()).toString();
        } catch (Exception ignored) {
            return value;
        }
    }

    private String hostLabel(URI uri) {
        String host = uri.getHost();
        if (host == null || host.isBlank()) return "链接";
        return host.replaceFirst("^www\\.", "");
    }

    private String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) return value.trim();
        }
        return "";
    }

    private String truncate(String value, int maxLength) {
        if (value == null) return null;
        String trimmed = value.trim();
        if (trimmed.length() <= maxLength) return trimmed;
        return trimmed.substring(0, maxLength - 1) + "…";
    }

    @Builder
    public record LinkPreview(
            String url,
            String siteName,
            String title,
            String description,
            String imageUrl,
            String iconUrl
    ) {
    }
}
