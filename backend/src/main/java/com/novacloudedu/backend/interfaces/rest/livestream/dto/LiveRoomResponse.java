package com.novacloudedu.backend.interfaces.rest.livestream.dto;

import com.novacloudedu.backend.domain.livestream.entity.LiveRoom;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 直播间响应
 */
@Data
@Builder
public class LiveRoomResponse {
    private Long id;
    private String title;
    private String description;
    private String coverUrl;
    private Long hostUserId;
    private Long classId;
    private String status;
    private String visibility;
    private int viewerCount;
    private int peakViewers;
    private LocalDateTime startedAt;
    private LocalDateTime endedAt;
    private Integer duration;
    private boolean isRecording;
    private String playbackUrl;
    private LocalDateTime createTime;

    // 推流信息（仅主播可见）
    private String streamKey;
    private String rtmpUrl;

    // 播放地址
    private String flvPlayUrl;
    private String hlsPlayUrl;

    public static LiveRoomResponse fromDomain(LiveRoom room) {
        return LiveRoomResponse.builder()
                .id(room.getId().value())
                .title(room.getTitle())
                .description(room.getDescription())
                .coverUrl(room.getCoverUrl())
                .hostUserId(room.getHostUserId().value())
                .classId(room.getClassId())
                .status(room.getStatus().getValue())
                .visibility(room.getVisibility().getValue())
                .viewerCount(room.getViewerCount())
                .peakViewers(room.getPeakViewers())
                .startedAt(room.getStartedAt())
                .endedAt(room.getEndedAt())
                .duration(room.getDuration())
                .isRecording(room.isRecording())
                .playbackUrl(room.getPlaybackUrl())
                .createTime(room.getCreateTime())
                .build();
    }

    /**
     * 设置播放地址
     */
    public LiveRoomResponse withPlayUrls(String flvUrl, String hlsUrl) {
        this.flvPlayUrl = flvUrl;
        this.hlsPlayUrl = hlsUrl;
        return this;
    }

    /**
     * 设置推流信息（仅主播可见）
     */
    public LiveRoomResponse withStreamInfo(String streamKey, String rtmpUrl) {
        this.streamKey = streamKey;
        this.rtmpUrl = rtmpUrl;
        return this;
    }
}
