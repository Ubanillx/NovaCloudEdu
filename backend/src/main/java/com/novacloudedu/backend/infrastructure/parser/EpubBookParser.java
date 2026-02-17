package com.novacloudedu.backend.infrastructure.parser;

import com.novacloudedu.backend.domain.book.service.BookParser;
import com.novacloudedu.backend.domain.book.service.ParsedBook;
import com.novacloudedu.backend.domain.book.valueobject.FileType;
import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.domain.file.valueobject.FileBusinessType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipFile;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Entities;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.*;

@Slf4j
@Component
@RequiredArgsConstructor
public class EpubBookParser implements BookParser {

    private final OssService ossService;

    @Override
    public boolean supports(FileType fileType) {
        return fileType == FileType.EPUB;
    }

    @Override
    public ParsedBook parse(String fileUrl) {
        Path tempFile = null;
        try {
            Path sourcePath;

            if (fileUrl.startsWith("http://") || fileUrl.startsWith("https://")) {
                tempFile = Files.createTempFile("book_epub_", ".epub");
                try (InputStream in = URI.create(fileUrl).toURL().openStream()) {
                    Files.copy(in, tempFile, StandardCopyOption.REPLACE_EXISTING);
                }
                sourcePath = tempFile;
            } else {
                String filePath = fileUrl;
                if (filePath.startsWith("file://")) {
                    filePath = filePath.substring(7);
                }
                sourcePath = Path.of(filePath);
            }

            return parseEpubFile(sourcePath);
        } catch (Exception e) {
            throw new RuntimeException("EPUB文件解析失败: " + e.getMessage(), e);
        } finally {
            if (tempFile != null) {
                try { Files.deleteIfExists(tempFile); } catch (IOException ignored) {}
            }
        }
    }

