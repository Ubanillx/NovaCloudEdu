package com.novacloudedu.backend.domain.scraper.valueobject;

import lombok.Getter;

/**
 * 抓取任务状态
 */
@Getter
public enum ScraperStatus {

    PENDING(0, "待执行"),
    RUNNING(1, "执行中"),
    SUCCESS(2, "成功"),
    FAILED(3, "失败"),
    PARTIAL(4, "部分成功");

    private final int code;
    private final String description;

    ScraperStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static ScraperStatus fromCode(int code) {
        for (ScraperStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        return PENDING;
    }
}
