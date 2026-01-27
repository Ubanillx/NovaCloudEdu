package com.novacloudedu.backend.domain.ai.valueobject;

/**
 * 文档类型枚举
 */
public enum DocumentType {
    
    PDF("PDF文档", ".pdf"),
    DOCX("Word文档", ".docx"),
    DOC("Word文档", ".doc"),
    TXT("文本文件", ".txt"),
    MD("Markdown文件", ".md"),
    HTML("HTML文件", ".html"),
    URL("网页链接", null);

    private final String description;
    private final String extension;

    DocumentType(String description, String extension) {
        this.description = description;
        this.extension = extension;
    }

    public String getDescription() {
        return description;
    }

    public String getExtension() {
        return extension;
    }

    public static DocumentType fromFileName(String fileName) {
        if (fileName == null) {
            return TXT;
        }
        String lowerName = fileName.toLowerCase();
        for (DocumentType type : values()) {
            if (type.extension != null && lowerName.endsWith(type.extension)) {
                return type;
            }
        }
        return TXT;
    }

    public static DocumentType fromUrl(String url) {
        if (url != null && (url.startsWith("http://") || url.startsWith("https://"))) {
            return URL;
        }
        return fromFileName(url);
    }
}
