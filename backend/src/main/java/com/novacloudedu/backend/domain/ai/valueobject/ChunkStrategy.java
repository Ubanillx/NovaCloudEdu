package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 文档切分策略
 */
public enum ChunkStrategy {

    /**
     * 固定大小切分 — 按字符数固定切分，最简单
     */
    FIXED("固定大小切分"),

    /**
     * 段落感知切分 — 在段落边界处切分，保证段落完整性
     */
    PARAGRAPH("段落感知切分"),

    /**
     * 标题层级切分 — 基于 Markdown/HTML 标题(#, ##, ###)进行切分
     */
    TITLE("标题层级切分"),

    /**
     * 句法边界切分 — 在句号、问号、感叹号等句法边界处切分
     */
    SENTENCE("句法边界切分"),

    /**
     * 语义切分（推荐） — 综合使用标题、段落、embedding 相似度、句法边界
     */
    SEMANTIC("语义切分");

    private final String description;

    ChunkStrategy(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
