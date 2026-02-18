package com.novacloudedu.backend.interfaces.rest.analytics.dto.response;

import lombok.Data;

/**
 * 班级成员排名项
 */
@Data
public class StudentRankingItem {
    private int rank;
    private String userId;
    private String userName;
    private long totalDurationSec;
    private String durationText;
    private long activityCount;
    private double scoreRate;
    private double compositeScore;
}
