package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.livestream.entity.LiveRoom;
import com.novacloudedu.backend.domain.livestream.valueobject.*;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.LiveRoomPO;
import org.springframework.stereotype.Component;

/**
 * 直播间转换器
 */
@Component
public class LiveRoomConverter {

    public LiveRoom toDomain(LiveRoomPO po) {
        if (po == null) {
            return null;
        }
        return LiveRoom.reconstruct(
                LiveRoomId.of(po.getId()),
                po.getTitle(),
                po.getDescription(),
                po.getCoverUrl(),
                UserId.of(po.getHostUserId()),
                po.getClassId(),
                StreamKey.of(po.getStreamKey()),
                LiveRoomStatus.fromValue(po.getStatus()),
                LiveRoomVisibility.fromValue(po.getVisibility()),
                po.getViewerCount() != null ? po.getViewerCount() : 0,
                po.getPeakViewers() != null ? po.getPeakViewers() : 0,
                po.getStartedAt(),
                po.getEndedAt(),
                po.getDuration(),
                po.getIsRecording() != null && po.getIsRecording(),
                po.getPlaybackUrl(),
                po.getCreateTime(),
                po.getUpdateTime(),
                po.getIsDelete() != null && po.getIsDelete() == 1
        );
    }

    public LiveRoomPO toPO(LiveRoom domain) {
        if (domain == null) {
            return null;
        }
        LiveRoomPO po = new LiveRoomPO();
        if (domain.getId() != null) {
            po.setId(domain.getId().value());
        }
        po.setTitle(domain.getTitle());
        po.setDescription(domain.getDescription());
        po.setCoverUrl(domain.getCoverUrl());
        po.setHostUserId(domain.getHostUserId().value());
        po.setClassId(domain.getClassId());
        po.setStreamKey(domain.getStreamKey().value());
        po.setStatus(domain.getStatus().getValue());
        po.setVisibility(domain.getVisibility().getValue());
        po.setViewerCount(domain.getViewerCount());
        po.setPeakViewers(domain.getPeakViewers());
        po.setStartedAt(domain.getStartedAt());
        po.setEndedAt(domain.getEndedAt());
        po.setDuration(domain.getDuration());
        po.setIsRecording(domain.isRecording());
        po.setPlaybackUrl(domain.getPlaybackUrl());
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }
}
