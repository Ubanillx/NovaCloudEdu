package com.novacloudedu.backend.domain.livestream.entity;

import com.novacloudedu.backend.domain.livestream.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

/**
 * 直播间聚合根
 */
@Getter
public class LiveRoom {

    private LiveRoomId id;
    private String title;
    private String description;
    private String coverUrl;
    private UserId hostUserId;
    private Long classId;
    private StreamKey streamKey;
    private LiveRoomStatus status;
    private LiveRoomVisibility visibility;
    private int viewerCount;
    private int peakViewers;
    private LocalDateTime startedAt;
    private LocalDateTime endedAt;
    private Integer duration;
    private boolean isRecording;
    private String playbackUrl;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    private LiveRoom() {}

    /**
     * 创建公开直播间
     */
    public static LiveRoom createPublic(String title, String description, String coverUrl, UserId hostUserId) {
        LiveRoom room = new LiveRoom();
        room.title = title;
        room.description = description;
        room.coverUrl = coverUrl;
        room.hostUserId = hostUserId;
        room.streamKey = StreamKey.generate();
        room.status = LiveRoomStatus.CREATED;
        room.visibility = LiveRoomVisibility.PUBLIC;
        room.viewerCount = 0;
        room.peakViewers = 0;
        room.isRecording = false;
        room.isDelete = false;
        room.createTime = LocalDateTime.now();
        room.updateTime = LocalDateTime.now();
        return room;
    }

    /**
     * 创建班级专属直播间
     */
    public static LiveRoom createClassOnly(String title, String description, String coverUrl,
                                            UserId hostUserId, Long classId) {
        LiveRoom room = createPublic(title, description, coverUrl, hostUserId);
        room.classId = classId;
        room.visibility = LiveRoomVisibility.CLASS_ONLY;
        return room;
    }

    /**
     * 重建（从数据库恢复）
     */
    public static LiveRoom reconstruct(LiveRoomId id, String title, String description, String coverUrl,
                                        UserId hostUserId, Long classId, StreamKey streamKey,
                                        LiveRoomStatus status, LiveRoomVisibility visibility,
                                        int viewerCount, int peakViewers,
                                        LocalDateTime startedAt, LocalDateTime endedAt, Integer duration,
                                        boolean isRecording, String playbackUrl,
                                        LocalDateTime createTime, LocalDateTime updateTime, boolean isDelete) {
        LiveRoom room = new LiveRoom();
        room.id = id;
        room.title = title;
        room.description = description;
        room.coverUrl = coverUrl;
        room.hostUserId = hostUserId;
        room.classId = classId;
        room.streamKey = streamKey;
        room.status = status;
        room.visibility = visibility;
        room.viewerCount = viewerCount;
        room.peakViewers = peakViewers;
        room.startedAt = startedAt;
        room.endedAt = endedAt;
        room.duration = duration;
        room.isRecording = isRecording;
        room.playbackUrl = playbackUrl;
        room.createTime = createTime;
        room.updateTime = updateTime;
        room.isDelete = isDelete;
        return room;
    }

    /**
     * 分配ID
     */
    public void assignId(LiveRoomId id) {
        this.id = id;
    }

    /**
     * 开始直播
     */
    public void goLive() {
        this.status = LiveRoomStatus.LIVE;
        this.startedAt = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 结束直播
     */
    public void endLive() {
        this.status = LiveRoomStatus.ENDED;
        this.endedAt = LocalDateTime.now();
        if (this.startedAt != null) {
            this.duration = (int) ChronoUnit.SECONDS.between(this.startedAt, this.endedAt);
        }
        this.viewerCount = 0;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加观众
     */
    public void incrementViewer() {
        this.viewerCount++;
        if (this.viewerCount > this.peakViewers) {
            this.peakViewers = this.viewerCount;
        }
    }

    /**
     * 减少观众
     */
    public void decrementViewer() {
        if (this.viewerCount > 0) {
            this.viewerCount--;
        }
    }

    /**
     * 更新信息
     */
    public void updateInfo(String title, String description, String coverUrl) {
        if (title != null && !title.isBlank()) {
            this.title = title;
        }
        this.description = description;
        this.coverUrl = coverUrl;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 重新生成推流密钥
     */
    public void regenerateStreamKey() {
        this.streamKey = StreamKey.generate();
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 软删除
     */
    public void delete() {
        this.isDelete = true;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 是否正在直播
     */
    public boolean isLive() {
        return this.status == LiveRoomStatus.LIVE;
    }

    /**
     * 是否是班级专属
     */
    public boolean isClassOnly() {
        return this.visibility == LiveRoomVisibility.CLASS_ONLY;
    }

    /**
     * 是否是主播
     */
    public boolean isHost(UserId userId) {
        return this.hostUserId.equals(userId);
    }
}
