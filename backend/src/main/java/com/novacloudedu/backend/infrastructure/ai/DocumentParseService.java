package com.novacloudedu.backend.infrastructure.ai;

import lombok.Builder;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentInformation;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URI;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * 文档解析服务 - 从URL下载文档并提取文字内容与元信息
 * 
 * 支持格式：PDF、DOCX、TXT、MD、HTML
 */
@Slf4j
@Service
public class DocumentParseService {

    /** 文档内容最大字符数限制（防止过长内容撑爆上下文） */
    private static final int MAX_CONTENT_LENGTH = 180000;

    /**
     * 解析文档并返回结构化结果
     */
    public ParsedDocument parseFromUrl(String documentUrl) {
        log.info("开始解析文档: {}", documentUrl);

        try {
            String fileName = extractFileName(documentUrl);
            String extension = extractExtension(fileName).toLowerCase();

            byte[] fileBytes = downloadFile(documentUrl);
            log.info("文档下载完成: {}, 大小: {}KB", fileName, fileBytes.length / 1024);

            String textContent;
            DocumentType docType;
            String title = fileName;
            String author = null;
            int pageCount = 0;

            switch (extension) {
                case "pdf":
                    docType = DocumentType.PDF;
                    PdfResult pdfResult = parsePdf(fileBytes);
                    textContent = pdfResult.content;
                    if (pdfResult.title != null && !pdfResult.title.isBlank()) title = pdfResult.title;
                    author = pdfResult.author;
                    pageCount = pdfResult.pageCount;
                    break;
                case "docx":
                    docType = DocumentType.DOCX;
                    DocxResult docxResult = parseDocx(fileBytes);
                    textContent = docxResult.content;
                    if (docxResult.title != null && !docxResult.title.isBlank()) title = docxResult.title;
                    author = docxResult.author;
                    break;
                case "doc":
                    docType = DocumentType.DOC;
                    textContent = "[暂不支持旧版 .doc 格式，请转换为 .docx]";
                    break;
                case "txt":
                case "md":
                case "csv":
                case "json":
                case "xml":
                case "yaml":
                case "yml":
                case "log":
                    docType = DocumentType.TEXT;
                    textContent = new String(fileBytes, StandardCharsets.UTF_8);
                    break;
                case "html":
                case "htm":
                    docType = DocumentType.HTML;
                    textContent = parseHtml(fileBytes);
                    break;
                default:
                    docType = DocumentType.UNKNOWN;
                    textContent = "[不支持的文档格式: " + extension + "]";
                    break;
            }

            // 截断过长内容
            boolean truncated = false;
            if (textContent.length() > MAX_CONTENT_LENGTH) {
                textContent = textContent.substring(0, MAX_CONTENT_LENGTH);
                truncated = true;
            }

            log.info("文档解析完成: {}, 类型: {}, 文字长度: {}, 截断: {}",
                    fileName, docType, textContent.length(), truncated);

            return ParsedDocument.builder()
                    .fileName(fileName)
                    .documentType(docType)
                    .title(title)
                    .author(author)
                    .pageCount(pageCount)
                    .fileSizeBytes(fileBytes.length)
                    .textContent(textContent)
                    .truncated(truncated)
                    .sourceUrl(documentUrl)
                    .build();

        } catch (Exception e) {
            log.error("文档解析失败: {}", documentUrl, e);
            String fileName = extractFileName(documentUrl);
            return ParsedDocument.builder()
                    .fileName(fileName)
                    .documentType(DocumentType.UNKNOWN)
                    .title(fileName)
                    .textContent("[文档解析失败: " + e.getMessage() + "]")
                    .sourceUrl(documentUrl)
                    .truncated(false)
                    .build();
        }
    }

    /**
     * 将多个已解析文档格式化为 AI 上下文字符串（含元信息）
     */
    public String formatForAiContext(List<ParsedDocument> documents) {
        if (documents == null || documents.isEmpty()) return null;

        StringBuilder sb = new StringBuilder();
        sb.append("用户上传了以下文档，请结合文档内容回答问题：\n\n");

        for (int i = 0; i < documents.size(); i++) {
            ParsedDocument doc = documents.get(i);
            sb.append("--- 文档 ").append(i + 1).append(" ---\n");
            sb.append("文件名: ").append(doc.getFileName()).append("\n");
            sb.append("格式: ").append(doc.getDocumentType().getLabel()).append("\n");
            if (doc.getTitle() != null && !doc.getTitle().equals(doc.getFileName())) {
                sb.append("标题: ").append(doc.getTitle()).append("\n");
            }
            if (doc.getAuthor() != null && !doc.getAuthor().isBlank()) {
                sb.append("作者: ").append(doc.getAuthor()).append("\n");
            }
            if (doc.getPageCount() > 0) {
                sb.append("页数: ").append(doc.getPageCount()).append("\n");
            }
            sb.append("大小: ").append(formatFileSize(doc.getFileSizeBytes())).append("\n");
            if (doc.isTruncated()) {
                sb.append("（内容过长，已截取前").append(MAX_CONTENT_LENGTH).append("字）\n");
            }
            sb.append("\n文档内容:\n").append(doc.getTextContent()).append("\n\n");
        }

        return sb.toString();
    }

