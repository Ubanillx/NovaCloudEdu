package com.novacloudedu.backend.infrastructure.parser;

import com.novacloudedu.backend.domain.book.service.BookParser;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipFile;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.*;

@Component
public class EpubBookParser implements BookParser {

    @Override
    public boolean supports(FileType fileType) {
        return fileType == FileType.EPUB;
    }

    @Override
    public ParsedBook parse(String fileUrl) {
        try {
            // 处理 file:// 协议的路径
            String filePath = fileUrl;
            if (filePath.startsWith("file://")) {
                filePath = filePath.substring(7);
            }
            
            Path sourcePath = Path.of(filePath);
            return parseEpubFile(sourcePath);
        } catch (Exception e) {
            throw new RuntimeException("EPUB文件解析失败: " + e.getMessage(), e);
        }
    }

    private ParsedBook parseEpubFile(Path epubPath) throws Exception {
        try (ZipFile zipFile = new ZipFile(epubPath.toFile())) {
            Map<String, String> metadata = extractMetadata(zipFile);
            List<String> contentFiles = extractContentOrder(zipFile);
            List<ParsedBook.ParsedChapter> chapters = parseChapters(zipFile, contentFiles);
            
            return ParsedBook.builder()
                    .title(metadata.getOrDefault("title", "未命名书籍"))
                    .author(metadata.getOrDefault("author", "未知作者"))
                    .coverUrl(null)
                    .chapters(chapters)
                    .build();
        }
    }

    private Map<String, String> extractMetadata(ZipFile zipFile) {
        Map<String, String> metadata = new HashMap<>();
        
        try {
            ZipArchiveEntry opfEntry = findOpfFile(zipFile);
            if (opfEntry != null) {
                try (InputStream is = zipFile.getInputStream(opfEntry)) {
                    String opfContent = new String(is.readAllBytes(), "UTF-8");
                    Document doc = Jsoup.parse(opfContent, "", org.jsoup.parser.Parser.xmlParser());
                    
                    Element titleElem = doc.selectFirst("dc\\:title, title");
                    if (titleElem != null) {
                        metadata.put("title", titleElem.text());
                    }
                    
                    Element creatorElem = doc.selectFirst("dc\\:creator, creator");
                    if (creatorElem != null) {
                        metadata.put("author", creatorElem.text());
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("提取元数据失败: " + e.getMessage());
        }
        
        return metadata;
    }

    private ZipArchiveEntry findOpfFile(ZipFile zipFile) {
        Enumeration<ZipArchiveEntry> entries = zipFile.getEntries();
        while (entries.hasMoreElements()) {
            ZipArchiveEntry entry = entries.nextElement();
            if (entry.getName().endsWith(".opf")) {
                return entry;
            }
        }
        return null;
    }

    private List<String> extractContentOrder(ZipFile zipFile) {
        List<String> contentFiles = new ArrayList<>();
        
        try {
            ZipArchiveEntry opfEntry = findOpfFile(zipFile);
            if (opfEntry != null) {
                try (InputStream is = zipFile.getInputStream(opfEntry)) {
                    String opfContent = new String(is.readAllBytes(), "UTF-8");
                    Document doc = Jsoup.parse(opfContent, "", org.jsoup.parser.Parser.xmlParser());
                    
                    String opfDir = opfEntry.getName().contains("/") ? 
                            opfEntry.getName().substring(0, opfEntry.getName().lastIndexOf("/") + 1) : "";
                    
                    doc.select("spine itemref").forEach(itemref -> {
                        String idref = itemref.attr("idref");
                        Element item = doc.selectFirst("manifest item[id=" + idref + "]");
                        if (item != null) {
                            String href = item.attr("href");
                            contentFiles.add(opfDir + href);
                        }
                    });
                }
            }
        } catch (Exception e) {
            System.err.println("提取内容顺序失败: " + e.getMessage());
        }
        
        if (contentFiles.isEmpty()) {
            Enumeration<ZipArchiveEntry> entries = zipFile.getEntries();
            while (entries.hasMoreElements()) {
                ZipArchiveEntry entry = entries.nextElement();
                String name = entry.getName().toLowerCase();
                if ((name.endsWith(".html") || name.endsWith(".xhtml")) && 
                    !entry.isDirectory()) {
                    contentFiles.add(entry.getName());
                }
            }
            Collections.sort(contentFiles);
        }
        
        return contentFiles;
    }

    private List<ParsedBook.ParsedChapter> parseChapters(ZipFile zipFile, List<String> contentFiles) {
        List<ParsedBook.ParsedChapter> chapters = new ArrayList<>();
        int chapterIndex = 0;
        
        for (String contentFile : contentFiles) {
            try {
                ZipArchiveEntry entry = zipFile.getEntry(contentFile);
                if (entry == null || entry.isDirectory()) continue;
                
                try (InputStream is = zipFile.getInputStream(entry)) {
                    String html = new String(is.readAllBytes(), "UTF-8");
                    Document doc = Jsoup.parse(html);
                    
                    String title = extractChapterTitle(doc, chapterIndex);
                    String content = cleanHtmlContent(doc);
                    
                    if (content != null && !content.trim().isEmpty()) {
                        chapters.add(ParsedBook.ParsedChapter.builder()
                                .title(title)
                                .chapterIndex(chapterIndex++)
                                .content(content)
                                .build());
                    }
                }
            } catch (Exception e) {
                System.err.println("解析章节失败 " + contentFile + ": " + e.getMessage());
            }
        }
        
        return chapters;
    }

    private String extractChapterTitle(Document doc, int index) {
        Element titleElem = doc.selectFirst("h1, h2, h3, title");
        if (titleElem != null && !titleElem.text().trim().isEmpty()) {
            return titleElem.text().trim();
        }
        return "第 " + (index + 1) + " 章";
    }

    private String cleanHtmlContent(Document doc) {
        doc.select("script, style, meta, link").remove();
        
        String bodyHtml = doc.select("body").html();
        if (bodyHtml == null || bodyHtml.trim().isEmpty()) {
            bodyHtml = doc.html();
        }
        
        return "<div class=\"chapter-content\">\n" + bodyHtml + "\n</div>";
    }
}
