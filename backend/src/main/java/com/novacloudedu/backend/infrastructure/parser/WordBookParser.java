package com.novacloudedu.backend.infrastructure.parser;

import com.novacloudedu.backend.domain.book.service.BookParser;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.stereotype.Component;

import java.io.IOException;
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
public class WordBookParser implements BookParser {

    private static final Pattern CHAPTER_PATTERN = Pattern.compile(
            "^第[0-9一二三四五六七八九十百千零]+[章节回集部].*$|^Chapter\\s+\\d+.*$",
            Pattern.CASE_INSENSITIVE
    );

    @Override
    public boolean supports(FileType fileType) {
        return fileType == FileType.DOCX;
    }

    @Override
    public ParsedBook parse(String fileUrl) {
        Path tempFile = null;
        try {
            InputStream is;

            if (fileUrl.startsWith("http://") || fileUrl.startsWith("https://")) {
                tempFile = Files.createTempFile("book_docx_", ".docx");
                try (InputStream in = URI.create(fileUrl).toURL().openStream()) {
                    Files.copy(in, tempFile, StandardCopyOption.REPLACE_EXISTING);
                }
                is = Files.newInputStream(tempFile);
            } else {
                String filePath = fileUrl;
                if (filePath.startsWith("file://")) {
                    filePath = filePath.substring(7);
                }
                is = new java.io.FileInputStream(filePath);
            }

            try (is; XWPFDocument document = new XWPFDocument(is)) {
                return parseWordDocument(document);
            }
        } catch (Exception e) {
            throw new RuntimeException("Word文件解析失败: " + e.getMessage(), e);
        } finally {
            if (tempFile != null) {
                try { Files.deleteIfExists(tempFile); } catch (IOException ignored) {}
            }
        }
    }

    private ParsedBook parseWordDocument(XWPFDocument document) {
        String title = extractTitle(document);
        String author = extractAuthor(document);
        
        List<ParsedBook.ParsedChapter> chapters = new ArrayList<>();
        StringBuilder currentChapterContent = new StringBuilder();
        String currentChapterTitle = "序章";
        int chapterIndex = 0;
        
        for (IBodyElement element : document.getBodyElements()) {
            if (element instanceof XWPFParagraph) {
                XWPFParagraph paragraph = (XWPFParagraph) element;
                String text = paragraph.getText().trim();
                
                if (text.isEmpty()) continue;
                
                Matcher matcher = CHAPTER_PATTERN.matcher(text);
                if (matcher.matches() || isHeading(paragraph)) {
                    if (currentChapterContent.length() > 0) {
                        chapters.add(ParsedBook.ParsedChapter.builder()
                                .title(currentChapterTitle)
                                .chapterIndex(chapterIndex++)
                                .content(wrapInHtml(currentChapterContent.toString()))
                                .build());
                        currentChapterContent = new StringBuilder();
                    }
                    currentChapterTitle = text;
                } else {
                    currentChapterContent.append("<p>")
                            .append(escapeHtml(text))
                            .append("</p>\n");
                }
            } else if (element instanceof XWPFTable) {
                XWPFTable table = (XWPFTable) element;
                currentChapterContent.append(parseTable(table));
            }
        }
        
        if (currentChapterContent.length() > 0) {
            chapters.add(ParsedBook.ParsedChapter.builder()
                    .title(currentChapterTitle)
                    .chapterIndex(chapterIndex)
                    .content(wrapInHtml(currentChapterContent.toString()))
                    .build());
        }
        
        return ParsedBook.builder()
                .title(title)
                .author(author)
                .coverUrl(null)
                .chapters(chapters)
                .build();
    }

    private String extractTitle(XWPFDocument document) {
        if (document.getProperties() != null && 
            document.getProperties().getCoreProperties() != null) {
            String title = document.getProperties().getCoreProperties().getTitle();
            if (title != null && !title.trim().isEmpty()) {
                return title;
            }
        }
        
        for (XWPFParagraph paragraph : document.getParagraphs()) {
            String text = paragraph.getText().trim();
            if (!text.isEmpty() && text.length() < 100) {
                return text;
            }
        }
        
        return "未命名文档";
    }

    private String extractAuthor(XWPFDocument document) {
        if (document.getProperties() != null && 
            document.getProperties().getCoreProperties() != null) {
            String creator = document.getProperties().getCoreProperties().getCreator();
            if (creator != null && !creator.trim().isEmpty()) {
                return creator;
            }
        }
        return "未知作者";
    }

    private boolean isHeading(XWPFParagraph paragraph) {
        String style = paragraph.getStyle();
        return style != null && (style.toLowerCase().contains("heading") || 
                                 style.toLowerCase().contains("标题"));
    }

    private String parseTable(XWPFTable table) {
        StringBuilder html = new StringBuilder("<table>\n");
        
        for (XWPFTableRow row : table.getRows()) {
            html.append("<tr>\n");
            for (XWPFTableCell cell : row.getTableCells()) {
                html.append("<td>").append(escapeHtml(cell.getText())).append("</td>\n");
            }
            html.append("</tr>\n");
        }
        
        html.append("</table>\n");
        return html.toString();
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
