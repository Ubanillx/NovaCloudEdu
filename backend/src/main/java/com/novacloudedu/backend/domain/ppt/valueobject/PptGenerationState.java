package com.novacloudedu.backend.domain.ppt.valueobject;

import lombok.Getter;

/**
 * PPT生成会话状态
 */
@Getter
public enum PptGenerationState {

    INIT("init", "初始化"),
    GENERATING_OUTLINE("generating_outline", "正在生成大纲"),
    OUTLINE_READY("outline_ready", "大纲已就绪"),
    AWAITING_TEMPLATE("awaiting_template", "等待选择模板"),
    PARSING_TEMPLATE("parsing_template", "正在解析模板"),
    TEMPLATE_READY("template_ready", "模板已解析"),
    GENERATING_SLIDES("generating_slides", "正在逐页生成内容"),
    PREVIEW_EDITING("preview_editing", "预览编辑中"),
    ASSEMBLING("assembling", "正在组装PPT"),
    COMPLETED("completed", "已完成"),
    FAILED("failed", "失败");

    private final String code;
    private final String description;

    PptGenerationState(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static PptGenerationState fromCode(String code) {
        for (PptGenerationState state : values()) {
            if (state.code.equals(code)) {
                return state;
            }
        }
        throw new IllegalArgumentException("未知的生成状态: " + code);
    }
}
