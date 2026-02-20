package com.novacloudedu.backend.domain.livestream.repository;

import com.novacloudedu.backend.domain.livestream.entity.LiveRoomMessage;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomId;

import java.util.List;

/**
 * 直播间消息仓储接口
 */
public interface LiveRoomMessageRepository {

    /**
     * 保存消息
     */
    LiveRoomMessage save(LiveRoomMessage message);

    /**
     * 分页查询消息
     */
    MessagePage findByRoomId(LiveRoomId roomId, int pageNum, int pageSize);

    /**
     * 消息分页结果
     */
    record MessagePage(List<LiveRoomMessage> messages, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
