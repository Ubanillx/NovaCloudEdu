package com.novacloudedu.backend.domain.book.valueobject;

import lombok.Getter;

@Getter
public enum FileType {
    EPUB("EPUB", "电子书格式"),
    DOCX("DOCX", "Word文档"),
    TXT("TXT", "纯文本"),
    PDF("PDF", "PDF文档");

    private final String code;
    private final String description;

    FileType(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static FileType fromCode(String code) {
        for (FileType type : values()) {
            if (type.code.equalsIgnoreCase(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("不支持的文件类型: " + code);
    }

    public static FileType fromExtension(String extension) {
        String ext = extension.toLowerCase().replace(".", "");
        return switch (ext) {
            case "epub" -> EPUB;
            case "docx", "doc" -> DOCX;
            case "txt" -> TXT;
            case "pdf" -> PDF;
            default -> throw new IllegalArgumentException("不支持的文件扩展名: " + extension);
        };
    }
}
