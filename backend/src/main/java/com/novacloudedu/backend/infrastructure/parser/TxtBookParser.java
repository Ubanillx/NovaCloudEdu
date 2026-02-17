package com.novacloudedu.backend.infrastructure.parser;

import com.novacloudedu.backend.domain.book.service.BookParser;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import org.springframework.stereotype.Component;

import org.mozilla.universalchardet.UniversalDetector;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class TxtBookParser implements BookParser {

    private static final Pattern CHAPTER_PATTERN = Pattern.compile(
            String.join("|",
                    // 第X章/节/回/集/部/卷/篇/幕/话/折/编/讲/课/单元
                    "^第[0-9一二三四五六七八九十百千万零〇０-９]+[章节回集部卷篇幕话折编讲课].*$",
                    // 卷X / 篇X（独立使用）
                    "^[卷篇][0-9一二三四五六七八九十百千万零〇０-９]+.*$",
                    // 序/序章/序言/前言/引子/楔子/后记/尾声/番外/附录/结语/终章/大结局
                    "^(序章?|序言|前言|引子|引言|楔子|后记|尾声|番外|附录|结语|终章|大结局|写在前面|写在最后).*$",
                    // 上/中/下篇、上/中/下部、上/中/下卷、上/中/下册
                    "^[上中下][篇部卷册].*$",
                    // 正文
                    "^正文.*$",
                    // 数字编号: "1." / "1、" / "1 " 开头（至少后跟文字）
                    "^\\d{1,4}[.、，]\\s*\\S+.*$",
                    // 中文数字编号: "一、" / "二、"
                    "^[一二三四五六七八九十百]+[、.]\\s*\\S+.*$",
                    // Chapter / Part / Prologue / Epilogue / Section
                    "^(Chapter|CHAPTER|Part|PART|Prologue|Epilogue|Section|SECTION|Volume|VOLUME)\\s+\\d+.*$",
                    // 第X单元/第X课（教材）
                    "^第[0-9一二三四五六七八九十百千万零〇０-９]+单元.*$",
                    // Lesson X / Unit X
                    "^(Lesson|Unit)\\s+\\d+.*$"
            ),
            Pattern.CASE_INSENSITIVE | Pattern.MULTILINE
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
        byte[] rawBytes;
        try (InputStream is = URI.create(fileUrl).toURL().openStream();
             ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            is.transferTo(baos);
            rawBytes = baos.toByteArray();
        }

        // 自动检测编码
        Charset charset = detectCharset(rawBytes);
        return new String(rawBytes, charset);
    }

    private Charset detectCharset(byte[] data) {
        // BOM 检测
        if (data.length >= 3 && data[0] == (byte) 0xEF && data[1] == (byte) 0xBB && data[2] == (byte) 0xBF) {
            return StandardCharsets.UTF_8;
        }
        if (data.length >= 2 && data[0] == (byte) 0xFF && data[1] == (byte) 0xFE) {
            return StandardCharsets.UTF_16LE;
        }
        if (data.length >= 2 && data[0] == (byte) 0xFE && data[1] == (byte) 0xFF) {
            return StandardCharsets.UTF_16BE;
        }

        // juniversalchardet 流式检测
        UniversalDetector detector = new UniversalDetector(null);
        detector.handleData(data, 0, data.length);
        detector.dataEnd();
        String detected = detector.getDetectedCharset();
        detector.reset();

        if (detected != null) {
            try {
                return Charset.forName(detected);
            } catch (Exception ignored) {}
        }

        // 默认 UTF-8
        return StandardCharsets.UTF_8;
    }

    private static final int FALLBACK_LINES_PER_CHAPTER = 500;

    private ParsedBook parseContent(String content) {
        String[] lines = content.split("\n");
        List<ParsedBook.ParsedChapter> chapters = parseByPattern(lines);

        // 兜底：没有匹配到章节标题，或整本书只有1章且行数很多，按固定行数分章
        if (chapters.size() <= 1 && lines.length > FALLBACK_LINES_PER_CHAPTER) {
            chapters = splitByLineCount(lines);
        }

        String title = extractTitle(content);

        return ParsedBook.builder()
                .title(title)
                .author("未知作者")
                .coverUrl(null)
                .chapters(chapters)
                .build();
    }

    private List<ParsedBook.ParsedChapter> parseByPattern(String[] lines) {
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
        return chapters;
    }

    private List<ParsedBook.ParsedChapter> splitByLineCount(String[] lines) {
        List<ParsedBook.ParsedChapter> chapters = new ArrayList<>();
        StringBuilder currentContent = new StringBuilder();
        int chapterIndex = 0;
        int lineCount = 0;

        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty()) continue;

            currentContent.append("<p>").append(escapeHtml(line)).append("</p>\n");
            lineCount++;

            if (lineCount >= FALLBACK_LINES_PER_CHAPTER) {
                chapters.add(ParsedBook.ParsedChapter.builder()
                        .title("第 " + (chapterIndex + 1) + " 章")
                        .chapterIndex(chapterIndex++)
                        .content(wrapInHtml(currentContent.toString()))
                        .build());
                currentContent = new StringBuilder();
                lineCount = 0;
            }
        }

        if (currentContent.length() > 0) {
            chapters.add(ParsedBook.ParsedChapter.builder()
                    .title("第 " + (chapterIndex + 1) + " 章")
                    .chapterIndex(chapterIndex)
                    .content(wrapInHtml(currentContent.toString()))
                    .build());
        }
        return chapters;
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
