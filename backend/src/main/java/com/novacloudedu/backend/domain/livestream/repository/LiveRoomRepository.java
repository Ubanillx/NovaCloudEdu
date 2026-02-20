package com.novacloudedu.backend.domain.livestream.repository;

import com.novacloudedu.backend.domain.livestream.entity.LiveRoom;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomId;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomStatus;
import com.novacloudedu.backend.domain.livestream.valueobject.StreamKey;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 直播间仓储接口
 */
public interface LiveRoomRepository {

    /**
     * 保存直播间
     */
    LiveRoom save(LiveRoom room);

    /**
     * 更新直播间
     */
    void update(LiveRoom room);

    /**
     * 根据ID查找
     */
    Optional<LiveRoom> findById(LiveRoomId id);

    /**
     * 根据推流密钥查找
     */
    Optional<LiveRoom> findByStreamKey(StreamKey streamKey);

    /**
     * 根据主播ID查找
     */
    List<LiveRoom> findByHostUserId(UserId hostUserId);

    /**
     * 分页查询直播间列表
     */
    RoomPage findAll(LiveRoomStatus status, int pageNum, int pageSize);

    /**
     * 按班级ID查询
     */
    RoomPage findByClassId(Long classId, LiveRoomStatus status, int pageNum, int pageSize);

    /**
     * 按主播ID分页查询
     */
    RoomPage findByHostUserId(UserId hostUserId, int pageNum, int pageSize);

    /**
     * 删除（逻辑删除）
     */
    void delete(LiveRoomId id);

    /**
     * 分页结果
     */
    record RoomPage(List<LiveRoom> rooms, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
