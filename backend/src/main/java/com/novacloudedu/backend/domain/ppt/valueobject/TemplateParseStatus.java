package com.novacloudedu.backend.domain.ppt.valueobject;

import lombok.Getter;

/**
 * PPT模板解析状态
 */
@Getter
public enum TemplateParseStatus {

    PENDING("pending", "待解析"),
    PARSING("parsing", "解析中"),
    READY("ready", "解析完成"),
    FAILED("failed", "解析失败");

    private final String code;
    private final String description;

    TemplateParseStatus(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static TemplateParseStatus fromCode(String code) {
        if (code == null || code.isBlank()) {
            return PENDING;
        }
        for (TemplateParseStatus status : values()) {
            if (status.code.equals(code)) {
                return status;
            }
        }
        return PENDING;
    }
}
