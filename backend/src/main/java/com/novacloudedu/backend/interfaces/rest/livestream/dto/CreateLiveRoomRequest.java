package com.novacloudedu.backend.interfaces.rest.livestream.dto;

import lombok.Data;

/**
 * 创建直播间请求
 */
@Data
public class CreateLiveRoomRequest {
    private String title;
    private String description;
    private String coverUrl;
    private Long classId;
    private String visibility;
}
