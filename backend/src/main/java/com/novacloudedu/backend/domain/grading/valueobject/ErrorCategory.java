package com.novacloudedu.backend.domain.grading.valueobject;

import lombok.Getter;

@Getter
public enum ErrorCategory {
    CONCEPT_ERROR("CONCEPT_ERROR", "概念错误"),
    CALCULATION_ERROR("CALCULATION_ERROR", "计算错误"),
    READING_ERROR("READING_ERROR", "审题错误"),
    UNIT_ERROR("UNIT_ERROR", "单位错误"),
    STEP_MISSING("STEP_MISSING", "步骤缺失"),
    LOGIC_INCOMPLETE("LOGIC_INCOMPLETE", "逻辑不完整"),
    EXPRESSION_UNCLEAR("EXPRESSION_UNCLEAR", "表达不清"),
    GRAMMAR_ERROR("GRAMMAR_ERROR", "语法错误"),
    SPELLING_ERROR("SPELLING_ERROR", "拼写错误"),
    FORMAT_ERROR("FORMAT_ERROR", "格式错误"),
    KNOWLEDGE_GAP("KNOWLEDGE_GAP", "知识盲区"),
    CARELESS_MISTAKE("CARELESS_MISTAKE", "粗心大意");

    private final String code;
    private final String description;

    ErrorCategory(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static ErrorCategory fromCode(String code) {
        for (ErrorCategory category : values()) {
            if (category.code.equals(code)) {
                return category;
            }
        }
        return null;
    }

    public static String getDescription(String code) {
        ErrorCategory cat = fromCode(code);
        return cat != null ? cat.description : code;
    }
}