    private ParsedBook parseEpubFile(Path epubPath) throws Exception {
        try (ZipFile zipFile = new ZipFile(epubPath.toFile())) {
            Map<String, String> metadata = extractMetadata(zipFile);
            List<String> contentFiles = extractContentOrder(zipFile);
            Map<String, String> tocTitles = extractTocTitles(zipFile);
            List<ParsedBook.ParsedChapter> chapters = parseChapters(zipFile, contentFiles, tocTitles);
            
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

    /**
     * 从 NCX 目录文件或 EPUB3 NAV 文档中提取章节标题映射（文件路径 -> 标题）
     */
    private Map<String, String> extractTocTitles(ZipFile zipFile) {
        Map<String, String> tocMap = new LinkedHashMap<>();

        try {
            ZipArchiveEntry opfEntry = findOpfFile(zipFile);
            if (opfEntry == null) return tocMap;

            String opfDir = opfEntry.getName().contains("/") ?
                    opfEntry.getName().substring(0, opfEntry.getName().lastIndexOf("/") + 1) : "";

            String opfContent;
            try (InputStream is = zipFile.getInputStream(opfEntry)) {
                opfContent = new String(is.readAllBytes(), "UTF-8");
            }
            Document opfDoc = Jsoup.parse(opfContent, "", org.jsoup.parser.Parser.xmlParser());

            // 尝试 EPUB2: 从 NCX 文件提取
            Element ncxItem = opfDoc.selectFirst("manifest item[media-type=application/x-dtbncx+xml]");
            if (ncxItem != null) {
                String ncxHref = opfDir + ncxItem.attr("href");
                ZipArchiveEntry ncxEntry = zipFile.getEntry(ncxHref);
                if (ncxEntry != null) {
                    try (InputStream ncxIs = zipFile.getInputStream(ncxEntry)) {
                        String ncxContent = new String(ncxIs.readAllBytes(), "UTF-8");
                        Document ncxDoc = Jsoup.parse(ncxContent, "", org.jsoup.parser.Parser.xmlParser());
                        String ncxDir = ncxHref.contains("/") ?
                                ncxHref.substring(0, ncxHref.lastIndexOf("/") + 1) : "";

                        for (Element navPoint : ncxDoc.select("navPoint")) {
                            Element textElem = navPoint.selectFirst("navLabel text");
                            Element contentElem = navPoint.selectFirst("content");
                            if (textElem != null && contentElem != null) {
                                String title = textElem.text().trim();
                                String src = contentElem.attr("src");
                                // 去掉锚点 (#section1)
                                if (src.contains("#")) src = src.substring(0, src.indexOf("#"));
                                String fullPath = ncxDir + src;
                                if (!title.isEmpty()) {
                                    tocMap.put(fullPath, title);
                                }
                            }
                        }
                    }
                }
            }

            // 尝试 EPUB3: 从 NAV 文档提取（如果 NCX 没有结果）
            if (tocMap.isEmpty()) {
                Element navItem = opfDoc.selectFirst("manifest item[properties~=nav]");
                if (navItem != null) {
                    String navHref = opfDir + navItem.attr("href");
                    ZipArchiveEntry navEntry = zipFile.getEntry(navHref);
                    if (navEntry != null) {
                        try (InputStream navIs = zipFile.getInputStream(navEntry)) {
                            String navContent = new String(navIs.readAllBytes(), "UTF-8");
                            Document navDoc = Jsoup.parse(navContent, "", org.jsoup.parser.Parser.xmlParser());
                            String navDir = navHref.contains("/") ?
                                    navHref.substring(0, navHref.lastIndexOf("/") + 1) : "";

                            Element tocNav = navDoc.selectFirst("nav[epub|type=toc], nav[type=toc]");
                            if (tocNav == null) tocNav = navDoc.selectFirst("nav");
                            if (tocNav != null) {
                                for (Element a : tocNav.select("a[href]")) {
                                    String title = a.text().trim();
                                    String href = a.attr("href");
                                    if (href.contains("#")) href = href.substring(0, href.indexOf("#"));
                                    String fullPath = navDir + href;
                                    if (!title.isEmpty()) {
                                        tocMap.put(fullPath, title);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("提取目录失败: " + e.getMessage());
        }

        return tocMap;
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

    private List<ParsedBook.ParsedChapter> parseChapters(ZipFile zipFile, List<String> contentFiles, Map<String, String> tocTitles) {
        List<ParsedBook.ParsedChapter> chapters = new ArrayList<>();
        int chapterIndex = 0;
        
        for (String contentFile : contentFiles) {
            try {
                ZipArchiveEntry entry = zipFile.getEntry(contentFile);
                if (entry == null || entry.isDirectory()) continue;
                
                try (InputStream is = zipFile.getInputStream(entry)) {
                    String html = new String(is.readAllBytes(), "UTF-8");
                    boolean isXhtml = contentFile.toLowerCase().endsWith(".xhtml");
                    // XHTML 用 XML parser 以保留 MathML (<math>) 和 SVG 命名空间标签
                    Document doc = isXhtml
                            ? Jsoup.parse(html, "", Parser.xmlParser())
                            : Jsoup.parse(html);
                    
                    // 提取内嵌图片上传 OSS 并替换相对路径为 OSS URL
                    processImages(doc, zipFile, contentFile);

                    // 优先从目录(NCX/NAV)获取标题，其次从HTML标签，最后用序号
                    String title = tocTitles.get(contentFile);
                    if (title == null || title.isEmpty()) {
                        title = extractChapterTitle(doc, chapterIndex);
                    }
                    String content = cleanHtmlContent(doc, isXhtml);
                    
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
        Element titleElem = doc.selectFirst("h1, h2, h3");
        if (titleElem != null && !titleElem.text().trim().isEmpty()) {
            return titleElem.text().trim();
        }
        return "第 " + (index + 1) + " 章";
    }

    /**
     * 提取章节中的内嵌图片，上传到 OSS，并将 src 替换为 OSS URL
     */
    private void processImages(Document doc, ZipFile zipFile, String contentFilePath) {
        if (ossService == null) return;
        String contentDir = contentFilePath.contains("/")
                ? contentFilePath.substring(0, contentFilePath.lastIndexOf("/") + 1)
                : "";

        // 缓存已上传的图片，避免同一图片重复上传
        Map<String, String> uploadedCache = new HashMap<>();

        // 处理 <img src="..."> 标签
        Elements imgElements = doc.select("img[src]");
        for (Element img : imgElements) {
            String src = img.attr("src");
            if (src.startsWith("http://") || src.startsWith("https://") || src.startsWith("data:")) {
                continue;
            }
            String ossUrl = uploadImageFromZip(zipFile, contentDir, src, uploadedCache);
            if (ossUrl != null) {
                img.attr("src", ossUrl);
            }
        }

        // 处理 SVG <image xlink:href="..."> 标签
        Elements svgImages = doc.select("image[xlink:href], image[href]");
        for (Element image : svgImages) {
            String href = image.hasAttr("xlink:href") ? image.attr("xlink:href") : image.attr("href");
            if (href.startsWith("http://") || href.startsWith("https://") || href.startsWith("data:")) {
                continue;
            }
            String ossUrl = uploadImageFromZip(zipFile, contentDir, href, uploadedCache);
            if (ossUrl != null) {
                if (image.hasAttr("xlink:href")) image.attr("xlink:href", ossUrl);
                if (image.hasAttr("href")) image.attr("href", ossUrl);
            }
        }
    }

    /**
     * 从 EPUB ZIP 中读取图片并上传到 OSS
     */
    private String uploadImageFromZip(ZipFile zipFile, String contentDir, String relativeSrc,
                                      Map<String, String> cache) {
        String resolvedPath = resolveImagePath(contentDir, relativeSrc);
        if (cache.containsKey(resolvedPath)) {
            return cache.get(resolvedPath);
        }

        try {
            ZipArchiveEntry imageEntry = zipFile.getEntry(resolvedPath);
            if (imageEntry == null || imageEntry.isDirectory()) {
                log.warn("EPUB图片不存在: {}", resolvedPath);
                return null;
            }

            byte[] imageData;
            try (InputStream imgIs = zipFile.getInputStream(imageEntry)) {
                imageData = imgIs.readAllBytes();
            }

            if (imageData.length == 0) return null;

            String ext = getExtension(resolvedPath);
            String ossUrl = ossService.uploadBytes(imageData, ext, FileBusinessType.BOOK_IMAGE);
            cache.put(resolvedPath, ossUrl);
            log.debug("EPUB图片已上传: {} -> {}", resolvedPath, ossUrl);
            return ossUrl;
        } catch (Exception e) {
            log.warn("EPUB图片上传失败: {}, 原因: {}", resolvedPath, e.getMessage());
            return null;
        }
    }

    /**
     * 解析相对路径，处理 ../images/pic.png 这类路径
     */
    private String resolveImagePath(String contentDir, String relativeSrc) {
        if (!relativeSrc.startsWith("../") && !relativeSrc.startsWith("./")) {
            return contentDir + relativeSrc;
        }
        String[] dirParts = contentDir.split("/");
        String[] srcParts = relativeSrc.split("/");
        List<String> resolved = new ArrayList<>(Arrays.asList(dirParts));
        // 移除末尾空元素
        if (!resolved.isEmpty() && resolved.get(resolved.size() - 1).isEmpty()) {
            resolved.remove(resolved.size() - 1);
        }
        for (String part : srcParts) {
            if ("..".equals(part)) {
                if (!resolved.isEmpty()) resolved.remove(resolved.size() - 1);
            } else if (!"." .equals(part) && !part.isEmpty()) {
                resolved.add(part);
            }
        }
        return String.join("/", resolved);
    }

    private String getExtension(String path) {
        int dotIdx = path.lastIndexOf('.');
        return dotIdx >= 0 ? path.substring(dotIdx) : ".bin";
    }

    private String cleanHtmlContent(Document doc, boolean isXhtml) {
        doc.select("script, style, meta, link").remove();

        if (isXhtml) {
            // XML 模式：设置输出为 XML 语法，防止 MathML 标签被自闭合（如 <mo/> → <mo></mo>）
            doc.outputSettings()
                    .syntax(Document.OutputSettings.Syntax.xml)
                    .escapeMode(Entities.EscapeMode.xhtml)
                    .charset("UTF-8");
        }

        // XML parser 没有 body 节点，需要按标签名查找
        Element body = doc.selectFirst("body");
        if (body == null) body = doc.selectFirst("html > body");
        String bodyHtml = (body != null) ? body.html() : doc.html();

        if (bodyHtml == null || bodyHtml.trim().isEmpty()) {
            bodyHtml = doc.html();
        }
        
        return "<div class=\"chapter-content\">\n" + bodyHtml + "\n</div>";
    }
}
