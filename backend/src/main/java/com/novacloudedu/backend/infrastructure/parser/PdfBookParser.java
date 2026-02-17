package com.novacloudedu.backend.infrastructure.parser;

import com.novacloudedu.backend.domain.book.service.BookParser;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentInformation;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class PdfBookParser implements BookParser {

    private static final Pattern CHAPTER_PATTERN = Pattern.compile(
            "^第[0-9一二三四五六七八九十百千零]+[章节回集部].*$|^Chapter\\s+\\d+.*$",
            Pattern.CASE_INSENSITIVE
    );

    @Override
    public boolean supports(FileType fileType) {
        return fileType == FileType.PDF;
    }

    @Override
    public ParsedBook parse(String fileUrl) {
        try {
            java.io.File file;
            Path tempFile = null;

            if (fileUrl.startsWith("http://") || fileUrl.startsWith("https://")) {
                tempFile = Files.createTempFile("book_pdf_", ".pdf");
                try (InputStream in = URI.create(fileUrl).toURL().openStream()) {
                    Files.copy(in, tempFile, StandardCopyOption.REPLACE_EXISTING);
                }
                file = tempFile.toFile();
            } else {
                String filePath = fileUrl;
                if (filePath.startsWith("file://")) {
                    filePath = filePath.substring(7);
                }
                file = new java.io.File(filePath);
            }

            try (PDDocument document = org.apache.pdfbox.Loader.loadPDF(file)) {
                return parsePdfDocument(document);
            } finally {
                if (tempFile != null) {
                    Files.deleteIfExists(tempFile);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("PDF文件解析失败: " + e.getMessage(), e);
        }
    }

    private ParsedBook parsePdfDocument(PDDocument document) throws Exception {
        PDDocumentInformation info = document.getDocumentInformation();
        String title = info.getTitle();
        String author = info.getAuthor();
        
        if (title == null || title.trim().isEmpty()) {
            title = "未命名PDF文档";
        }
        if (author == null || author.trim().isEmpty()) {
            author = "未知作者";
        }
        
        PDFTextStripper stripper = new PDFTextStripper();
        String fullText = stripper.getText(document);
        
        List<ParsedBook.ParsedChapter> chapters = parseChapters(fullText);
        
        return ParsedBook.builder()
                .title(title)
                .author(author)
                .coverUrl(null)
                .chapters(chapters)
                .build();
    }

    private List<ParsedBook.ParsedChapter> parseChapters(String text) {
        List<ParsedBook.ParsedChapter> chapters = new ArrayList<>();
        String[] lines = text.split("\n");
        
        StringBuilder currentChapterContent = new StringBuilder();
        String currentChapterTitle = "序章";
        int chapterIndex = 0;
        
        for (String line : lines) {
            line = line.trim();
            
            if (line.isEmpty()) continue;
            
            Matcher matcher = CHAPTER_PATTERN.matcher(line);
            if (matcher.matches()) {
                if (currentChapterContent.length() > 0) {
                    chapters.add(ParsedBook.ParsedChapter.builder()
                            .title(currentChapterTitle)
                            .chapterIndex(chapterIndex++)
                            .content(wrapInHtml(currentChapterContent.toString()))
                            .build());
                    currentChapterContent = new StringBuilder();
                }
                currentChapterTitle = line;
            } else {
                currentChapterContent.append("<p>")
                        .append(escapeHtml(line))
                        .append("</p>\n");
            }
        }
        
        if (currentChapterContent.length() > 0) {
            chapters.add(ParsedBook.ParsedChapter.builder()
                    .title(currentChapterTitle)
                    .chapterIndex(chapterIndex)
                    .content(wrapInHtml(currentChapterContent.toString()))
                    .build());
        }
        
        if (chapters.isEmpty()) {
            chapters.add(ParsedBook.ParsedChapter.builder()
                    .title("全文")
                    .chapterIndex(0)
                    .content(wrapInHtml("<p>" + escapeHtml(text) + "</p>"))
                    .build());
        }
        
        return chapters;
    }

    private String wrapInHtml(String content) {
        return "<div class=\"chapter-content\">\n" + content + "</div>";
    }

    private String escapeHtml(String text) {
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