    // ==================== PDF 解析 ====================

    private PdfResult parsePdf(byte[] bytes) throws Exception {
        try (PDDocument document = Loader.loadPDF(bytes)) {
            PDDocumentInformation info = document.getDocumentInformation();
            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(document);

            return new PdfResult(
                    cleanText(text),
                    info.getTitle(),
                    info.getAuthor(),
                    document.getNumberOfPages()
            );
        }
    }

    private static class PdfResult {
        final String content;
        final String title;
        final String author;
        final int pageCount;

        PdfResult(String content, String title, String author, int pageCount) {
            this.content = content;
            this.title = title;
            this.author = author;
            this.pageCount = pageCount;
        }
    }

    // ==================== DOCX 解析 ====================

    private DocxResult parseDocx(byte[] bytes) throws Exception {
        try (InputStream is = new java.io.ByteArrayInputStream(bytes);
             XWPFDocument document = new XWPFDocument(is)) {

            String title = null;
            String author = null;
            if (document.getProperties() != null && document.getProperties().getCoreProperties() != null) {
                title = document.getProperties().getCoreProperties().getTitle();
                author = document.getProperties().getCoreProperties().getCreator();
            }

            StringBuilder sb = new StringBuilder();
            for (IBodyElement element : document.getBodyElements()) {
                if (element instanceof XWPFParagraph) {
                    XWPFParagraph para = (XWPFParagraph) element;
                    String text = para.getText().trim();
                    if (!text.isEmpty()) {
                        sb.append(text).append("\n");
                    }
                } else if (element instanceof XWPFTable) {
                    XWPFTable table = (XWPFTable) element;
                    for (XWPFTableRow row : table.getRows()) {
                        List<String> cells = new ArrayList<>();
                        for (XWPFTableCell cell : row.getTableCells()) {
                            cells.add(cell.getText().trim());
                        }
                        sb.append("| ").append(String.join(" | ", cells)).append(" |\n");
                    }
                    sb.append("\n");
                }
            }

            return new DocxResult(cleanText(sb.toString()), title, author);
        }
    }

    private static class DocxResult {
        final String content;
        final String title;
        final String author;

        DocxResult(String content, String title, String author) {
            this.content = content;
            this.title = title;
            this.author = author;
        }
    }

    // ==================== HTML 解析 ====================

    private String parseHtml(byte[] bytes) {
        try {
            org.jsoup.nodes.Document doc = org.jsoup.Jsoup.parse(new String(bytes, StandardCharsets.UTF_8));
            return cleanText(doc.text());
        } catch (Exception e) {
            return new String(bytes, StandardCharsets.UTF_8);
        }
    }

    // ==================== 工具方法 ====================

    private byte[] downloadFile(String url) throws Exception {
        URLConnection conn = URI.create(url).toURL().openConnection();
        conn.setConnectTimeout(15000);
        conn.setReadTimeout(60000);

        try (InputStream is = conn.getInputStream();
             ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
            byte[] buffer = new byte[8192];
            int len;
            while ((len = is.read(buffer)) != -1) {
                bos.write(buffer, 0, len);
            }
            return bos.toByteArray();
        }
    }

    private String extractFileName(String url) {
        String path = url;
        // 去掉查询参数
        int queryIndex = path.indexOf('?');
        if (queryIndex > 0) path = path.substring(0, queryIndex);
        // 取最后一段
        int lastSlash = path.lastIndexOf('/');
        if (lastSlash >= 0) path = path.substring(lastSlash + 1);
        // URL解码
        try {
            path = java.net.URLDecoder.decode(path, StandardCharsets.UTF_8);
        } catch (Exception ignored) {}
        return path.isEmpty() ? "unknown" : path;
    }

    private String extractExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        return dotIndex >= 0 ? fileName.substring(dotIndex + 1) : "";
    }

    private String cleanText(String text) {
        if (text == null) return "";
        // 合并多个连续空行为一个
        return text.replaceAll("\\n{3,}", "\n\n").trim();
    }

    private String formatFileSize(long bytes) {
        if (bytes < 1024) return bytes + "B";
        if (bytes < 1024 * 1024) return String.format("%.1fKB", bytes / 1024.0);
        return String.format("%.1fMB", bytes / (1024.0 * 1024));
    }

    // ==================== 数据模型 ====================

    public enum DocumentType {
        PDF("PDF文档"),
        DOCX("Word文档"),
        DOC("Word文档(旧版)"),
        TEXT("纯文本"),
        HTML("网页"),
        UNKNOWN("未知格式");

        @Getter
        private final String label;

        DocumentType(String label) {
            this.label = label;
        }
    }

    @Getter
    @Builder
    public static class ParsedDocument {
        private String fileName;
        private DocumentType documentType;
        private String title;
        private String author;
        private int pageCount;
        private long fileSizeBytes;
        private String textContent;
        private boolean truncated;
        private String sourceUrl;
    }
}
