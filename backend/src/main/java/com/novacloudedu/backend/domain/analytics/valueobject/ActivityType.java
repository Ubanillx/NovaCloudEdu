package com.novacloudedu.backend.domain.analytics.valueobject;

import lombok.Getter;

/**
 * 学习活动类型
 */
@Getter
public enum ActivityType {
    COURSE_WATCH("COURSE_WATCH", "课程观看"),
    WORD_STUDY("WORD_STUDY", "单词学习"),
    ARTICLE_READ("ARTICLE_READ", "文章阅读"),
    HOMEWORK_SUBMIT("HOMEWORK_SUBMIT", "作业提交"),
    CHECKIN("CHECKIN", "打卡签到"),
    EXAM_PRACTICE("EXAM_PRACTICE", "试题练习");

    private final String code;
    private final String description;

    ActivityType(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public static ActivityType fromCode(String code) {
        for (ActivityType type : values()) {
            if (type.code.equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("未知的活动类型: " + code);
    }
}
