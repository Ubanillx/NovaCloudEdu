package com.novacloudedu.backend.infrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.novacloudedu.backend.domain.livestream.entity.LiveRoom;
import com.novacloudedu.backend.domain.livestream.repository.LiveRoomRepository;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomId;
import com.novacloudedu.backend.domain.livestream.valueobject.LiveRoomStatus;
import com.novacloudedu.backend.domain.livestream.valueobject.StreamKey;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.converter.LiveRoomConverter;
import com.novacloudedu.backend.infrastructure.persistence.mapper.LiveRoomMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.LiveRoomPO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 直播间仓储实现
 */
@Repository
@RequiredArgsConstructor
public class LiveRoomRepositoryImpl implements LiveRoomRepository {

    private final LiveRoomMapper liveRoomMapper;
    private final LiveRoomConverter converter;

    @Override
    public LiveRoom save(LiveRoom room) {
        LiveRoomPO po = converter.toPO(room);
        liveRoomMapper.insert(po);
        room.assignId(LiveRoomId.of(po.getId()));
        return room;
    }

    @Override
    public void update(LiveRoom room) {
        LiveRoomPO po = converter.toPO(room);
        liveRoomMapper.updateById(po);
    }

    @Override
    public Optional<LiveRoom> findById(LiveRoomId id) {
        LiveRoomPO po = liveRoomMapper.selectById(id.value());
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public Optional<LiveRoom> findByStreamKey(StreamKey streamKey) {
        LambdaQueryWrapper<LiveRoomPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(LiveRoomPO::getStreamKey, streamKey.value());
        LiveRoomPO po = liveRoomMapper.selectOne(wrapper);
        return Optional.ofNullable(converter.toDomain(po));
    }

    @Override
    public List<LiveRoom> findByHostUserId(UserId hostUserId) {
        LambdaQueryWrapper<LiveRoomPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(LiveRoomPO::getHostUserId, hostUserId.value())
               .orderByDesc(LiveRoomPO::getCreateTime);
        return liveRoomMapper.selectList(wrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public RoomPage findAll(LiveRoomStatus status, int pageNum, int pageSize) {
        Page<LiveRoomPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<LiveRoomPO> wrapper = new LambdaQueryWrapper<>();
        if (status != null) {
            wrapper.eq(LiveRoomPO::getStatus, status.getValue());
        }
        wrapper.orderByDesc(LiveRoomPO::getCreateTime);
        Page<LiveRoomPO> result = liveRoomMapper.selectPage(page, wrapper);

        List<LiveRoom> rooms = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new RoomPage(rooms, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public RoomPage findByClassId(Long classId, LiveRoomStatus status, int pageNum, int pageSize) {
        Page<LiveRoomPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<LiveRoomPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(LiveRoomPO::getClassId, classId);
        if (status != null) {
            wrapper.eq(LiveRoomPO::getStatus, status.getValue());
        }
        wrapper.orderByDesc(LiveRoomPO::getCreateTime);
        Page<LiveRoomPO> result = liveRoomMapper.selectPage(page, wrapper);

        List<LiveRoom> rooms = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new RoomPage(rooms, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public RoomPage findByHostUserId(UserId hostUserId, int pageNum, int pageSize) {
        Page<LiveRoomPO> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<LiveRoomPO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(LiveRoomPO::getHostUserId, hostUserId.value())
               .orderByDesc(LiveRoomPO::getCreateTime);
        Page<LiveRoomPO> result = liveRoomMapper.selectPage(page, wrapper);

        List<LiveRoom> rooms = result.getRecords().stream()
                .map(converter::toDomain)
                .toList();
        return new RoomPage(rooms, result.getTotal(), pageNum, pageSize);
    }

    @Override
    public void delete(LiveRoomId id) {
        liveRoomMapper.deleteById(id.value());
    }
}
