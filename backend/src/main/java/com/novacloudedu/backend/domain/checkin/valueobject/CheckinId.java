package com.novacloudedu.backend.domain.checkin.valueobject;

/**
 * 打卡记录ID值对象
 */
public record CheckinId(Long value) {
    
    public static CheckinId of(Long value) {
        if (value == null || value <= 0) {
            throw new IllegalArgumentException("打卡记录ID不能为空或负数");
        }
        return new CheckinId(value);
    }
}
