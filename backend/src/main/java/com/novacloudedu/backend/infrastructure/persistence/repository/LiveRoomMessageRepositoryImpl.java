package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.livestream.entity.LiveRoomMessage;
import com.novacloudedu.backend.domain.livestream.repository.LiveRoomMessageRepository;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomId;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomMessageId;
import com.novacloudedu.backend.infrastructure.persistence.converter.LiveRoomMessageConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.LiveRoomMessageMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.LiveRoomMessagePO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 直播间消息仓储实现
 */
@Repository
@RequiredArgsConstructor
public class LiveRoomMessageRepositoryImpl implements LiveRoomMessageRepository {

    private final LiveRoomMessageMapper messageMapper;
    private final LiveRoomMessageConverter converter;

    @Override
    public LiveRoomMessage save(LiveRoomMessage message) {
        LiveRoomMessagePO po = converter.toPO(message);
        messageMapper.insert(po);
        message.assignId(LiveRoomMessageId.of(po.getId()));
        return message;
    }

    @Override
    public MessagePage findByRoomId(LiveRoomId roomId, int pageNum, int pageSize) {
        Page<LiveRoomMessagePO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<LiveRoomMessagePO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(LiveRoomMessagePO::getRoomId, roomId.value())
               .orderByDesc(LiveRoomMessagePO::getCreateTime);
        Page<LiveRoomMessagePO> result = messageMapper.selectPage(page, wrapper);

        List<LiveRoomMessage> messages = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new MessagePage(messages, result.getTotal(), pageNum, pageSize);
    }
}
