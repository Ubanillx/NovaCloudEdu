package com.novacloudedu.backend.domain.ppt.valueobject;

/**
 * PPT模板ID值对象
 */
public record PptTemplateId(Long value) {

    public static PptTemplateId of(Long value) {
        return new PptTemplateId(value);
    }
}
