package com.novacloudedu.backend.domain.ppt.valueobject;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * PPT结构化大纲JSON模型
 * <p>
 * 示例结构：
 * <pre>
 * {
 *   "title": "AI在教育领域的应用",
 *   "speaker": "张三",
 *   "pageCount": 20,
 *   "sections": [
 *     { "type": "cover", "title": "AI在教育领域的应用" },
 *     { "type": "toc", "title": "目录" },
 *     { "type": "chapter", "chapterTitle": "第一章 背景与现状", "pages": [
 *         { "title": "教育数字化转型趋势", "bullets": ["...", "..."] }
 *     ]},
 *     { "type": "ending", "title": "谢谢观看" }
 *   ]
 * }
 * </pre>
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OutlineJson {

    private String title;
    private String speaker;
    private int pageCount;
    private List<Section> sections = new ArrayList<>();

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Section {
        /** cover / toc / chapter / ending */
        private String type;
        /** 节标题（cover/toc/ending使用） */
        private String title;
        /** 章节标题（chapter使用） */
        private String chapterTitle;
        /** 章节下的内容页（chapter使用） */
        private List<Page> pages;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Page {
        private String title;
        private List<String> bullets;
    }

    /**
     * 计算实际总页数
     */
    public int computePageCount() {
        int count = 0;
        for (Section section : sections) {
            if ("chapter".equals(section.getType())) {
                count += section.getPages() != null ? section.getPages().size() : 0;
            } else {
                count++; // cover, toc, ending 各占1页
            }
        }
        return count;
    }
}
