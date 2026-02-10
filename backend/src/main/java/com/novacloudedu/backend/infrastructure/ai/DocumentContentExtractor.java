package com.novacloudedu.backend.infrastructure.ai;

import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * 文档内容提取服务
 * 支持从 URL 下载文件并提取文本内容
 * 支持格式：PDF, DOCX, TXT, MD, HTML, EPUB
 */
@Slf4j
@Service
public class DocumentContentExtractor {

    private final HttpClient httpClient;

    public DocumentContentExtractor() {
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(30))
                .followRedirects(HttpClient.Redirect.NORMAL)
                .build();
    }

    /**
     * 从文件 URL 提取文本内容
     *
     * @param fileUrl  文件下载地址
     * @param fileType 文件类型（PDF, DOCX, TXT, MD, HTML, EPUB）
     * @return 提取的文本内容
     */
    public String extractContent(String fileUrl, String fileType) {
        if (fileUrl == null || fileUrl.trim().isEmpty()) {
            throw new IllegalArgumentException("文件 URL 不能为空");
        }

        log.info("开始提取文档内容: fileType={}, url={}", fileType, fileUrl);

        try {
            byte[] fileBytes = downloadFile(fileUrl);
            log.info("文件下载完成: {} bytes", fileBytes.length);

            String content = switch (fileType.toUpperCase()) {
                case "PDF" -> extractFromPdf(fileBytes);
                case "DOCX", "DOC" -> extractFromDocx(fileBytes);
                case "TXT", "MD", "HTML" -> new String(fileBytes, "UTF-8");
                case "EPUB" -> extractFromEpub(fileBytes);
                default -> throw new IllegalArgumentException("不支持的文件类型: " + fileType);
            };

            if (content == null || content.trim().isEmpty()) {
                throw new IllegalStateException("提取的文档内容为空");
            }

            // 清理 null 字节（0x00），PostgreSQL text 类型不接受
            content = content.replace("\u0000", "");

            log.info("文档内容提取完成: 长度={}", content.length());
            return content.trim();

        } catch (Exception e) {
            log.error("文档内容提取失败: fileType={}, url={}", fileType, fileUrl, e);
            throw new RuntimeException("文档内容提取失败: " + e.getMessage(), e);
        }
    }

    /**
     * 下载文件
     */
    private byte[] downloadFile(String fileUrl) throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(fileUrl))
                .timeout(Duration.ofSeconds(60))
                .GET()
                .build();

        HttpResponse<byte[]> response = httpClient.send(request, HttpResponse.BodyHandlers.ofByteArray());

        if (response.statusCode() != 200) {
            throw new IOException("文件下载失败, HTTP状态码: " + response.statusCode());
        }

        return response.body();
    }

    /**
     * 从 PDF 提取文本
     */
    private String extractFromPdf(byte[] fileBytes) throws IOException {
        try (PDDocument document = Loader.loadPDF(fileBytes)) {
            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(document);
            log.info("PDF 解析完成: 页数={}, 文本长度={}", document.getNumberOfPages(), text.length());
            return text;
        }
    }

    /**
     * 从 DOCX 提取文本
     */
    private String extractFromDocx(byte[] fileBytes) throws IOException {
        try (InputStream is = new ByteArrayInputStream(fileBytes);
             XWPFDocument document = new XWPFDocument(is)) {
            StringBuilder sb = new StringBuilder();
            for (XWPFParagraph paragraph : document.getParagraphs()) {
                String text = paragraph.getText();
                if (text != null && !text.trim().isEmpty()) {
                    sb.append(text).append("\n");
                }
            }
            log.info("DOCX 解析完成: 段落数={}, 文本长度={}", document.getParagraphs().size(), sb.length());
            return sb.toString();
        }
    }

    /**
     * 从 EPUB 提取文本
     */
    private String extractFromEpub(byte[] fileBytes) throws IOException {
        try (InputStream is = new ByteArrayInputStream(fileBytes)) {
            nl.siegmann.epublib.epub.EpubReader epubReader = new nl.siegmann.epublib.epub.EpubReader();
            nl.siegmann.epublib.domain.Book book = epubReader.readEpub(is);

            StringBuilder sb = new StringBuilder();
            for (nl.siegmann.epublib.domain.Resource resource : book.getContents()) {
                String content = new String(resource.getData(), resource.getInputEncoding());
                // 去除 HTML 标签
                String plainText = content.replaceAll("<[^>]+>", " ")
                        .replaceAll("\\s+", " ")
                        .trim();
                if (!plainText.isEmpty()) {
                    sb.append(plainText).append("\n\n");
                }
            }
            log.info("EPUB 解析完成: 章节数={}, 文本长度={}", book.getContents().size(), sb.length());
            return sb.toString();
        }
    }
}
