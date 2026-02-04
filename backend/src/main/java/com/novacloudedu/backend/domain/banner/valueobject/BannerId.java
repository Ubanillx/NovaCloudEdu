package com.novacloudedu.backend.domain.banner.valueobject;

/**
 * 轮播图ID值对象
 */
public record BannerId(Long value) {

    public static BannerId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("轮播图ID不能为空或负数");
        }
        return new BannerId(value);
    }
}
