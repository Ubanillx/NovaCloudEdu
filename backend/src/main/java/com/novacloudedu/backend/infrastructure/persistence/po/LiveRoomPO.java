package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 直播间持久化对象
 */
@Data
@TableName("live_room")
public class LiveRoomPO {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String title;
    private String description;
    private String coverUrl;
    private Long hostUserId;
    private Long classId;
    private String streamKey;
    private String status;
    private String visibility;
    private Integer viewerCount;
    private Integer peakViewers;
    private LocalDateTime startedAt;
    private LocalDateTime endedAt;
    private Integer duration;
    private Boolean isRecording;
    private String playbackUrl;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    @TableLogic
    private Integer isDelete;
}
