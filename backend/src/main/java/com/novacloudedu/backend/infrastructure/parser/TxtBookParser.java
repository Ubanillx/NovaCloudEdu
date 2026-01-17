package com.novacloudedu.backend.infrastructure.parser;

import com.novacloudedu.backend.domain.book.service.BookParser;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class TxtBookParser implements BookParser {

    private static final Pattern CHAPTER_PATTERN = Pattern.compile(
            "^第[0-9一二三四五六七八九十百千零]+[章节回集部].*$|^Chapter\\s+\\d+.*$",
            Pattern.CASE_INSENSITIVE
    );

    @Override
    public boolean supports(FileType fileType) {
        return fileType == FileType.TXT;
    }

    @Override
    public ParsedBook parse(String fileUrl) {
        try {
            String content = downloadFile(fileUrl);
            return parseContent(content);
        } catch (IOException e) {
            throw new RuntimeException("TXT文件解析失败: " + e.getMessage(), e);
        }
    }

    private String downloadFile(String fileUrl) throws IOException {
        URL url = new URL(fileUrl);
        StringBuilder content = new StringBuilder();
        
        try (InputStream is = url.openStream();
             BufferedReader reader = new BufferedReader(
                     new InputStreamReader(is, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
        }
        
        return content.toString();
    }

    private ParsedBook parseContent(String content) {
        String[] lines = content.split("\n");
        List<ParsedBook.ParsedChapter> chapters = new ArrayList<>();
        
        StringBuilder currentChapterContent = new StringBuilder();
        String currentChapterTitle = "序章";
        int chapterIndex = 0;
        
        for (String line : lines) {
            line = line.trim();
            
            if (line.isEmpty()) {
                continue;
            }
            
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
                currentChapterContent.append("<p>").append(escapeHtml(line)).append("</p>\n");
            }
        }
        
        if (currentChapterContent.length() > 0) {
            chapters.add(ParsedBook.ParsedChapter.builder()
                    .title(currentChapterTitle)
                    .chapterIndex(chapterIndex)
                    .content(wrapInHtml(currentChapterContent.toString()))
                    .build());
        }
        
        String title = extractTitle(content);
        
        return ParsedBook.builder()
                .title(title)
                .author("未知作者")
                .coverUrl(null)
                .chapters(chapters)
                .build();
    }

    private String extractTitle(String content) {
        String[] lines = content.split("\n", 10);
        for (String line : lines) {
            line = line.trim();
            if (!line.isEmpty() && line.length() < 50) {
                return line;
            }
        }
        return "未命名书籍";
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
