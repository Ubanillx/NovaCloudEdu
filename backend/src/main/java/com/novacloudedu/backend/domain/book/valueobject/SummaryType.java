package com.novacloudedu.backend.domain.book.valueobject;

/**
 * 总结类型枚举
 */
public enum SummaryType {
    BRIEF("简短总结"),
    DETAILED("详细总结"),
    KEYPOINTS("要点总结");

    private final String description;

    SummaryType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
